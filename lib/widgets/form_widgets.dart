import 'package:flutter/material.dart';

// From AddMedicinePage
class CustomInputField
    extends
        StatelessWidget {
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
  Widget build(
    BuildContext context,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
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
class OtpBox
    extends
        StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<
    String
  >?
  onChanged;

  const OtpBox({
    super.key,
    required this.controller,
    this.onChanged,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    return Container(
      width: 60,
      height: 60,
      alignment: Alignment.center,
      decoration: BoxDecoration(
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
      ),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        maxLength: 1,
        style: const TextStyle(
          color: Color(
            0xFF1A2A2C,
          ),
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        decoration: const InputDecoration(
          counterText: "",
          border: InputBorder.none,
        ),
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
      ),
    );
  }
}

// From SettingsScreen
class SettingItem
    extends
        StatelessWidget {
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
        ),
        child: Row(
          children: [
            Icon(
              icon,
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
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color:
                      textColor ??
                      const Color(
                        0xFF1A2A2C,
                      ),
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
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
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}

// From SettingsScreen
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

  const SettingItemWithSwitch({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
    required this.onChanged,
  });

  @override
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
      ),
      child: Row(
        children: [
          Icon(
            icon,
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
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: const Color(
              0xFF20C6B7,
            ),
          ),
        ],
      ),
    );
  }
}
