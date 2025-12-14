import 'package:flutter/material.dart';

class SyncActivityDataScreen extends StatefulWidget {
  const SyncActivityDataScreen({super.key});

  @override
  State<SyncActivityDataScreen> createState() => _SyncActivityDataScreenState();
}

class _SyncActivityDataScreenState extends State<SyncActivityDataScreen> {
  bool _autoSync = true;
  bool _syncOnWiFiOnly = false;
  bool _syncWorkouts = true;
  bool _syncNutrition = true;
  bool _syncSleep = true;
  bool _syncWaterIntake = true;
  String _syncFrequency = 'Every hour';

  final List<String> _frequencies = [
    'Every 15 minutes',
    'Every 30 minutes',
    'Every hour',
    'Every 3 hours',
    'Daily',
    'Manual only',
  ];

  @override
  Widget build(BuildContext context) {
    const primary = Color(0xFF20C6B7);

    return Scaffold(
      backgroundColor: const Color(0xFFF5FAFA),
      body: SafeArea(
        child: Column(
          children: [
            // TOP BAR
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 16,
              ),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.grey.shade300,
                        width: 1.5,
                      ),
                    ),
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios_new,
                        color: Color(0xFF1A2A2C),
                        size: 20,
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Expanded(
                    child: Text(
                      "Sync Activity Data",
                      style: TextStyle(
                        color: Color(0xFF1A2A2C),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),

                    // AUTO SYNC
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: Colors.grey.shade200,
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: primary.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(
                              Icons.sync,
                              color: Color(0xFF20C6B7),
                              size: 24,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Auto Sync",
                                  style: TextStyle(
                                    color: Color(0xFF1A2A2C),
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  "Automatically sync your activity data",
                                  style: TextStyle(
                                    color: Colors.grey.shade600,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Switch(
                            value: _autoSync,
                            onChanged: (value) {
                              setState(() {
                                _autoSync = value;
                              });
                            },
                            activeColor: primary,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    // SYNC FREQUENCY
                    if (_autoSync) ...[
                      const Text(
                        "Sync Frequency",
                        style: TextStyle(
                          color: Color(0xFF1A2A2C),
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.grey.shade300,
                          ),
                        ),
                        child: DropdownButtonFormField<String>(
                          value: _syncFrequency,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            icon: Icon(
                              Icons.schedule,
                              color: Color(0xFF20C6B7),
                            ),
                          ),
                          items: _frequencies
                              .map((freq) => DropdownMenuItem(
                                    value: freq,
                                    child: Text(freq),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              _syncFrequency = value!;
                            });
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],

                    // SYNC OPTIONS
                    const Text(
                      "Sync Options",
                      style: TextStyle(
                        color: Color(0xFF1A2A2C),
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildSyncOption(
                      icon: Icons.fitness_center,
                      title: "Workouts",
                      subtitle: "Sync workout data",
                      value: _syncWorkouts,
                      onChanged: (value) {
                        setState(() {
                          _syncWorkouts = value;
                        });
                      },
                    ),
                    const SizedBox(height: 12),
                    _buildSyncOption(
                      icon: Icons.restaurant,
                      title: "Nutrition",
                      subtitle: "Sync meal and calorie data",
                      value: _syncNutrition,
                      onChanged: (value) {
                        setState(() {
                          _syncNutrition = value;
                        });
                      },
                    ),
                    const SizedBox(height: 12),
                    _buildSyncOption(
                      icon: Icons.bedtime,
                      title: "Sleep",
                      subtitle: "Sync sleep tracking data",
                      value: _syncSleep,
                      onChanged: (value) {
                        setState(() {
                          _syncSleep = value;
                        });
                      },
                    ),
                    const SizedBox(height: 12),
                    _buildSyncOption(
                      icon: Icons.water_drop,
                      title: "Water Intake",
                      subtitle: "Sync hydration data",
                      value: _syncWaterIntake,
                      onChanged: (value) {
                        setState(() {
                          _syncWaterIntake = value;
                        });
                      },
                    ),

                    const SizedBox(height: 24),

                    // NETWORK SETTINGS
                    const Text(
                      "Network Settings",
                      style: TextStyle(
                        color: Color(0xFF1A2A2C),
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: Colors.grey.shade200,
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: primary.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(
                              Icons.wifi,
                              color: Color(0xFF20C6B7),
                              size: 24,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Sync on Wi-Fi Only",
                                  style: TextStyle(
                                    color: Color(0xFF1A2A2C),
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  "Save mobile data by syncing only on Wi-Fi",
                                  style: TextStyle(
                                    color: Colors.grey.shade600,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Switch(
                            value: _syncOnWiFiOnly,
                            onChanged: (value) {
                              setState(() {
                                _syncOnWiFiOnly = value;
                              });
                            },
                            activeColor: primary,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 32),

                    // MANUAL SYNC BUTTON
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Syncing activity data...'),
                              backgroundColor: Color(0xFF20C6B7),
                            ),
                          );
                        },
                        icon: const Icon(Icons.sync),
                        label: const Text(
                          "Sync Now",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primary,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                      ),
                    ),

                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSyncOption({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required Function(bool) onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFF20C6B7).withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              icon,
              color: const Color(0xFF20C6B7),
              size: 20,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Color(0xFF1A2A2C),
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: const Color(0xFF20C6B7),
          ),
        ],
      ),
    );
  }
}

