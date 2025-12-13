import 'package:flutter/material.dart';
import 'caregiver_detail_screen.dart';

class HomeHealthDashboard
    extends
        StatelessWidget {
  const HomeHealthDashboard({
    super.key,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    final List<
      Map<
        String,
        dynamic
      >
    >
    caregivers = [
      {
        "name": "Nurse Jenny Wilson",
        "role": "Home Nurse",
        "rating": 4.8,
        "color": const Color(
          0xFFFFE0B2,
        ), // Peach
        "image": "assets/nurse_1.png",
      },
      {
        "name": "Caregiver Kristin",
        "role": "Elderly Care",
        "rating": 4.9,
        "color": const Color(
          0xFFB2DFDB,
        ), // Teal
        "image": "assets/nurse_2.png",
      },
      {
        "name": "Nurse Jenny Wilson",
        "role": "Home Nurse",
        "rating": 4.8,
        "color": const Color(
          0xFFFFE0B2,
        ), // Peach
        "image": "assets/nurse_1.png",
      },
      {
        "name": "Caregiver Kristin",
        "role": "Elderly Care",
        "rating": 4.9,
        "color": const Color(
          0xFFB2DFDB,
        ), // Teal
        "image": "assets/nurse_2.png",
      },
    ];

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
                    "Home Health",
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

            // Search Bar
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
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
                    hintText: "Search caregivers, tests...",
                    hintStyle: TextStyle(
                      color: Colors.grey,
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),

            // White Content Area
            Expanded(
              child: Container(
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
                child: ListView.builder(
                  padding: const EdgeInsets.all(
                    20,
                  ),
                  itemCount: caregivers.length,
                  itemBuilder:
                      (
                        context,
                        index,
                      ) {
                        final caregiver = caregivers[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (
                                      context,
                                    ) => CaregiverDetailScreen(
                                      name: caregiver["name"],
                                      role: caregiver["role"],
                                      rating: caregiver["rating"],
                                      color: caregiver["color"],
                                    ),
                              ),
                            );
                          },
                          child: Container(
                            margin: const EdgeInsets.only(
                              bottom: 16,
                            ),
                            padding: const EdgeInsets.all(
                              12,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(
                                16,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(
                                    0.05,
                                  ),
                                  blurRadius: 10,
                                  offset: const Offset(
                                    0,
                                    4,
                                  ),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 80,
                                  height: 80,
                                  decoration: BoxDecoration(
                                    color: caregiver["color"],
                                    borderRadius: BorderRadius.circular(
                                      12,
                                    ),
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
                                        caregiver["name"],
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Color(
                                            0xFF1A2A2C,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 4,
                                      ),
                                      Text(
                                        caregiver["role"],
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey.shade600,
                                        ),
                                      ),
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
                                            "${caregiver["rating"]}",
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
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
