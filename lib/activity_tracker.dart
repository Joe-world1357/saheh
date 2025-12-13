import 'package:flutter/material.dart';

class ActivityTracker
    extends
        StatelessWidget {
  const ActivityTracker({
    super.key,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    const primary = Color(
      0xFF20C6B7,
    );

    return Scaffold(
      backgroundColor: const Color(
        0xFFF5FAFA,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // TOP BAR --------------------------------------------------------
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        12,
                      ),
                      border: Border.all(
                        color: Colors.grey.shade300,
                        width: 1.5,
                      ),
                    ),
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios_new,
                        color: Color(
                          0xFF1A2A2C,
                        ),
                        size: 20,
                      ),
                      onPressed: () => Navigator.pop(
                        context,
                      ),
                    ),
                  ),
                  const Spacer(),
                  const Text(
                    "Activity Tracker",
                    style: TextStyle(
                      color: Color(
                        0xFF1A2A2C,
                      ),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: Icon(
                      Icons.person_outline,
                      color: Colors.grey.shade600,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),

                      // DATE
                      Text(
                        "Today, December 27",
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 14,
                        ),
                      ),

                      const SizedBox(
                        height: 20,
                      ),

                      // STEPS CARD -------------------------------------------------
                      Container(
                        padding: const EdgeInsets.all(
                          20,
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
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(
                                    10,
                                  ),
                                  decoration: BoxDecoration(
                                    color: primary.withOpacity(
                                      0.15,
                                    ),
                                    borderRadius: BorderRadius.circular(
                                      10,
                                    ),
                                  ),
                                  child: const Icon(
                                    Icons.directions_walk,
                                    color: primary,
                                    size: 22,
                                  ),
                                ),
                                const SizedBox(
                                  width: 14,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: const [
                                      Text(
                                        "Steps",
                                        style: TextStyle(
                                          color: Color(
                                            0xFF687779,
                                          ),
                                          fontSize: 14,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 2,
                                      ),
                                      Text(
                                        "Today",
                                        style: TextStyle(
                                          color: Color(
                                            0xFF687779,
                                          ),
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: const [
                                    Text(
                                      "8,247",
                                      style: TextStyle(
                                        color: primary,
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 2,
                                    ),
                                    Text(
                                      "Goal: 10,000",
                                      style: TextStyle(
                                        color: Color(
                                          0xFF687779,
                                        ),
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 14,
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(
                                10,
                              ),
                              child: LinearProgressIndicator(
                                value:
                                    8247 /
                                    10000,
                                minHeight: 8,
                                backgroundColor: Colors.grey.shade200,
                                valueColor:
                                    const AlwaysStoppedAnimation<
                                      Color
                                    >(
                                      primary,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(
                        height: 16,
                      ),

                      // DURATION & CALORIES ROW ------------------------------------
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(
                                18,
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
                                  Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(
                                          8,
                                        ),
                                        decoration: BoxDecoration(
                                          color:
                                              const Color(
                                                0xFFE91E63,
                                              ).withOpacity(
                                                0.15,
                                              ),
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                        child: const Icon(
                                          Icons.timer,
                                          color: Color(
                                            0xFFE91E63,
                                          ),
                                          size: 18,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      const Text(
                                        "Duration",
                                        style: TextStyle(
                                          color: Color(
                                            0xFF687779,
                                          ),
                                          fontSize: 13,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  const Text(
                                    "2h 15m",
                                    style: TextStyle(
                                      color: Color(
                                        0xFFE91E63,
                                      ),
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    "Walking time",
                                    style: TextStyle(
                                      color: Colors.grey.shade600,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(
                                18,
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
                                  Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(
                                          8,
                                        ),
                                        decoration: BoxDecoration(
                                          color:
                                              const Color(
                                                0xFFFF9800,
                                              ).withOpacity(
                                                0.15,
                                              ),
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                        child: const Icon(
                                          Icons.local_fire_department,
                                          color: Color(
                                            0xFFFF9800,
                                          ),
                                          size: 18,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      const Text(
                                        "Calories",
                                        style: TextStyle(
                                          color: Color(
                                            0xFF687779,
                                          ),
                                          fontSize: 13,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  const Text(
                                    "342",
                                    style: TextStyle(
                                      color: Color(
                                        0xFFFF9800,
                                      ),
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    "kcal burned",
                                    style: TextStyle(
                                      color: Colors.grey.shade600,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(
                        height: 16,
                      ),

                      // SLEEP CARD -------------------------------------------------
                      Container(
                        padding: const EdgeInsets.all(
                          18,
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
                                10,
                              ),
                              decoration: BoxDecoration(
                                color:
                                    const Color(
                                      0xFF2196F3,
                                    ).withOpacity(
                                      0.15,
                                    ),
                                borderRadius: BorderRadius.circular(
                                  10,
                                ),
                              ),
                              child: const Icon(
                                Icons.nightlight_round,
                                color: Color(
                                  0xFF2196F3,
                                ),
                                size: 22,
                              ),
                            ),
                            const SizedBox(
                              width: 14,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    "Sleep",
                                    style: TextStyle(
                                      color: Color(
                                        0xFF687779,
                                      ),
                                      fontSize: 14,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 2,
                                  ),
                                  Text(
                                    "Last night",
                                    style: TextStyle(
                                      color: Color(
                                        0xFF687779,
                                      ),
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: const [
                                Text(
                                  "7h 32m",
                                  style: TextStyle(
                                    color: Color(
                                      0xFF2196F3,
                                    ),
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                Text(
                                  "Good quality",
                                  style: TextStyle(
                                    color: Color(
                                      0xFF687779,
                                    ),
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(
                        height: 16,
                      ),

                      // ACTIVITY LEVEL CARD ----------------------------------------
                      Container(
                        padding: const EdgeInsets.all(
                          18,
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
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(
                                    10,
                                  ),
                                  decoration: BoxDecoration(
                                    color:
                                        const Color(
                                          0xFF9C27B0,
                                        ).withOpacity(
                                          0.15,
                                        ),
                                    borderRadius: BorderRadius.circular(
                                      10,
                                    ),
                                  ),
                                  child: const Icon(
                                    Icons.trending_up,
                                    color: Color(
                                      0xFF9C27B0,
                                    ),
                                    size: 22,
                                  ),
                                ),
                                const SizedBox(
                                  width: 14,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: const [
                                      Text(
                                        "Activity Level",
                                        style: TextStyle(
                                          color: Color(
                                            0xFF687779,
                                          ),
                                          fontSize: 14,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 2,
                                      ),
                                      Text(
                                        "Today",
                                        style: TextStyle(
                                          color: Color(
                                            0xFF687779,
                                          ),
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: const [
                                    Text(
                                      "High",
                                      style: TextStyle(
                                        color: Color(
                                          0xFF9C27B0,
                                        ),
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 2,
                                    ),
                                    Text(
                                      "85% active",
                                      style: TextStyle(
                                        color: Color(
                                          0xFF687779,
                                        ),
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 14,
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(
                                10,
                              ),
                              child: LinearProgressIndicator(
                                value: 0.85,
                                minHeight: 8,
                                backgroundColor: Colors.grey.shade200,
                                valueColor:
                                    const AlwaysStoppedAnimation<
                                      Color
                                    >(
                                      Color(
                                        0xFF9C27B0,
                                      ),
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(
                        height: 28,
                      ),

                      // WEEKLY SUMMARY ---------------------------------------------
                      const Text(
                        "Weekly Summary",
                        style: TextStyle(
                          color: Color(
                            0xFF1A2A2C,
                          ),
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(
                        height: 16,
                      ),

                      Container(
                        padding: const EdgeInsets.all(
                          20,
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
                          children: [
                            Text(
                              "Daily Steps This Week",
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: 13,
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            // BAR CHART
                            SizedBox(
                              height: 120,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  _barChart(
                                    "Mon",
                                    0.7,
                                    primary,
                                  ),
                                  _barChart(
                                    "Tue",
                                    0.9,
                                    primary,
                                  ),
                                  _barChart(
                                    "Wed",
                                    0.6,
                                    primary,
                                  ),
                                  _barChart(
                                    "Thu",
                                    0.85,
                                    primary,
                                  ),
                                  _barChart(
                                    "Fri",
                                    0.75,
                                    primary,
                                  ),
                                  _barChart(
                                    "Sat",
                                    0.95,
                                    primary,
                                  ),
                                  _barChart(
                                    "Sun",
                                    0.8,
                                    primary,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                            const Divider(),
                            const SizedBox(
                              height: 16,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: const [
                                _WeeklyStat(
                                  label: "Avg Steps",
                                  value: "8,456",
                                  color: primary,
                                ),
                                _WeeklyStat(
                                  label: "Avg Sleep",
                                  value: "7h 25m",
                                  color: Color(
                                    0xFF2196F3,
                                  ),
                                ),
                                _WeeklyStat(
                                  label: "Total\nCalories",
                                  value: "2,394",
                                  color: Color(
                                    0xFFFF9800,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(
                        height: 40,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // BAR CHART WIDGET ---------------------------------------------------
  static Widget _barChart(
    String label,
    double value,
    Color color,
  ) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 32,
          height:
              100 *
              value,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(
              6,
            ),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          label,
          style: TextStyle(
            color: Colors.grey.shade600,
            fontSize: 11,
          ),
        ),
      ],
    );
  }
}

// WEEKLY STAT WIDGET -------------------------------------------------
class _WeeklyStat
    extends
        StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const _WeeklyStat({
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    return Column(
      children: [
        Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.grey.shade600,
            fontSize: 12,
          ),
        ),
        const SizedBox(
          height: 6,
        ),
        Text(
          value,
          style: TextStyle(
            color: color,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
