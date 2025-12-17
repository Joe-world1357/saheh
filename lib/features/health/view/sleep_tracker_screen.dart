import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/theme/app_theme.dart';
import '../../../providers/health_tracking_provider.dart';

class SleepTrackerScreen extends ConsumerStatefulWidget {
  const SleepTrackerScreen({super.key});

  @override
  ConsumerState<SleepTrackerScreen> createState() => _SleepTrackerScreenState();
}

class _SleepTrackerScreenState extends ConsumerState<SleepTrackerScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  DateTime _bedtime = DateTime.now().subtract(const Duration(hours: 8));
  DateTime _wakeTime = DateTime.now();
  int _sleepQuality = 3;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..forward();
    
    // Load existing data
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final state = ref.read(healthTrackingProvider);
      if (state.todaySleep != null) {
        setState(() {
          _bedtime = state.todaySleep!.bedtime ?? _bedtime;
          _wakeTime = state.todaySleep!.wakeTime ?? _wakeTime;
          _sleepQuality = state.todaySleep!.quality;
        });
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  double get _sleepDuration {
    return _wakeTime.difference(_bedtime).inMinutes / 60.0;
  }

  String get _sleepDurationText {
    final hours = _sleepDuration.floor();
    final minutes = ((_sleepDuration - hours) * 60).round();
    return '${hours}h ${minutes}m';
  }

  Future<void> _selectBedtime() async {
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_bedtime),
    );
    if (time != null) {
      setState(() {
        _bedtime = DateTime(
          _bedtime.year,
          _bedtime.month,
          _bedtime.day,
          time.hour,
          time.minute,
        );
        // If bedtime is after wake time, assume it's the previous day
        if (_bedtime.isAfter(_wakeTime)) {
          _bedtime = _bedtime.subtract(const Duration(days: 1));
        }
      });
    }
  }

  Future<void> _selectWakeTime() async {
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_wakeTime),
    );
    if (time != null) {
      setState(() {
        _wakeTime = DateTime(
          DateTime.now().year,
          DateTime.now().month,
          DateTime.now().day,
          time.hour,
          time.minute,
        );
      });
    }
  }

  Future<void> _saveSleep() async {
    setState(() => _isSaving = true);
    
    final success = await ref.read(healthTrackingProvider.notifier).saveSleep(
      bedtime: _bedtime,
      wakeTime: _wakeTime,
      quality: _sleepQuality,
    );

    setState(() => _isSaving = false);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(success ? 'Sleep data saved! +XP earned' : 'Failed to save'),
          backgroundColor: success ? AppColors.success : AppColors.error,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final state = ref.watch(healthTrackingProvider);
    final timeFormat = DateFormat('h:mm a');

    return Scaffold(
      backgroundColor: AppColors.getBackground(brightness),
      body: SafeArea(
        child: Column(
          children: [
            // App Bar
            Padding(
              padding: const EdgeInsets.all(AppTheme.spacingM),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
                      border: Border.all(color: AppColors.getBorder(brightness)),
                    ),
                    child: IconButton(
                      icon: Icon(Icons.arrow_back_ios_new, 
                        color: AppColors.getTextPrimary(brightness), size: 20),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  const SizedBox(width: AppTheme.spacingM),
                  Text('Sleep Tracker', style: AppTextStyles.titleLarge(brightness)),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: AppTheme.spacingM),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: AppTheme.spacingM),

                    // Sleep Summary Card
                    AnimatedBuilder(
                      animation: _animationController,
                      builder: (context, child) {
                        return Transform.scale(
                          scale: 0.8 + (0.2 * _animationController.value),
                          child: Opacity(
                            opacity: _animationController.value,
                            child: child,
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(AppTheme.spacingL),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFF6C5CE7), Color(0xFF5A4FCF)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
                          boxShadow: AppTheme.elevatedShadow(brightness),
                        ),
                        child: Column(
                          children: [
                            const Icon(Icons.bedtime_rounded, color: Colors.white, size: 56),
                            const SizedBox(height: AppTheme.spacingM),
                            Text(
                              _sleepDurationText,
                              style: AppTextStyles.metricLarge(brightness).copyWith(
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: AppTheme.spacingS),
                            Text(
                              'Sleep Duration',
                              style: AppTextStyles.bodyMedium(brightness).copyWith(
                                color: Colors.white.withOpacity(0.9),
                              ),
                            ),
                            const SizedBox(height: AppTheme.spacingL),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                _buildTimeButton(
                                  'Bedtime',
                                  timeFormat.format(_bedtime),
                                  _selectBedtime,
                                ),
                                Container(
                                  width: 1,
                                  height: 40,
                                  color: Colors.white.withOpacity(0.3),
                                ),
                                _buildTimeButton(
                                  'Wake Time',
                                  timeFormat.format(_wakeTime),
                                  _selectWakeTime,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: AppTheme.spacingL),

                    // Sleep Quality
                    Text('Sleep Quality', style: AppTextStyles.titleMedium(brightness)),
                    const SizedBox(height: AppTheme.spacingM),
                    Container(
                      padding: const EdgeInsets.all(AppTheme.spacingM),
                      decoration: BoxDecoration(
                        color: AppColors.getSurface(brightness),
                        borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
                        border: Border.all(color: AppColors.getBorder(brightness)),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: List.generate(5, (index) {
                              final rating = index + 1;
                              final isSelected = rating <= _sleepQuality;
                              return GestureDetector(
                                onTap: () => setState(() => _sleepQuality = rating),
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 200),
                                  child: Icon(
                                    Icons.star_rounded,
                                    size: 44,
                                    color: isSelected
                                        ? const Color(0xFFFFC107)
                                        : AppColors.getSurfaceVariant(brightness),
                                  ),
                                ),
                              );
                            }),
                          ),
                          const SizedBox(height: AppTheme.spacingM),
                          Text(
                            _getQualityText(_sleepQuality),
                            style: AppTextStyles.labelLarge(brightness).copyWith(
                              color: _getQualityColor(_sleepQuality),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: AppTheme.spacingL),

                    // Weekly Stats
                    Text('This Week', style: AppTextStyles.titleMedium(brightness)),
                    const SizedBox(height: AppTheme.spacingM),
                    Container(
                      padding: const EdgeInsets.all(AppTheme.spacingM),
                      decoration: BoxDecoration(
                        color: AppColors.getSurface(brightness),
                        borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
                        border: Border.all(color: AppColors.getBorder(brightness)),
                      ),
                      child: Column(
                        children: [
                          // Average stats row
                          Row(
                            children: [
                              Expanded(
                                child: _buildStatCard(
                                  'Avg Sleep',
                                  '${state.averageSleepHours.toStringAsFixed(1)}h',
                                  Icons.access_time_rounded,
                                  brightness,
                                ),
                              ),
                              const SizedBox(width: AppTheme.spacingM),
                              Expanded(
                                child: _buildStatCard(
                                  'Avg Quality',
                                  '${state.averageSleepQuality}/5',
                                  Icons.star_rounded,
                                  brightness,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: AppTheme.spacingM),
                          const Divider(),
                          const SizedBox(height: AppTheme.spacingM),
                          // Weekly bars
                          ...List.generate(7, (index) {
                            final dayNames = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
                            final sleep = index < state.weeklySleep.length
                                ? state.weeklySleep[index]
                                : null;
                            final hours = sleep?.duration ?? 0;
                            final progress = hours / 9.0; // 9 hours as max
                            
                            return Padding(
                              padding: const EdgeInsets.only(bottom: AppTheme.spacingS),
                              child: _buildWeekStat(
                                dayNames[index],
                                hours,
                                progress.clamp(0.0, 1.0),
                                brightness,
                              ),
                            );
                          }),
                        ],
                      ),
                    ),

                    const SizedBox(height: AppTheme.spacingL),

                    // XP Info
                    Container(
                      padding: const EdgeInsets.all(AppTheme.spacingM),
                      decoration: BoxDecoration(
                        color: AppColors.getSuccessBackground(brightness),
                        borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.emoji_events_rounded, 
                            color: AppColors.getSuccess(brightness)),
                          const SizedBox(width: AppTheme.spacingM),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('XP Rewards', 
                                  style: AppTextStyles.titleSmall(brightness)),
                                Text(
                                  '7-9 hours sleep = +15 XP | 6+ hours = +5 XP',
                                  style: AppTextStyles.bodySmall(brightness),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: AppTheme.spacingL),

                    // Save Button
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton.icon(
                        onPressed: _isSaving ? null : _saveSleep,
                        icon: _isSaving
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(strokeWidth: 2),
                              )
                            : const Icon(Icons.save_rounded),
                        label: Text(_isSaving ? 'Saving...' : 'Save Sleep Data'),
                      ),
                    ),

                    const SizedBox(height: AppTheme.spacingXL),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeButton(String label, String time, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Text(
            time,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.8),
                  fontSize: 12,
                ),
              ),
              const SizedBox(width: 4),
              Icon(Icons.edit, color: Colors.white.withOpacity(0.8), size: 14),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String label, String value, IconData icon, Brightness brightness) {
    return Container(
      padding: const EdgeInsets.all(AppTheme.spacingM),
      decoration: BoxDecoration(
        color: AppColors.getSurfaceVariant(brightness),
        borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.getPrimary(brightness)),
          const SizedBox(width: AppTheme.spacingS),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(value, style: AppTextStyles.titleSmall(brightness)),
              Text(label, style: AppTextStyles.bodySmall(brightness)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildWeekStat(String day, double hours, double progress, Brightness brightness) {
    return Row(
      children: [
        SizedBox(
          width: 40,
          child: Text(day, style: AppTextStyles.labelMedium(brightness)),
        ),
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 8,
              backgroundColor: AppColors.getSurfaceVariant(brightness),
              valueColor: AlwaysStoppedAnimation<Color>(
                progress >= 0.78 ? AppColors.getSuccess(brightness) : AppColors.getPrimary(brightness),
              ),
            ),
          ),
        ),
        const SizedBox(width: AppTheme.spacingM),
        SizedBox(
          width: 45,
          child: Text(
            '${hours.toStringAsFixed(1)}h',
            style: AppTextStyles.labelMedium(brightness),
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }

  String _getQualityText(int rating) {
    switch (rating) {
      case 1: return 'Very Poor 😫';
      case 2: return 'Poor 😕';
      case 3: return 'Fair 😐';
      case 4: return 'Good 😊';
      case 5: return 'Excellent 😴';
      default: return 'Fair';
    }
  }

  Color _getQualityColor(int rating) {
    switch (rating) {
      case 1: return AppColors.error;
      case 2: return AppColors.warning;
      case 3: return AppColors.info;
      case 4: return AppColors.success;
      case 5: return AppColors.success;
      default: return AppColors.info;
    }
  }
}
