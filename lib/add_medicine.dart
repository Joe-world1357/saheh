import 'package:flutter/material.dart';
import 'widgets/form_widgets.dart';

class AddMedicinePage
    extends
        StatefulWidget {
  const AddMedicinePage({
    super.key,
  });

  @override
  State<
    AddMedicinePage
  >
  createState() => _AddMedicinePageState();
}

class _AddMedicinePageState
    extends
        State<
          AddMedicinePage
        > {
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
                onPressed: () => Navigator.pop(
                  context,
                ),
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
