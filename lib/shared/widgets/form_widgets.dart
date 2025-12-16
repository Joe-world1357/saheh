import 'package:flutter/material.dart';
<<<<<<< HEAD

// From AddMedicinePage
class CustomInputField
    extends
        StatelessWidget {
=======
import '../../core/theme/app_colors.dart';

// From AddMedicinePage
class CustomInputField extends StatelessWidget {
>>>>>>> 11527b2 (Initial commit)
  final String label;
  final TextEditingController controller;
  final String hint;

  const CustomInputField({
    super.key,
    required this.label,
    required this.controller,
    required this.hint,
  });

  @override
<<<<<<< HEAD
  Widget build(
    BuildContext context,
  ) {
=======
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
>>>>>>> 11527b2 (Initial commit)
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
<<<<<<< HEAD
          style: const TextStyle(
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
            vertical: 4,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(
              14,
            ),
            border: Border.all(
              color: Colors.black,
            ),
          ),
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hint,
              hintStyle: const TextStyle(
                color: Color(
                  0xFF687779,
                ),
=======
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: theme.dividerColor),
          ),
          child: TextField(
            controller: controller,
            style: TextStyle(color: theme.colorScheme.onSurface),
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hint,
              hintStyle: TextStyle(
                color: theme.colorScheme.onSurfaceVariant,
>>>>>>> 11527b2 (Initial commit)
                fontSize: 14,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// From OtpScreen
<<<<<<< HEAD
class OtpBox
    extends
        StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<
    String
  >?
  onChanged;
=======
class OtpBox extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;
>>>>>>> 11527b2 (Initial commit)

  const OtpBox({
    super.key,
    required this.controller,
    this.onChanged,
  });

  @override
<<<<<<< HEAD
  Widget build(
    BuildContext context,
  ) {
=======
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
>>>>>>> 11527b2 (Initial commit)
    return Container(
      width: 60,
      height: 60,
      alignment: Alignment.center,
      decoration: BoxDecoration(
<<<<<<< HEAD
        borderRadius: BorderRadius.circular(
          12,
        ),
        border: Border.all(
          color: const Color(
            0xFF20C6B7,
          ),
          width: 1.5,
        ),
        color: Colors.white,
=======
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: theme.colorScheme.primary,
          width: 1.5,
        ),
        color: theme.colorScheme.surface,
>>>>>>> 11527b2 (Initial commit)
      ),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        maxLength: 1,
<<<<<<< HEAD
        style: const TextStyle(
          color: Color(
            0xFF1A2A2C,
          ),
=======
        style: TextStyle(
          color: theme.colorScheme.onSurface,
>>>>>>> 11527b2 (Initial commit)
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        decoration: const InputDecoration(
          counterText: "",
          border: InputBorder.none,
        ),
<<<<<<< HEAD
        onChanged:
            (
              value,
            ) {
              if (onChanged !=
                  null)
                onChanged!(
                  value,
                );
              if (value.isNotEmpty) {
                FocusScope.of(
                  context,
                ).nextFocus();
              }
            },
=======
        onChanged: (value) {
          if (onChanged != null) onChanged!(value);
          if (value.isNotEmpty) {
            FocusScope.of(context).nextFocus();
          }
        },
>>>>>>> 11527b2 (Initial commit)
      ),
    );
  }
}

// From SettingsScreen
<<<<<<< HEAD
class SettingItem
    extends
        StatelessWidget {
=======
class SettingItem extends StatelessWidget {
>>>>>>> 11527b2 (Initial commit)
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final String? trailing;
  final Color? textColor;

  const SettingItem({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
    this.trailing,
    this.textColor,
  });

  @override
<<<<<<< HEAD
  Widget build(
    BuildContext context,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(
          16,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(
            12,
          ),
          border: Border.all(
            color: Colors.grey.shade200,
          ),
=======
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final defaultTextColor = theme.colorScheme.onSurface;
    
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: theme.dividerColor),
>>>>>>> 11527b2 (Initial commit)
        ),
        child: Row(
          children: [
            Icon(
              icon,
<<<<<<< HEAD
              color:
                  textColor ??
                  const Color(
                    0xFF1A2A2C,
                  ),
              size: 22,
            ),
            const SizedBox(
              width: 14,
            ),
=======
              color: textColor ?? defaultTextColor,
              size: 22,
            ),
            const SizedBox(width: 14),
>>>>>>> 11527b2 (Initial commit)
            Expanded(
              child: Text(
                title,
                style: TextStyle(
<<<<<<< HEAD
                  color:
                      textColor ??
                      const Color(
                        0xFF1A2A2C,
                      ),
=======
                  color: textColor ?? defaultTextColor,
>>>>>>> 11527b2 (Initial commit)
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
<<<<<<< HEAD
            if (trailing !=
                null)
              Text(
                trailing!,
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 14,
                ),
              ),
            const SizedBox(
              width: 8,
            ),
            Icon(
              Icons.chevron_right,
              color: Colors.grey.shade400,
=======
            if (trailing != null)
              Text(
                trailing!,
                style: TextStyle(
                  color: theme.colorScheme.onSurfaceVariant,
                  fontSize: 14,
                ),
              ),
            const SizedBox(width: 8),
            Icon(
              Icons.chevron_right,
              color: theme.colorScheme.onSurfaceVariant,
>>>>>>> 11527b2 (Initial commit)
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}

// From SettingsScreen
<<<<<<< HEAD
class SettingItemWithSwitch
    extends
        StatelessWidget {
  final IconData icon;
  final String title;
  final bool value;
  final ValueChanged<
    bool
  >
  onChanged;
=======
class SettingItemWithSwitch extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool value;
  final ValueChanged<bool> onChanged;
>>>>>>> 11527b2 (Initial commit)

  const SettingItemWithSwitch({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
    required this.onChanged,
  });

  @override
<<<<<<< HEAD
  Widget build(
    BuildContext context,
  ) {
    return Container(
      padding: const EdgeInsets.all(
        16,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(
          12,
        ),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
=======
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: theme.dividerColor),
>>>>>>> 11527b2 (Initial commit)
      ),
      child: Row(
        children: [
          Icon(
            icon,
<<<<<<< HEAD
            color: const Color(
              0xFF1A2A2C,
            ),
            size: 22,
          ),
          const SizedBox(
            width: 14,
          ),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                color: Color(
                  0xFF1A2A2C,
                ),
=======
            color: theme.colorScheme.onSurface,
            size: 22,
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                color: theme.colorScheme.onSurface,
>>>>>>> 11527b2 (Initial commit)
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
<<<<<<< HEAD
            activeColor: const Color(
              0xFF20C6B7,
            ),
=======
>>>>>>> 11527b2 (Initial commit)
          ),
        ],
      ),
    );
  }
}
