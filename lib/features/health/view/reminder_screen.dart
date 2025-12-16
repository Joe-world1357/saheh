import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'add_medicine.dart';
import '../../../providers/reminders_provider.dart';
import '../../../providers/medicine_intake_provider.dart';
import '../../../providers/home_data_provider.dart';
import '../../../providers/auth_provider.dart';
import '../../../core/services/xp_service.dart';
import '../../../models/medicine_intake_model.dart';
import 'package:intl/intl.dart';

class ReminderScreen extends ConsumerStatefulWidget {
  const ReminderScreen({super.key});

  @override
  ConsumerState<ReminderScreen> createState() => _ReminderScreenState();
}

class _ReminderScreenState extends ConsumerState<ReminderScreen> {
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    // Load intakes for today
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(medicineIntakeProvider.notifier).loadIntakesForDate(selectedDate);
      _createIntakesFromReminders();
    });
  }

  Future<void> _createIntakesFromReminders() async {
    final today = DateTime.now();
    final dayOfWeek = today.weekday % 7; // 0=Sunday, 1=Monday, etc.
    final reminders = ref.read(remindersProvider);
    final intakes = ref.read(medicineIntakeProvider);
    
    // Create intake records for today's reminders if they don't exist
    for (final reminder in reminders) {
      if (reminder.daysOfWeek.contains(dayOfWeek) && reminder.isActive) {
        final exists = intakes.any((i) => 
          i.medicineName == reminder.medicineName &&
          i.intakeTime == reminder.time &&
          i.intakeDate.year == today.year &&
          i.intakeDate.month == today.month &&
          i.intakeDate.day == today.day
        );
        
        if (!exists) {
          final authState = ref.read(authProvider);
          final userEmail = authState.user?.email ?? '';
          await ref.read(medicineIntakeProvider.notifier).createIntakeFromReminder(
            userEmail: userEmail,
            medicineName: reminder.medicineName,
            dosage: reminder.dosage,
            time: reminder.time,
            date: today,
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;
    final reminders = ref.watch(remindersProvider);
    final intakes = ref.watch(medicineIntakeProvider);
    final today = DateTime.now();
    final dayOfWeek = today.weekday % 7;
    
    // Filter reminders for today
    final todaysReminders = reminders.where((r) => 
      r.daysOfWeek.contains(dayOfWeek) && r.isActive
    ).toList();

    // Get intake stats
    final takenCount = intakes.where((i) => i.isTaken).length;
    final totalCount = intakes.length;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      floatingActionButton: FloatingActionButton(
        backgroundColor: primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
          side: BorderSide(
            color: theme.brightness == Brightness.dark ? primary : Colors.black,
            width: 1,
          ),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const AddMedicinePage(),
            ),
          ).then((_) {
            // Refresh when returning from add medicine
            ref.read(remindersProvider.notifier);
            _createIntakesFromReminders();
          });
        },
        child: Icon(
          Icons.add,
          color: theme.brightness == Brightness.dark 
              ? theme.colorScheme.onPrimary 
              : Colors.black,
          size: 26,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),

              // TOP BAR
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: primary, width: 2),
                    ),
                    child: IconButton(
                      icon: Icon(Icons.arrow_back_ios, color: primary),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  const Spacer(),
                  Text(
                    "Medicine Reminders",
                    style: theme.textTheme.titleLarge,
                  ),
                  const Spacer(),
                  const SizedBox(width: 48),
                ],
              ),

              const SizedBox(height: 20),

              // TODAY TITLE
              Text(
                DateFormat('EEEE, MMMM d').format(today),
                style: theme.textTheme.titleLarge,
              ),
              const SizedBox(height: 16),

              // INTAKES CIRCLE
              Center(
                child: Container(
                  height: 220,
                  width: 220,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: theme.colorScheme.surface,
                    border: Border.all(
                      color: primary.withValues(alpha: 0.3),
                      width: 2,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.medication,
                        color: theme.colorScheme.onSurfaceVariant,
                        size: 40,
                      ),
                      const SizedBox(height: 12),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "$takenCount",
                              style: TextStyle(
                                color: theme.colorScheme.onSurface,
                                fontWeight: FontWeight.bold,
                                fontSize: 36,
                              ),
                            ),
                            TextSpan(
                              text: "/$totalCount",
                              style: TextStyle(
                                color: primary,
                                fontWeight: FontWeight.bold,
                                fontSize: 36,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        DateFormat('EEEE').format(today),
                        style: theme.textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // MEDICINE CARDS
              if (intakes.isEmpty && todaysReminders.isEmpty)
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: Column(
                      children: [
                        Icon(
                          Icons.medication_outlined,
                          size: 64,
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No reminders for today',
                          style: theme.textTheme.bodyLarge,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Tap the + button to add a medicine reminder',
                          style: theme.textTheme.bodySmall,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                )
              else
                ...intakes.map((intake) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _medicineItem(
                      intake.medicineName,
                      intake.dosage,
                      intake.intakeTime,
                      isTaken: intake.isTaken,
                      onTap: () async {
                        if (!intake.isTaken) {
                          await ref.read(medicineIntakeProvider.notifier)
                              .markAsTaken(intake);
                          
                          // Award XP
                          await XPService.awardMedicineIntake(ref);
                          
                          // Refresh home data immediately
                          await ref.read(homeDataProvider.notifier).refresh();
                          
                          if (mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('${intake.medicineName} marked as taken! +${XPService.xpMedicineIntake} XP'),
                                backgroundColor: Colors.green,
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          }
                        } else {
                          // Redo: Mark as not taken
                          await ref.read(medicineIntakeProvider.notifier)
                              .markAsNotTaken(intake);
                          
                          // Refresh home data immediately
                          await ref.read(homeDataProvider.notifier).refresh();
                          
                          if (mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('${intake.medicineName} marked as not taken'),
                                backgroundColor: Colors.orange,
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          }
                        }
                      },
                      onDelete: () async {
                        if (intake.id != null) {
                          // Show confirmation dialog
                          final confirm = await showDialog<bool>(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Delete Medicine Intake'),
                              content: Text('Are you sure you want to delete ${intake.medicineName}?'),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context, false),
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () => Navigator.pop(context, true),
                                  child: const Text('Delete', style: TextStyle(color: Colors.red)),
                                ),
                              ],
                            ),
                          );
                          
                          if (confirm == true && mounted) {
                            await ref.read(medicineIntakeProvider.notifier)
                                .deleteIntake(intake.id!);
                            
                            // Refresh home data immediately
                            await ref.read(homeDataProvider.notifier).refresh();
                            
                            if (mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('${intake.medicineName} deleted'),
                                  backgroundColor: Colors.red,
                                  behavior: SnackBarBehavior.floating,
                                ),
                              );
                            }
                          }
                        }
                      },
                    ),
                  );
                }),

              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }

  Widget _medicineItem(
    String name,
    String subtitle,
    String time, {
    required bool isTaken,
    MedicineIntakeModel? intake,
    VoidCallback? onTap,
    VoidCallback? onDelete,
  }) {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;

    return GestureDetector(
      onTap: isTaken ? null : onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: isTaken 
              ? theme.colorScheme.surfaceVariant?.withValues(alpha: 0.5)
              : theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: isTaken 
                ? Colors.green.withValues(alpha: 0.5)
                : primary.withValues(alpha: 0.3),
            width: isTaken ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isTaken 
                    ? Colors.green.withValues(alpha: 0.2)
                    : Colors.orange.withValues(alpha: 0.2),
              ),
              child: Icon(
                isTaken ? Icons.check_circle : Icons.info,
                color: isTaken ? Colors.green : Colors.orange,
              ),
            ),

            const SizedBox(width: 12),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: theme.textTheme.titleMedium?.copyWith(
                      decoration: isTaken ? TextDecoration.lineThrough : null,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: theme.textTheme.bodySmall,
                  ),
                ],
              ),
            ),

            Row(
              children: [
                if (isTaken)
                  IconButton(
                    icon: const Icon(Icons.undo, size: 20),
                    color: Colors.orange,
                    onPressed: onTap, // Redo functionality
                    tooltip: 'Redo',
                  ),
                if (!isTaken)
                  Checkbox(
                    value: isTaken,
                    onChanged: (_) => onTap?.call(),
                    activeColor: primary,
                  ),
                if (onDelete != null)
                  IconButton(
                    icon: const Icon(Icons.delete_outline, size: 20),
                    color: Colors.red,
                    onPressed: onDelete,
                    tooltip: 'Delete',
                  ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                  decoration: BoxDecoration(
                    color: isTaken ? Colors.green : primary,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: theme.brightness == Brightness.dark 
                          ? primary 
                          : Colors.black,
                    ),
                  ),
                  child: Text(
                    time,
                    style: TextStyle(
                      color: isTaken 
                          ? Colors.white
                          : (theme.brightness == Brightness.dark 
                              ? theme.colorScheme.onPrimary 
                              : Colors.black),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                if (onDelete != null) ...[
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: onDelete,
                    child: Icon(
                      Icons.delete_outline,
                      color: Colors.red.shade300,
                      size: 20,
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}
