import 'package:flutter/material.dart';
import 'doctor_detail_screen.dart';

class ClinicDashboard
    extends
        StatefulWidget {
  const ClinicDashboard({
    super.key,
  });

  @override
  State<
    ClinicDashboard
  >
  createState() => _ClinicDashboardState();
}

class _ClinicDashboardState
    extends
        State<
          ClinicDashboard
        > {
  final List<
    String
  >
  categories = [
    "General",
    "Cardiology",
    "Dentist",
    "Neurology",
    "Orthopedic",
  ];
  int selectedCategoryIndex = 2; // Default to Dentist as per mockup

  final List<
    Map<
      String,
      dynamic
    >
  >
  doctors = [
    {
      "name": "Dr. Jenny Wilson",
      "specialty": "Dental Surgeon",
      "rating": 4.8,
      "image": "assets/doctor_1.png", // Placeholder
      "color": const Color(
        0xFFFFE0B2,
      ), // Orange/Peach background
    },
    {
      "name": "Dr. Kristin Watson",
      "specialty": "Dental Surgeon",
      "rating": 4.8,
      "image": "assets/doctor_2.png", // Placeholder
      "color": const Color(
        0xFFB2DFDB,
      ), // Teal background
    },
    {
      "name": "Dr. Jenny Wilson",
      "specialty": "Dental Surgeon",
      "rating": 4.8,
      "image": "assets/doctor_1.png", // Placeholder
      "color": const Color(
        0xFFFFE0B2,
      ),
    },
    {
      "name": "Dr. Kristin Watson",
      "specialty": "Dental Surgeon",
      "rating": 4.8,
      "image": "assets/doctor_2.png", // Placeholder
      "color": const Color(
        0xFFB2DFDB,
      ),
    },
  ];

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      backgroundColor: const Color(
        0xFF20C6B7,
      ), // Teal background for top part
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // Header Section
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
                    "Clinic Booking", // Or just empty as per mockup
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  // Empty container to balance spacing if needed
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
              height: 10,
            ),

            // Main White Content Area
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
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    // Categories (Chips)
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      child: Row(
                        children: List.generate(
                          categories.length,
                          (
                            index,
                          ) {
                            final isSelected =
                                selectedCategoryIndex ==
                                index;
                            return Padding(
                              padding: const EdgeInsets.only(
                                right: 10,
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  setState(
                                    () {
                                      selectedCategoryIndex = index;
                                    },
                                  );
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 10,
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
                                          : Colors.grey.shade300,
                                    ),
                                  ),
                                  child: Text(
                                    categories[index],
                                    style: TextStyle(
                                      color: isSelected
                                          ? Colors.white
                                          : Colors.grey.shade600,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: 20,
                    ),

                    // Doctor List
                    Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                        ),
                        itemCount: doctors.length,
                        itemBuilder:
                            (
                              context,
                              index,
                            ) {
                              final doctor = doctors[index];
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder:
                                          (
                                            context,
                                          ) => DoctorDetailScreen(
                                            doctorName: doctor["name"],
                                            specialty: doctor["specialty"],
                                            rating: doctor["rating"],
                                            color: doctor["color"],
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
                                          color: doctor["color"],
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                        // Placeholder for image
                                      ),
                                      const SizedBox(
                                        width: 16,
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              doctor["name"],
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
                                              doctor["specialty"],
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
                                                  "${doctor["rating"]}",
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
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
