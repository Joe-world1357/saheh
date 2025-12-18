import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/theme/app_theme.dart';
import '../../../providers/wearable_provider.dart';
import '../../../providers/home_data_provider.dart';
import 'connect_devices_screen.dart';

/// Comprehensive Wearable & Google Fit Connection Screen
class WearableGoogleFitScreen extends ConsumerStatefulWidget {
  const WearableGoogleFitScreen({super.key});

  @override
  ConsumerState<WearableGoogleFitScreen> createState() => _WearableGoogleFitScreenState();
}

class _WearableGoogleFitScreenState extends ConsumerState<WearableGoogleFitScreen> {
  @override
  void initState() {
    super.initState();
    // Refresh connection status on load
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(wearableConnectionProvider.notifier).refreshStatus();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final brightness = theme.brightness;
    final connectionState = ref.watch(wearableConnectionProvider);
    final connectionNotifier = ref.read(wearableConnectionProvider.notifier);

    return Scaffold(
      backgroundColor: AppColors.getBackground(brightness),
      appBar: AppBar(
        backgroundColor: AppColors.getSurface(brightness),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.getTextPrimary(brightness)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Wearable & Google Fit',
          style: AppTextStyles.titleLarge(brightness),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppTheme.spacingL),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Text(
                'Connect Your Devices',
                style: AppTextStyles.headlineSmall(brightness),
              ),
              const SizedBox(height: AppTheme.spacingS),
              Text(
                'Sync your health data from Google Fit or wearable devices to track your progress automatically.',
                style: AppTextStyles.bodyMedium(brightness).copyWith(
                  color: AppColors.getTextSecondary(brightness),
                ),
              ),
              const SizedBox(height: AppTheme.spacingXL),

              // Google Fit Section
              _buildGoogleFitSection(
                theme: theme,
                brightness: brightness,
                isConnected: connectionState.isGoogleFitConnected,
                isSyncing: connectionState.isSyncing,
                lastSyncTime: connectionState.lastSyncTime,
                onConnect: () async {
                  final success = await connectionNotifier.connectGoogleFit();
                  if (success && mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text('Google Fit connected successfully!'),
                        backgroundColor: AppColors.getSuccess(brightness),
                      ),
                    );
                    // Refresh home data
                    ref.read(homeDataProvider.notifier).refresh();
                  } else if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(connectionState.error ?? 'Failed to connect to Google Fit'),
                        backgroundColor: AppColors.getError(brightness),
                      ),
                    );
                  }
                },
                onDisconnect: () async {
                  await connectionNotifier.disconnectGoogleFit();
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text('Google Fit disconnected'),
                        backgroundColor: AppColors.getInfo(brightness),
                      ),
                    );
                  }
                },
                onSync: () async {
                  final results = await connectionNotifier.syncGoogleFitData();
                  if (mounted) {
                    if (results['success'] == true) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Synced: ${results['steps']} steps, ${results['calories']?.toStringAsFixed(0) ?? 0} calories',
                          ),
                          backgroundColor: AppColors.getSuccess(brightness),
                        ),
                      );
                      // Refresh home data
                      ref.read(homeDataProvider.notifier).refresh();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(results['error'] ?? 'Sync failed'),
                          backgroundColor: AppColors.getError(brightness),
                        ),
                      );
                    }
                  }
                },
              ),

              const SizedBox(height: AppTheme.spacingXL),

              // Wearable Devices Section
              _buildWearableSection(
                theme: theme,
                brightness: brightness,
                isConnected: connectionState.isWearableConnected,
                deviceName: connectionState.connectedDeviceName,
                isSyncing: connectionState.isSyncing,
                lastSyncTime: connectionState.lastSyncTime,
                onConnect: () {
                  // Navigate to device selection
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const ConnectDevicesScreen(),
                    ),
                  );
                },
                onDisconnect: () async {
                  await connectionNotifier.disconnectWearable();
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text('Device disconnected'),
                        backgroundColor: AppColors.getInfo(brightness),
                      ),
                    );
                  }
                },
              ),

              const SizedBox(height: AppTheme.spacingXL),

              // Data Sync Info
              _buildSyncInfoCard(theme, brightness, connectionState),

              const SizedBox(height: AppTheme.spacingXL),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGoogleFitSection({
    required ThemeData theme,
    required Brightness brightness,
    required bool isConnected,
    required bool isSyncing,
    required DateTime? lastSyncTime,
    required VoidCallback onConnect,
    required VoidCallback onDisconnect,
    required VoidCallback onSync,
  }) {
    return Container(
      padding: const EdgeInsets.all(AppTheme.spacingL),
      decoration: BoxDecoration(
        color: AppColors.getSurface(brightness),
        borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
        border: Border.all(color: AppColors.getBorder(brightness)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(AppTheme.spacingM),
                decoration: BoxDecoration(
                  color: AppColors.getPrimary(brightness).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
                ),
                child: Icon(
                  Icons.fitness_center,
                  color: AppColors.getPrimary(brightness),
                  size: 24,
                ),
              ),
              const SizedBox(width: AppTheme.spacingM),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Google Fit',
                      style: AppTextStyles.titleMedium(brightness),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      isConnected ? 'Connected' : 'Not connected',
                      style: AppTextStyles.bodySmall(brightness).copyWith(
                        color: isConnected
                            ? AppColors.getSuccess(brightness)
                            : AppColors.getTextSecondary(brightness),
                      ),
                    ),
                  ],
                ),
              ),
              if (isConnected)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppTheme.spacingM,
                    vertical: AppTheme.spacingS,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.getSuccess(brightness).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.check_circle,
                        color: AppColors.getSuccess(brightness),
                        size: 16,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Active',
                        style: AppTextStyles.labelSmall(brightness).copyWith(
                          color: AppColors.getSuccess(brightness),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
          const SizedBox(height: AppTheme.spacingL),
          if (lastSyncTime != null) ...[
            Text(
              'Last sync: ${_formatDateTime(lastSyncTime)}',
              style: AppTextStyles.bodySmall(brightness).copyWith(
                color: AppColors.getTextSecondary(brightness),
              ),
            ),
            const SizedBox(height: AppTheme.spacingM),
          ],
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: isConnected ? onDisconnect : onConnect,
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: AppTheme.spacingM),
                  ),
                  child: Text(isConnected ? 'Disconnect' : 'Connect'),
                ),
              ),
              if (isConnected) ...[
                const SizedBox(width: AppTheme.spacingM),
                Expanded(
                  child: FilledButton.icon(
                    onPressed: isSyncing ? null : onSync,
                    icon: isSyncing
                        ? const SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(Icons.sync, size: 18),
                    label: Text(isSyncing ? 'Syncing...' : 'Sync Now'),
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: AppTheme.spacingM),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildWearableSection({
    required ThemeData theme,
    required Brightness brightness,
    required bool isConnected,
    required String? deviceName,
    required bool isSyncing,
    required DateTime? lastSyncTime,
    required VoidCallback onConnect,
    required VoidCallback onDisconnect,
  }) {
    return Container(
      padding: const EdgeInsets.all(AppTheme.spacingL),
      decoration: BoxDecoration(
        color: AppColors.getSurface(brightness),
        borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
        border: Border.all(color: AppColors.getBorder(brightness)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(AppTheme.spacingM),
                decoration: BoxDecoration(
                  color: AppColors.getInfo(brightness).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
                ),
                child: Icon(
                  Icons.watch,
                  color: AppColors.getInfo(brightness),
                  size: 24,
                ),
              ),
              const SizedBox(width: AppTheme.spacingM),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Wearable Devices',
                      style: AppTextStyles.titleMedium(brightness),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      isConnected
                          ? (deviceName ?? 'Connected')
                          : 'No device connected',
                      style: AppTextStyles.bodySmall(brightness).copyWith(
                        color: isConnected
                            ? AppColors.getSuccess(brightness)
                            : AppColors.getTextSecondary(brightness),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppTheme.spacingL),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: isConnected ? onDisconnect : onConnect,
              icon: Icon(isConnected ? Icons.link_off : Icons.link),
              label: Text(isConnected ? 'Disconnect Device' : 'Connect Device'),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: AppTheme.spacingM),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSyncInfoCard(
    ThemeData theme,
    Brightness brightness,
    WearableConnectionState state,
  ) {
    return Container(
      padding: const EdgeInsets.all(AppTheme.spacingL),
      decoration: BoxDecoration(
        color: AppColors.getInfo(brightness).withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
        border: Border.all(
          color: AppColors.getInfo(brightness).withOpacity(0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.info_outline,
                color: AppColors.getInfo(brightness),
                size: 20,
              ),
              const SizedBox(width: AppTheme.spacingS),
              Text(
                'What gets synced?',
                style: AppTextStyles.titleSmall(brightness).copyWith(
                  color: AppColors.getInfo(brightness),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppTheme.spacingM),
          _buildSyncItem('Steps', Icons.directions_walk, brightness),
          _buildSyncItem('Heart Rate', Icons.favorite, brightness),
          _buildSyncItem('Calories Burned', Icons.local_fire_department, brightness),
          _buildSyncItem('Sleep Duration', Icons.bedtime, brightness),
          _buildSyncItem('Workout Sessions', Icons.fitness_center, brightness),
          const SizedBox(height: AppTheme.spacingM),
          Text(
            'Synced data automatically updates your XP and achievements!',
            style: AppTextStyles.bodySmall(brightness).copyWith(
              color: AppColors.getInfo(brightness),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSyncItem(String label, IconData icon, Brightness brightness) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppTheme.spacingS),
      child: Row(
        children: [
          Icon(icon, size: 16, color: AppColors.getInfo(brightness)),
          const SizedBox(width: AppTheme.spacingS),
          Text(
            label,
            style: AppTextStyles.bodySmall(brightness).copyWith(
              color: AppColors.getInfo(brightness),
            ),
          ),
        ],
      ),
    );
  }

  String _formatDateTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else {
      return '${difference.inDays}d ago';
    }
  }
}

