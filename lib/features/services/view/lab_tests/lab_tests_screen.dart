import 'package:flutter/material.dart';
import 'lab_test_detail_screen.dart';

class LabTestsScreen
    extends
        StatefulWidget {
  const LabTestsScreen({
    super.key,
  });

  @override
  State<
    LabTestsScreen
  >
  createState() => _LabTestsScreenState();
}

class _LabTestsScreenState
    extends
        State<
          LabTestsScreen
        > {
  final List<
    Map<
      String,
      String
    >
  >
  bloodTests = [
    {
      "name": "Complete Blood Count (CBC)",
      "id": "1",
    },
    {
      "name": "Hemoglobin",
      "id": "2",
    },
    {
      "name": "Hematocrit",
      "id": "3",
    },
  ];

  final List<
    Map<
      String,
      String
    >
  >
  diabetesTests = [
    {
      "name": "Insulin",
      "id": "4",
    },
    {
      "name": "Microalbuminuria",
      "id": "5",
    },
    {
      "name": "HbA1c (Glycated Hemoglobin)",
      "id": "6",
    },
  ];

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      backgroundColor: const Color(
        0xFF20C6B7,
      ),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // Header
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
                        color: Colors.white.withOpacity(
                          0.3,
                        ),
                      ),
                    ),
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.white,
                        size: 20,
                      ),
                      onPressed: () => Navigator.pop(
                        context,
                      ),
                    ),
                  ),
                  const Spacer(),
                  const Text(
                    "Lab Tests",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  const SizedBox(
                    width: 40,
                  ),
                ],
              ),
            ),

            const SizedBox(
              height: 10,
            ),

            // Toggle Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(
                      30,
                    ),
                  ),
                  child: const Text(
                    "My requests",
                    style: TextStyle(
                      color: Color(
                        0xFF687779,
                      ),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 40,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(
                      30,
                    ),
                  ),
                  child: const Text(
                    "My results",
                    style: TextStyle(
                      color: Color(
                        0xFF687779,
                      ),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(
              height: 20,
            ),

            // Search Bar
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(
                    30,
                  ),
                ),
                child: const TextField(
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.search,
                      color: Colors.grey,
                    ),
                    hintText: "Search here..",
                    hintStyle: TextStyle(
                      color: Colors.grey,
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),

            const SizedBox(
              height: 20,
            ),

            // Content Area
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Color(
                    0xFFF5FAFA,
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(
                      30,
                    ),
                    topRight: Radius.circular(
                      30,
                    ),
                  ),
                ),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(
                    20,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Categories",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(
                            0xFF1A2A2C,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),

                      // Blood Tests
                      _buildCategorySection(
                        "Blood tests",
                        bloodTests,
                      ),
                      const SizedBox(
                        height: 20,
                      ),

                      // Diabetes Tests
                      _buildCategorySection(
                        "Diabetes tests",
                        diabetesTests,
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

  Widget _buildCategorySection(
    String title,
    List<
      Map<
        String,
        String
      >
    >
    tests,
  ) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(
                  0xFF1A2A2C,
                ),
              ),
            ),
            TextButton(
              onPressed: () {},
              child: const Text(
                "See all",
                style: TextStyle(
                  color: Color(
                    0xFF20C6B7,
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 120,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: tests.length,
            separatorBuilder:
                (
                  _,
                  __,
                ) => const SizedBox(
                  width: 12,
                ),
            itemBuilder:
                (
                  context,
                  index,
                ) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (
                                context,
                              ) => LabTestDetailScreen(
                                testName: tests[index]["name"]!,
                              ),
                        ),
                      );
                    },
                    child: Container(
                      width: 110,
                      padding: const EdgeInsets.all(
                        12,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(
                          16,
                        ),
                        border: Border.all(
                          color: const Color(
                            0xFFE0E0E0,
                          ),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          tests[index]["name"]!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Color(
                              0xFF1A2A2C,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
          ),
        ),
      ],
    );
  }
}
