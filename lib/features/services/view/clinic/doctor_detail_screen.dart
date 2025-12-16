import 'package:flutter/material.dart';
import 'booking_success_screen.dart';
<<<<<<< HEAD
=======
import '../../../communication/view/chat_with_doctor_screen.dart';
import '../../../communication/view/video_consultation_screen.dart';
import '../../../communication/view/reviews_ratings_screen.dart';
>>>>>>> 11527b2 (Initial commit)

class DoctorDetailScreen
    extends
        StatefulWidget {
  final String doctorName;
  final String specialty;
  final double rating;
  final Color color;

  const DoctorDetailScreen({
    super.key,
    required this.doctorName,
    required this.specialty,
    required this.rating,
    required this.color,
  });

  @override
  State<
    DoctorDetailScreen
  >
  createState() => _DoctorDetailScreenState();
}

class _DoctorDetailScreenState
    extends
        State<
          DoctorDetailScreen
        > {
  int selectedDateIndex = 2; // Default to 'Tue 16'
  int selectedTimeIndex = 0; // Default to '09:00 AM'

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
          "Detail Doctor",
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
            // Doctor Card
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
                        widget.doctorName,
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
                      Text(
                        widget.specialty,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade500,
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

<<<<<<< HEAD
=======
            const SizedBox(height: 16),

            // COMMUNICATION OPTIONS
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildCommunicationOption(
                  context,
                  icon: Icons.chat_bubble_outline,
                  label: "Chat",
                  color: const Color(0xFF2196F3),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ChatWithDoctorScreen(
                          doctorName: widget.doctorName,
                          specialty: widget.specialty,
                        ),
                      ),
                    );
                  },
                ),
                _buildCommunicationOption(
                  context,
                  icon: Icons.videocam_outlined,
                  label: "Video Call",
                  color: const Color(0xFF4CAF50),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => VideoConsultationScreen(
                          providerName: widget.doctorName,
                          providerType: "Doctor",
                        ),
                      ),
                    );
                  },
                ),
                _buildCommunicationOption(
                  context,
                  icon: Icons.star_outline,
                  label: "Reviews",
                  color: const Color(0xFFFFC107),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ReviewsRatingsScreen(
                          providerName: widget.doctorName,
                          providerType: "Doctor",
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),

>>>>>>> 11527b2 (Initial commit)
            const SizedBox(
              height: 24,
            ),

            // Biography
            const Text(
              "Biography",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(
                  0xFF1A2A2C,
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Text.rich(
              TextSpan(
                text: "Dr. Jenny Wilson (Implantologist), is a Dentist in America, she has 20 years of... ",
                style: TextStyle(
                  color: Colors.grey.shade600,
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
              height: 24,
            ),

            // Specialties
            const Text(
              "Specialities",
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
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children:
                    [
                      "Dental Surgeon",
                      "Aesthetic Surgeon",
                      "General Dentist",
                    ].map(
                      (
                        spec,
                      ) {
                        return Container(
                          margin: const EdgeInsets.only(
                            right: 12,
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(
                              0xFFF0FDFD,
                            ),
                            borderRadius: BorderRadius.circular(
                              10,
                            ),
                          ),
                          child: Text(
                            spec,
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 12,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        );
                      },
                    ).toList(),
              ),
            ),

            const SizedBox(
              height: 24,
            ),

            // Calendar
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Calendar",
                  style: TextStyle(
                    fontSize: 18,
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

            // Book Button
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
                          ) => const BookingSuccessScreen(),
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
                  "Book Appointment",
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
<<<<<<< HEAD
=======

  Widget _buildCommunicationOption(
    BuildContext context, {
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              shape: BoxShape.circle,
              border: Border.all(
                color: color.withValues(alpha: 0.3),
              ),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              color: Colors.grey.shade700,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
>>>>>>> 11527b2 (Initial commit)
}
