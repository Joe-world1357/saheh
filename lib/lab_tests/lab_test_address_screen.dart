import 'package:flutter/material.dart';
import 'lab_test_success_screen.dart';

class LabTestAddressScreen
    extends
        StatelessWidget {
  const LabTestAddressScreen({
    super.key,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Map Placeholder (Image or Color)
          Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.grey.shade200,
            // In a real app, this would be a GoogleMap widget
            child: const Center(
              child: Icon(
                Icons.map,
                size: 100,
                color: Colors.grey,
              ), // Placeholder icon
            ),
          ),

          // Top Bar
          Positioned(
            top: 40,
            left: 20,
            right: 20,
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(
                      12,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(
                          0.1,
                        ),
                        blurRadius: 4,
                      ),
                    ],
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
                //   const Spacer(),
                //   Container(
                //     padding: const EdgeInsets.all(10),
                //     decoration: BoxDecoration(
                //       color: Colors.white,
                //       shape: BoxShape.circle,
                //        boxShadow: [
                //             BoxShadow(
                //               color: Colors.black.withOpacity(0.1),
                //               blurRadius: 4,
                //             )
                //           ]
                //     ),
                //     child: const Icon(Icons.my_location, color: Color(0xFF20C6B7)),
                //   )
              ],
            ),
          ),

          // Bottom Sheet
          DraggableScrollableSheet(
            initialChildSize: 0.55,
            minChildSize: 0.5,
            maxChildSize: 0.9,
            builder:
                (
                  context,
                  scrollController,
                ) {
                  return Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(
                          30,
                        ),
                        topRight: Radius.circular(
                          30,
                        ),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 10,
                          offset: Offset(
                            0,
                            -5,
                          ),
                        ),
                      ],
                    ),
                    child: SingleChildScrollView(
                      controller: scrollController,
                      padding: const EdgeInsets.all(
                        24,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.location_on,
                                color: Color(
                                  0xFF20C6B7,
                                ),
                                size: 30,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Apartment Name", // Or dynamic
                                      style: TextStyle(
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
                                      "Sector 80, Gurugram, Haryana",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey.shade600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 24,
                          ),

                          // Form Fields
                          _buildLabel(
                            "Address*",
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          _buildTextField(
                            "House Number / Flat / Block No.",
                          ),
                          const SizedBox(
                            height: 16,
                          ),

                          _buildLabel(
                            "Landmark",
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          _buildTextField(
                            "e.g. Near ABC School",
                          ),
                          const SizedBox(
                            height: 16,
                          ),

                          _buildLabel(
                            "Address Title*",
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          _buildTextField(
                            "e.g. Home",
                          ),

                          const SizedBox(
                            height: 32,
                          ),

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
                                        ) => const LabTestSuccessScreen(),
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
                                "SAVE ADDRESS",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
          ),
        ],
      ),
    );
  }

  Widget _buildLabel(
    String text,
  ) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: Color(
          0xFF1A2A2C,
        ),
      ),
    );
  }

  Widget _buildTextField(
    String hint,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      decoration: BoxDecoration(
        color: const Color(
          0xFFF5FAFA,
        ),
        borderRadius: BorderRadius.circular(
          12,
        ),
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(
            color: Colors.grey.shade400,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
