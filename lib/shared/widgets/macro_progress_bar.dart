import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../core/theme/app_colors.dart';

enum MacroType { protein, carbs, fats, calories }

class MacroProgressBar extends StatefulWidget {
  final String macroName;
  final double current;
  final double target;
  final MacroType type;
  final bool showGlow;
  final bool animate;

  const MacroProgressBar({
    super.key,
    required this.macroName,
    required this.current,
    required this.target,
    required this.type,
    this.showGlow = true,
    this.animate = true,
  });

  @override
  State<MacroProgressBar> createState() => _MacroProgressBarState();
}

class _MacroProgressBarState extends State<MacroProgressBar> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _progressAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    final percentage = (widget.current / widget.target).clamp(0.0, 1.0);
    _progressAnimation = Tween<double>(begin: 0.0, end: percentage).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutCubic,
      ),
    );

    if (widget.animate) {
      Future.delayed(const Duration(milliseconds: 100), () {
        if (mounted) {
          _controller.forward();
        }
      });
    } else {
      _controller.value = 1.0;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Color _getMacroColor(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    switch (widget.type) {
      case MacroType.protein:
        return AppColors.getProtein(brightness);
      case MacroType.carbs:
        return AppColors.getCarbs(brightness);
      case MacroType.fats:
        return AppColors.getFats(brightness);
      case MacroType.calories:
        return AppColors.getCalories(brightness);
    }
  }

  Color _getMacroGlow(BuildContext context) {
    return _getMacroColor(context).withOpacity(0.3);
  }

  @override
  Widget build(BuildContext context) {
    final macroColor = _getMacroColor(context);
    final percentage = (widget.current / widget.target * 100).clamp(0, 100);
    final isNearGoal = percentage >= 80 && percentage < 100;
    final isExceeded = percentage > 100;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header Row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Macro Name with Dot
            Row(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: macroColor,
                    shape: BoxShape.circle,
                    boxShadow: widget.showGlow && isNearGoal
                        ? [
                            BoxShadow(
                              color: _getMacroGlow(context),
                              blurRadius: 8,
                              spreadRadius: 1,
                            ),
                          ]
                        : null,
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  widget.macroName,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ],
            ),
            // Current / Target with percentage
            Row(
              children: [
                Text(
                  '${widget.current.toInt()}',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: macroColor,
                      ),
                ),
                Text(
                  ' / ${widget.target.toInt()}${widget.type == MacroType.calories ? '' : 'g'}',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: macroColor.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    '${percentage.toInt()}%',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: macroColor,
                        ),
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 12),

        // Progress Bar with animation
        AnimatedBuilder(
          animation: _progressAnimation,
          builder: (context, child) {
            return Stack(
              children: [
                // Background track
                Container(
                  height: 10,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
                // Filled progress
                FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: _progressAnimation.value,
                  child: Container(
                    height: 10,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          macroColor,
                          macroColor.withOpacity(0.8),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(999),
                      boxShadow: widget.showGlow && isNearGoal
                          ? [
                              BoxShadow(
                                color: _getMacroGlow(context),
                                blurRadius: 12,
                                spreadRadius: 1,
                              ),
                            ]
                          : null,
                    ),
                  ),
                ),
              ],
            );
          },
        ),

        // Status indicator
        if (isExceeded || isNearGoal) ...[
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(
                isExceeded ? Icons.warning_rounded : Icons.check_circle_rounded,
                size: 14,
                color: isExceeded ? AppColors.warning : AppColors.success,
              ),
              const SizedBox(width: 4),
              Text(
                isExceeded
                    ? 'Exceeded by ${(widget.current - widget.target).toInt()}${widget.type == MacroType.calories ? '' : 'g'}'
                    : 'Almost there!',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: isExceeded ? AppColors.warning : AppColors.success,
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ],
          ),
        ],
      ],
    );
  }
}

