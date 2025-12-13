import 'package:flutter/material.dart';

// From NutritionScreen
class MealCard
    extends
        StatelessWidget {
  final String name;
  final String time;
  final int calories;
  final int protein;
  final int carbs;
  final int fats;
  final IconData icon;
  final Color color;

  const MealCard({
    super.key,
    required this.name,
    required this.time,
    required this.calories,
    required this.protein,
    required this.carbs,
    required this.fats,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    return Container(
      padding: const EdgeInsets.all(
        16,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(
          16,
        ),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(
              12,
            ),
            decoration: BoxDecoration(
              color: color.withOpacity(
                0.1,
              ),
              borderRadius: BorderRadius.circular(
                12,
              ),
            ),
            child: Icon(
              icon,
              color: color,
              size: 24,
            ),
          ),
          const SizedBox(
            width: 16,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    color: Color(
                      0xFF1A2A2C,
                    ),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  time,
                  style: TextStyle(
                    color: Colors.grey.shade500,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "$calories kcal",
                style: const TextStyle(
                  color: Color(
                    0xFF20C6B7,
                  ),
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              Row(
                children: [
                  Text(
                    "${protein}g P",
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    "${carbs}g C",
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    "${fats}g F",
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// From PharmacyScreen
class ProductCard
    extends
        StatelessWidget {
  final String name;
  final String size;
  final double price;
  final double? originalPrice;
  final Color primary;
  final VoidCallback onTap;

  const ProductCard({
    super.key,
    required this.name,
    required this.size,
    required this.price,
    this.originalPrice,
    required this.primary,
    required this.onTap,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 130,
        margin: const EdgeInsets.only(
          right: 16,
        ),
        padding: const EdgeInsets.all(
          12,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(
            16,
          ),
          border: Border.all(
            color: Colors.grey.shade200,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 85,
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(
                  12,
                ),
              ),
              child: Center(
                child: Icon(
                  Icons.medication_outlined,
                  color: Colors.grey.shade400,
                  size: 40,
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Color(
                  0xFF1A2A2C,
                ),
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              size,
              style: TextStyle(
                color: Colors.grey.shade500,
                fontSize: 12,
              ),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "\$${price.toStringAsFixed(2)}",
                      style: const TextStyle(
                        color: Color(
                          0xFF1A2A2C,
                        ),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (originalPrice !=
                        null)
                      Text(
                        "\$${originalPrice!.toStringAsFixed(2)}",
                        style: TextStyle(
                          color: Colors.grey.shade400,
                          fontSize: 12,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.all(
                    6,
                  ),
                  decoration: BoxDecoration(
                    color: primary,
                    borderRadius: BorderRadius.circular(
                      8,
                    ),
                  ),
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// From FitnessDashboard
class GoalCard
    extends
        StatelessWidget {
  final IconData icon;
  final String title;
  final int current;
  final int goal;
  final String unit;
  final Color color;

  const GoalCard({
    super.key,
    required this.icon,
    required this.title,
    required this.current,
    required this.goal,
    required this.unit,
    required this.color,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    final progress =
        (current /
                goal)
            .clamp(
              0.0,
              1.0,
            );

    return Container(
      padding: const EdgeInsets.all(
        16,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(
          16,
        ),
        border: Border.all(
          color: color.withOpacity(
            0.3,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: color,
                size: 20,
              ),
              const SizedBox(
                width: 8,
              ),
              Text(
                title,
                style: TextStyle(
                  color: color,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 12,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                current.toString(),
                style: const TextStyle(
                  color: Color(
                    0xFF1A2A2C,
                  ),
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                width: 4,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 4,
                ),
                child: Text(
                  "/ $goal $unit",
                  style: TextStyle(
                    color: Colors.grey.shade500,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 12,
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(
              10,
            ),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 8,
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
    );
  }
}

// From WorkoutDetail
class InfoCard
    extends
        StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const InfoCard({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    return Container(
      padding: const EdgeInsets.all(
        12,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(
          14,
        ),
        border: Border.all(
          color: color.withOpacity(
            0.3,
          ),
        ),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: 28,
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            label,
            style: const TextStyle(
              color: Color(
                0xFF687779,
              ),
              fontSize: 12,
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            value,
            style: const TextStyle(
              color: Color(
                0xFF1A2A2C,
              ),
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

// From XPSystem
class ActivityCard
    extends
        StatelessWidget {
  final IconData icon;
  final Color color;
  final String title;
  final String subtitle;
  final String time;

  const ActivityCard({
    super.key,
    required this.icon,
    required this.color,
    required this.title,
    required this.subtitle,
    required this.time,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    return Container(
      padding: const EdgeInsets.all(
        16,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(
          12,
        ),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(
              10,
            ),
            decoration: BoxDecoration(
              color: color.withOpacity(
                0.1,
              ),
              borderRadius: BorderRadius.circular(
                12,
              ),
            ),
            child: Icon(
              icon,
              color: color,
              size: 24,
            ),
          ),
          const SizedBox(
            width: 14,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Color(
                      0xFF1A2A2C,
                    ),
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          Text(
            time,
            style: TextStyle(
              color: Colors.grey.shade500,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

// From WorkoutDetail
class SetTrackerCard
    extends
        StatelessWidget {
  final int setNumber;
  final bool isCompleted;
  final VoidCallback onToggle;
  final Color primary;

  const SetTrackerCard({
    super.key,
    required this.setNumber,
    required this.isCompleted,
    required this.onToggle,
    required this.primary,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    return Container(
      margin: const EdgeInsets.only(
        bottom: 10,
      ),
      padding: const EdgeInsets.all(
        14,
      ),
      decoration: BoxDecoration(
        color: isCompleted
            ? primary.withOpacity(
                0.1,
              )
            : Colors.white,
        borderRadius: BorderRadius.circular(
          14,
        ),
        border: Border.all(
          color: isCompleted
              ? primary
              : Colors.grey.shade300,
        ),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: onToggle,
            child: Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: isCompleted
                    ? primary
                    : Colors.transparent,
                shape: BoxShape.circle,
                border: Border.all(
                  color: isCompleted
                      ? primary
                      : Colors.grey.shade400,
                  width: 2,
                ),
              ),
              child: isCompleted
                  ? const Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 16,
                    )
                  : null,
            ),
          ),
          const SizedBox(
            width: 14,
          ),
          Text(
            "Set $setNumber",
            style: TextStyle(
              color: const Color(
                0xFF1A2A2C,
              ),
              fontSize: 16,
              fontWeight: isCompleted
                  ? FontWeight.bold
                  : FontWeight.normal,
              decoration: isCompleted
                  ? TextDecoration.lineThrough
                  : null,
            ),
          ),
          const Spacer(),
          if (isCompleted)
            const Icon(
              Icons.check_circle,
              color: Color(
                0xFF4CAF50,
              ),
              size: 20,
            ),
        ],
      ),
    );
  }
}
