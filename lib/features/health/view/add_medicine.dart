import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../shared/widgets/form_widgets.dart';
import '../../../providers/reminders_provider.dart';
import '../../../providers/home_data_provider.dart';
import '../../../providers/auth_provider.dart';
import '../../../models/medicine_reminder_model.dart';

class AddMedicinePage extends ConsumerStatefulWidget {
  const AddMedicinePage({super.key});

  @override
  ConsumerState<AddMedicinePage> createState() => _AddMedicinePageState();
}

class _AddMedicinePageState extends ConsumerState<AddMedicinePage> {
  final Color primary = const Color(
    0xFF20C6B7,
  );

  final TextEditingController nameCtrl = TextEditingController();
  final TextEditingController doseCtrl = TextEditingController();

  TimeOfDay? selectedTime;
  String selectedDay = "Monday";

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      backgroundColor: const Color(
        0xFFF5FAFA,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // TOP BAR ---------------------------------------------------------
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        12,
                      ),
                      border: Border.all(
                        color: primary,
                        width: 2,
                      ),
                    ),
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: Color(
                          0xFF20C6B7,
                        ),
                      ),
                      onPressed: () => Navigator.pop(
                        context,
                      ),
                    ),
                  ),
                  const Spacer(),
                  const Text(
                    "Add Medicine",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(
                        0xFF1A2A2C,
                      ),
                    ),
                  ),
                  const Spacer(),
                  const SizedBox(
                    width: 40,
                  ),
                ],
              ),

              const SizedBox(
                height: 30,
              ),

              // INPUT: MEDICINE NAME -------------------------------------------
              // INPUT: MEDICINE NAME -------------------------------------------
              CustomInputField(
                label: "Medicine Name",
                controller: nameCtrl,
                hint: "e.g. Vitamin D",
              ),

              const SizedBox(
                height: 20,
              ),

              // INPUT: DOSE ----------------------------------------------------
              // INPUT: DOSE ----------------------------------------------------
              CustomInputField(
                label: "Dose",
                controller: doseCtrl,
                hint: "e.g. 1 capsule, 500mg",
              ),

              const SizedBox(
                height: 20,
              ),

              // SELECT TIME ----------------------------------------------------
              const Text(
                "Time",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(
                    0xFF1A2A2C,
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              GestureDetector(
                onTap: _pickTime,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(
                      14,
                    ),
                    border: Border.all(
                      color: primary.withOpacity(
                        0.3,
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.access_time,
                        color: primary,
                      ),
                      const SizedBox(
                        width: 14,
                      ),
                      Text(
                        selectedTime ==
                                null
                            ? "Select time"
                            : "${selectedTime!.hour.toString().padLeft(2, '0')}:${selectedTime!.minute.toString().padLeft(2, '0')}",
                        style: const TextStyle(
                          fontSize: 16,
                          color: Color(
                            0xFF1A2A2C,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(
                height: 20,
              ),

              // SELECT DAY -----------------------------------------------------
              const Text(
                "Day",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(
                    0xFF1A2A2C,
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(
                    14,
                  ),
                  border: Border.all(
                    color: primary.withOpacity(
                      0.3,
                    ),
                  ),
                ),
                child: DropdownButtonHideUnderline(
                  child:
                      DropdownButton<
                        String
                      >(
                        value: selectedDay,
                        iconEnabledColor: primary,
                        items:
                            [
                              "Monday",
                              "Tuesday",
                              "Wednesday",
                              "Thursday",
                              "Friday",
                              "Saturday",
                              "Sunday",
                            ].map(
                              (
                                d,
                              ) {
                                return DropdownMenuItem(
                                  value: d,
                                  child: Text(
                                    d,
                                  ),
                                );
                              },
                            ).toList(),
                        onChanged:
                            (
                              v,
                            ) => setState(
                              () => selectedDay = v!,
                            ),
                      ),
                ),
              ),

              const SizedBox(
                height: 32,
              ),

              // SAVE BUTTON ----------------------------------------------------
              ElevatedButton(
                onPressed: () async {
                  if (nameCtrl.text.trim().isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please enter medicine name'),
                        backgroundColor: Colors.red,
                      ),
                    );
                    return;
                  }
                  if (doseCtrl.text.trim().isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please enter dosage'),
                        backgroundColor: Colors.red,
                      ),
                    );
                    return;
                  }
                  if (selectedTime == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please select a time'),
                        backgroundColor: Colors.red,
                      ),
                    );
                    return;
                  }

                  // Convert day name to day of week (0=Sunday, 1=Monday, etc.)
                  final dayMap = {
                    'Sunday': 0,
                    'Monday': 1,
                    'Tuesday': 2,
                    'Wednesday': 3,
                    'Thursday': 4,
                    'Friday': 5,
                    'Saturday': 6,
                  };
                  final daysOfWeek = [dayMap[selectedDay]!];

                  final timeStr = '${selectedTime!.hour.toString().padLeft(2, '0')}:${selectedTime!.minute.toString().padLeft(2, '0')}';

                  final authState = ref.read(authProvider);
                  final userEmail = authState.user?.email ?? '';
                  
                  final reminder = MedicineReminderModel(
                    userEmail: userEmail,
                    medicineName: nameCtrl.text.trim(),
                    dosage: doseCtrl.text.trim(),
                    daysOfWeek: daysOfWeek,
                    time: timeStr,
                  );

                  try {
                    await ref.read(remindersProvider.notifier).addReminder(reminder);
                    
                    // Refresh home data
                    ref.read(homeDataProvider.notifier).refresh();

                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Medicine reminder added successfully'),
                          backgroundColor: Color(0xFF4CAF50),
                        ),
                      );
                      Navigator.pop(context);
                    }
                  } catch (e) {
                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Error adding medicine: ${e.toString()}'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primary,
                  padding: const EdgeInsets.symmetric(
                    vertical: 16,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      32,
                    ),
                    side: const BorderSide(
                      color: Colors.black,
                    ),
                  ),
                ),
                child: const Center(
                  child: Text(
                    "Save",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // TIME PICKER ---------------------------------------------------------------
  Future<
    void
  >
  _pickTime() async {
    final t = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (t !=
        null)
      setState(
        () => selectedTime = t,
      );
  }
}
