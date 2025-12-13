import 'package:flutter/material.dart';
import 'add_medicine.dart'; // ⬅️ IMPORTANT (your file name)

class ReminderScreen extends StatefulWidget {
  const ReminderScreen({super.key});

  @override
  State<ReminderScreen> createState() => _ReminderScreenState();
}

class _ReminderScreenState extends State<ReminderScreen> {
  int selectedDay = 3; // “Today”

  final List<Map<String, String>> days = [
    {"day": "2", "label": "FRI"},
    {"day": "3", "label": "SAT"},
    {"day": "4", "label": "SUN"},
    {"day": "5", "label": "MON"},
    {"day": "6", "label": "TUE"},
    {"day": "7", "label": "WED"},
    {"day": "8", "label": "THU"},
    {"day": "9", "label": "FRI"},
  ];

  @override
  Widget build(BuildContext context) {
    const primary = Color(0xFF20C6B7);

    return Scaffold(
      backgroundColor: const Color(0xFFF5FAFA),

      // ✅ FIXED (Go to AddMedicinePage)
      floatingActionButton: FloatingActionButton(
        backgroundColor: primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
          side: const BorderSide(color: Colors.black),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const AddMedicinePage(),
            ),
          );
        },
        child: const Icon(Icons.add, color: Colors.black, size: 26),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),

              // ---------------- TOP BAR ----------------
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: primary, width: 2),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back_ios, color: Color(0xFF20C6B7)),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  const Spacer(),
                  const Text(
                    "Reminder",
                    style: TextStyle(
                      color: Color(0xFF1A2A2C),
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  const SizedBox(width: 48),
                ],
              ),

              const SizedBox(height: 20),

              // ---------------- TODAY TITLE ----------------
              const Text(
                "Today",
                style: TextStyle(
                  color: Color(0xFF1A2A2C),
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),

              // ---------------- DATE SELECTOR ----------------
              SizedBox(
                height: 80,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: days.length,
                  itemBuilder: (context, index) {
                    final selected = (index == selectedDay);

                    return GestureDetector(
                      onTap: () => setState(() => selectedDay = index),
                      child: Container(
                        margin: const EdgeInsets.only(right: 12),
                        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 18),
                        decoration: BoxDecoration(
                          color: selected ? primary.withOpacity(0.2) : Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: selected ? primary : Colors.grey.shade300,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              days[index]["day"]!,
                              style: TextStyle(
                                color: selected ? primary : const Color(0xFF1A2A2C),
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              days[index]["label"]!,
                              style: TextStyle(
                                color: selected ? primary : const Color(0xFF687779),
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 20),

              // ---------------- INTAKES ----------------
              const Center(
                child: Text(
                  "Intakes",
                  style: TextStyle(
                    color: Color(0xFF1A2A2C),
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              Center(
                child: Container(
                  height: 220,
                  width: 220,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    border: Border.all(color: primary.withOpacity(0.3)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.medication, color: Color(0xFF687779), size: 40),
                      const SizedBox(height: 12),
                      RichText(
                        text: const TextSpan(
                          children: [
                            TextSpan(
                              text: "0",
                              style: TextStyle(
                                color: Color(0xFF1A2A2C),
                                fontWeight: FontWeight.bold,
                                fontSize: 36,
                              ),
                            ),
                            TextSpan(
                              text: "/2",
                              style: TextStyle(
                                color: Color(0xFF20C6B7),
                                fontWeight: FontWeight.bold,
                                fontSize: 36,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        "Tuesday",
                        style: TextStyle(color: Color(0xFF687779)),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // ---------------- MEDICINE CARDS ----------------
              _medicineItem("Vitamin D", "1 Capsule, 1000mg", "09:41"),
              const SizedBox(height: 12),
              _medicineItem("B12 Drops", "5 Drops, 1200mg", "06:13"),

              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }

  // ---------------- MEDICINE CARD ----------------
  Widget _medicineItem(String name, String subtitle, String time) {
    const primary = Color(0xFF20C6B7);

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: primary.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.orange.withOpacity(0.2),
            ),
            child: const Icon(Icons.info, color: Colors.orange),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    color: Color(0xFF1A2A2C),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Color(0xFF687779),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            decoration: BoxDecoration(
              color: primary,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: Colors.black),
            ),
            child: Text(
              time,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
