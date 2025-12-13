import 'package:flutter/material.dart';

// From NutritionScreen
class MacroProgressBar
    extends
        StatelessWidget {
  final String name;
  final int current;
  final int goal;
  final Color color;

  const MacroProgressBar({
    super.key,
    required this.name,
    required this.current,
    required this.goal,
    required this.color,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(
          width: 12,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      color: Color(
                        0xFF1A2A2C,
                      ),
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "${current}g / ${goal}g",
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 6,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(
                  10,
                ),
                child: LinearProgressIndicator(
                  value:
                      (current /
                              goal)
                          .clamp(
                            0.0,
                            1.0,
                          ),
                  minHeight: 6,
                  backgroundColor: Colors.grey.shade200,
                  valueColor:
                      AlwaysStoppedAnimation<
                        Color
                      >(
                        color,
                      ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
