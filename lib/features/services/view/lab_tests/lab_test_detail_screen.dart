import 'package:flutter/material.dart';
import 'lab_test_address_screen.dart';

class LabTestDetailScreen
    extends
        StatefulWidget {
  final String testName;

  const LabTestDetailScreen({
    super.key,
    required this.testName,
  });

  @override
  State<
    LabTestDetailScreen
  >
  createState() => _LabTestDetailScreenState();
}

class _LabTestDetailScreenState
    extends
        State<
          LabTestDetailScreen
        > {
  int selectedDateIndex = 2; // Tue 16
  int selectedTimeIndex = 0; // 09:00 AM

  final List<
    Map<
      String,
      String
    >
  >
  dates = [
    {
      "day": "14",
      "weekday": "Sun",
    },
    {
      "day": "15",
      "weekday": "Mon",
    },
    {
      "day": "16",
      "weekday": "Tue",
    },
    {
      "day": "17",
      "weekday": "Wed",
    },
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
          "Test Details",
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
            // Test Card
            Center(
              child: Container(
                width: 200,
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(
                    30,
                  ),
                  border: Border.all(
                    color: Colors.grey.shade200,
                  ),
                ),
                child: Center(
                  child: Text(
                    widget.testName,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(
                        0xFF1A2A2C,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(
              height: 30,
            ),

            // Details Section
            const Text(
              "Details",
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Preparation Before the Test",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Color(
                  0xFF687779,
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              "Fasting Required?",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade500,
              ),
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              "Yes — fasting for 8-12 hours is usually required. (The user should not eat or drink anything except water.)",
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade500,
                height: 1.5,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              "What the User Should Do:",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade500,
              ),
            ),
            const SizedBox(
              height: 4,
            ),
            Text.rich(
              TextSpan(
                text: "• Don't eat or drink anything except.... ",
                style: TextStyle(
                  color: Colors.grey.shade500,
                  height: 1.5,
                ),
                children: [
                  TextSpan(
                    text: "Read More",
                    style: TextStyle(
                      color: const Color(
                        0xFF20C6B7,
                      ),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(
              height: 30,
            ),

            // Calendar
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Calendar",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(
                      0xFF1A2A2C,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Text(
                      "July",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade500,
                      ),
                    ),
                    Icon(
                      Icons.chevron_right,
                      size: 16,
                      color: Colors.grey.shade500,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                dates.length,
                (
                  index,
                ) {
                  final isSelected =
                      selectedDateIndex ==
                      index;
                  return GestureDetector(
                    onTap: () => setState(
                      () => selectedDateIndex = index,
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
                          20,
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
                      child: Column(
                        children: [
                          Text(
                            dates[index]["day"]!,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: isSelected
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Text(
                            dates[index]["weekday"]!,
                            style: TextStyle(
                              fontSize: 12,
                              color: isSelected
                                  ? Colors.white
                                  : Colors.grey,
                            ),
                          ),
                        ],
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
                fontSize: 20,
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

            // Request Test Button
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (
                            context,
                          ) => const LabTestAddressScreen(),
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
                  "Request test",
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
