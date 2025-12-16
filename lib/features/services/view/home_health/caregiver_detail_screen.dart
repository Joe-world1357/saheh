import 'package:flutter/material.dart';
import 'caregiver_success_screen.dart';

class CaregiverDetailScreen
    extends
        StatefulWidget {
  final String name;
  final String role;
  final double rating;
  final Color color;

  const CaregiverDetailScreen({
    super.key,
    required this.name,
    required this.role,
    required this.rating,
    required this.color,
  });

  @override
  State<
    CaregiverDetailScreen
  >
  createState() => _CaregiverDetailScreenState();
}

class _CaregiverDetailScreenState
    extends
        State<
          CaregiverDetailScreen
        > {
  int selectedDurationIndex = 2; // Default 'Customize'
  int selectedDayIndex = 2; // Default 'Tue'
  int selectedTimeIndex = 0; // Default '09.00 AM'

  final List<
    String
  >
  durations = [
    "One-Day",
    "One-Week",
    "Customize",
  ];
  final List<
    String
  >
  days = [
    "Sun",
    "Mon",
    "Tue",
    "Wed",
    "Thu",
    "Fri",
    "Sat",
  ];
  final List<
    String
  >
  times = [
    "09.00 AM",
    "11.00 AM",
    "03.00 PM",
  ];

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      backgroundColor: const Color(
        0xFFF5FAFA,
      ),
      appBar: AppBar(
        title: const Text(
          "Detail Caregiver",
          style: TextStyle(
            color: Color(
              0xFF1A2A2C,
            ),
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(
            left: 20,
            top: 8,
            bottom: 8,
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(
                12,
              ),
              border: Border.all(
                color: Colors.grey.shade200,
              ),
            ),
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back,
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
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(
          20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Caregiver Card
            Container(
              padding: const EdgeInsets.all(
                16,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(
                  20,
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      color: widget.color,
                      borderRadius: BorderRadius.circular(
                        12,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(
                            0xFF1A2A2C,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      // Assuming role is just name for now or static
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.star_rounded,
                            color: Color(
                              0xFF20C6B7,
                            ),
                            size: 20,
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Text(
                            "${widget.rating}",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade600,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 24,
            ),

            // Choose Duration
            const Text(
              "Choose Duration",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(
                  0xFF1A2A2C,
                ),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                durations.length,
                (
                  index,
                ) {
                  final isSelected =
                      selectedDurationIndex ==
                      index;
                  return GestureDetector(
                    onTap: () => setState(
                      () => selectedDurationIndex = index,
                    ),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? const Color(
                                0xFF20C6B7,
                              )
                            : Colors.white,
                        borderRadius: BorderRadius.circular(
                          30,
                        ),
                        border: Border.all(
                          color: isSelected
                              ? Colors.transparent
                              : Colors.grey.shade300,
                        ),
                      ),
                      child: Text(
                        durations[index],
                        style: TextStyle(
                          color: isSelected
                              ? Colors.white
                              : Colors.grey.shade600,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(
              height: 24,
            ),

            // Visit Schedule
            const Text(
              "Visit Schedule",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(
                  0xFF1A2A2C,
                ),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                days.length,
                (
                  index,
                ) {
                  final isSelected =
                      selectedDayIndex ==
                      index;
                  return GestureDetector(
                    onTap: () => setState(
                      () => selectedDayIndex = index,
                    ),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: isSelected
                            ? const Color(
                                0xFF20C6B7,
                              )
                            : Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: isSelected
                            ? [
                                BoxShadow(
                                  color:
                                      const Color(
                                        0xFF20C6B7,
                                      ).withOpacity(
                                        0.4,
                                      ),
                                  blurRadius: 10,
                                  offset: const Offset(
                                    0,
                                    4,
                                  ),
                                ),
                              ]
                            : [],
                      ),
                      child: Center(
                        child: Text(
                          days[index],
                          style: TextStyle(
                            color: isSelected
                                ? Colors.white
                                : Colors.grey.shade400,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(
              height: 24,
            ),

            // Time
            const Text(
              "Time",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(
                  0xFF1A2A2C,
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                times.length,
                (
                  index,
                ) {
                  final isSelected =
                      selectedTimeIndex ==
                      index;
                  return GestureDetector(
                    onTap: () => setState(
                      () => selectedTimeIndex = index,
                    ),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? const Color(
                                0xFF20C6B7,
                              )
                            : Colors.white,
                        borderRadius: BorderRadius.circular(
                          20,
                        ),
                        border: Border.all(
                          color: isSelected
                              ? Colors.transparent
                              : Colors.grey.shade200,
                        ),
                        boxShadow: isSelected
                            ? [
                                BoxShadow(
                                  color:
                                      const Color(
                                        0xFF20C6B7,
                                      ).withOpacity(
                                        0.4,
                                      ),
                                  blurRadius: 10,
                                  offset: const Offset(
                                    0,
                                    4,
                                  ),
                                ),
                              ]
                            : [],
                      ),
                      child: Text(
                        times[index],
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: isSelected
                              ? Colors.white
                              : Colors.grey.shade600,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(
              height: 40,
            ),

            // Request Button
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () {
                  // Reuse generic success screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (
                            context,
                          ) => const CaregiverSuccessScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(
                    0xFF20C6B7,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      30,
                    ),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  "Request",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
