import 'package:flutter/material.dart';

class WorkoutPreferencesScreen extends StatefulWidget {
  const WorkoutPreferencesScreen({super.key});

  @override
  State<WorkoutPreferencesScreen> createState() => _WorkoutPreferencesScreenState();
}

class _WorkoutPreferencesScreenState extends State<WorkoutPreferencesScreen> {
  String _activityLevel = 'Moderately Active';
  String _workoutDuration = '30-45 minutes';
  int _workoutsPerWeek = 4;
  bool _remindersEnabled = true;
  String _preferredTime = 'Morning';
  List<String> _preferredDays = ['Monday', 'Wednesday', 'Friday'];

  final List<String> _activityLevels = [
    'Sedentary',
    'Lightly Active',
    'Moderately Active',
    'Very Active',
    'Extremely Active',
  ];

  final List<String> _durations = [
    '15-30 minutes',
    '30-45 minutes',
    '45-60 minutes',
    '60+ minutes',
  ];

  final List<String> _times = [
    'Morning',
    'Afternoon',
    'Evening',
    'Flexible',
  ];

  final List<String> _allDays = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
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
                      "Workout Preferences",
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

                    // ACTIVITY LEVEL
                    _buildSectionTitle("Activity Level"),
                    const SizedBox(height: 8),
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
                        value: _activityLevel,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          icon: Icon(
                            Icons.trending_up,
                            color: Color(0xFF20C6B7),
                          ),
                        ),
                        items: _activityLevels
                            .map((level) => DropdownMenuItem(
                                  value: level,
                                  child: Text(level),
                                ))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            _activityLevel = value!;
                          });
                        },
                      ),
                    ),

                    const SizedBox(height: 24),

                    // WORKOUTS PER WEEK
                    _buildSectionTitle("Workouts Per Week"),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            if (_workoutsPerWeek > 1) {
                              setState(() {
                                _workoutsPerWeek--;
                              });
                            }
                          },
                          icon: const Icon(Icons.remove_circle_outline),
                          color: primary,
                        ),
                        Expanded(
                          child: Center(
                            child: Text(
                              '$_workoutsPerWeek workouts',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1A2A2C),
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            if (_workoutsPerWeek < 7) {
                              setState(() {
                                _workoutsPerWeek++;
                              });
                            }
                          },
                          icon: const Icon(Icons.add_circle_outline),
                          color: primary,
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    // WORKOUT DURATION
                    _buildSectionTitle("Preferred Workout Duration"),
                    const SizedBox(height: 8),
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
                        value: _workoutDuration,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          icon: Icon(
                            Icons.timer_outlined,
                            color: Color(0xFF20C6B7),
                          ),
                        ),
                        items: _durations
                            .map((duration) => DropdownMenuItem(
                                  value: duration,
                                  child: Text(duration),
                                ))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            _workoutDuration = value!;
                          });
                        },
                      ),
                    ),

                    const SizedBox(height: 24),

                    // PREFERRED TIME
                    _buildSectionTitle("Preferred Workout Time"),
                    const SizedBox(height: 8),
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
                        value: _preferredTime,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          icon: Icon(
                            Icons.access_time,
                            color: Color(0xFF20C6B7),
                          ),
                        ),
                        items: _times
                            .map((time) => DropdownMenuItem(
                                  value: time,
                                  child: Text(time),
                                ))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            _preferredTime = value!;
                          });
                        },
                      ),
                    ),

                    const SizedBox(height: 24),

                    // PREFERRED DAYS
                    _buildSectionTitle("Preferred Workout Days"),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: _allDays.map((day) {
                        final isSelected = _preferredDays.contains(day);
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              if (isSelected) {
                                _preferredDays.remove(day);
                              } else {
                                _preferredDays.add(day);
                              }
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              color: isSelected ? primary : Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: isSelected ? primary : Colors.grey.shade300,
                              ),
                            ),
                            child: Text(
                              day,
                              style: TextStyle(
                                color: isSelected ? Colors.white : Colors.grey.shade700,
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),

                    const SizedBox(height: 24),

                    // REMINDERS
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
                              Icons.notifications_active,
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
                                  "Workout Reminders",
                                  style: TextStyle(
                                    color: Color(0xFF1A2A2C),
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  "Get notified before your workout time",
                                  style: TextStyle(
                                    color: Colors.grey.shade600,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Switch(
                            value: _remindersEnabled,
                            onChanged: (value) {
                              setState(() {
                                _remindersEnabled = value;
                              });
                            },
                            activeColor: primary,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 32),

                    // SAVE BUTTON
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Workout preferences saved'),
                              backgroundColor: Color(0xFF4CAF50),
                            ),
                          );
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: const Text(
                          "Save Preferences",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
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

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        color: Color(0xFF1A2A2C),
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}

