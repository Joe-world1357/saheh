import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../core/validators/validators.dart';
import '../../core/validators/input_formatters.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';

/// Reusable text field with automatic validation and theming
class AppTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? label;
  final String? hint;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final bool obscureText;
  final int? maxLines;
  final int? maxLength;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final VoidCallback? onSuffixTap;
  final bool enabled;
  final String? helperText;
  final FocusNode? focusNode;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onTap;
  final bool readOnly;
  final List<TextInputFormatter>? inputFormatters;
  final TextCapitalization textCapitalization;

  const AppTextField({
    super.key,
    required this.controller,
    this.label,
    this.hint,
    this.validator,
    this.keyboardType,
    this.obscureText = false,
    this.maxLines = 1,
    this.maxLength,
    this.prefixIcon,
    this.suffixIcon,
    this.onSuffixTap,
    this.enabled = true,
    this.helperText,
    this.focusNode,
    this.onChanged,
    this.onTap,
    this.readOnly = false,
    this.inputFormatters,
    this.textCapitalization = TextCapitalization.none,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = AppColors.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Text(
            label!,
            style: AppTextStyles.labelLarge(context),
          ),
          const SizedBox(height: 8),
        ],
        TextFormField(
          controller: controller,
          validator: validator ?? Validators.required,
          keyboardType: keyboardType,
          obscureText: obscureText,
          maxLines: obscureText ? 1 : maxLines,
          maxLength: maxLength,
          enabled: enabled,
          focusNode: focusNode,
          onChanged: onChanged,
          onTap: onTap,
          readOnly: readOnly,
          inputFormatters: inputFormatters,
          textCapitalization: textCapitalization,
          style: AppTextStyles.bodyLarge(context),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: AppTextStyles.bodyLarge(context).copyWith(
              color: colors.textSecondary,
            ),
            prefixIcon: prefixIcon != null
                ? Icon(prefixIcon, color: colors.primary)
                : null,
            suffixIcon: suffixIcon != null
                ? IconButton(
                    icon: Icon(suffixIcon),
                    onPressed: onSuffixTap,
                    color: colors.textSecondary,
                  )
                : null,
            helperText: helperText,
            helperStyle: AppTextStyles.bodySmall(context).copyWith(
              color: colors.textSecondary,
            ),
            counterText: maxLength != null ? '' : null,
            filled: true,
            fillColor: colors.surface,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: colors.border),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: colors.border),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: colors.primary, width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: colors.error),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: colors.error, width: 2),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: colors.border.withOpacity(0.5)),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
          ),
        ),
      ],
    );
  }
}

/// Number field with automatic validation and formatting
class AppNumberField extends StatelessWidget {
  final TextEditingController controller;
  final String? label;
  final String? hint;
  final String? Function(String?)? validator;
  final int? min;
  final int? max;
  final bool allowDecimal;
  final String? suffix;
  final IconData? prefixIcon;
  final bool enabled;
  final String? helperText;
  final FocusNode? focusNode;
  final ValueChanged<String>? onChanged;

  const AppNumberField({
    super.key,
    required this.controller,
    this.label,
    this.hint,
    this.validator,
    this.min,
    this.max,
    this.allowDecimal = false,
    this.suffix,
    this.prefixIcon,
    this.enabled = true,
    this.helperText,
    this.focusNode,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    
    List<TextInputFormatter> formatters = [
      if (allowDecimal)
        AppInputFormatters.numberWithDecimal
      else
        AppInputFormatters.digitsOnly,
      AppInputFormatters.noLeadingZeros(),
    ];

    if (max != null) {
      formatters.add(AppInputFormatters.maxValue(max!.toDouble()));
    }
    if (min != null) {
      formatters.add(AppInputFormatters.minValue(min!.toDouble()));
    }

    return AppTextField(
      controller: controller,
      label: label,
      hint: hint,
      validator: validator ??
          (value) => Validators.number(
                value,
                min: min,
                max: max,
                fieldName: label,
                allowDecimal: allowDecimal,
              ),
      keyboardType: allowDecimal
          ? const TextInputType.numberWithOptions(decimal: true)
          : TextInputType.number,
      inputFormatters: formatters,
      prefixIcon: prefixIcon,
      enabled: enabled,
      helperText: helperText,
      focusNode: focusNode,
      onChanged: onChanged,
      suffixIcon: suffix != null ? Icons.info_outline : null,
    );
  }
}

/// Password field with visibility toggle
class AppPasswordField extends StatefulWidget {
  final TextEditingController controller;
  final String? label;
  final String? hint;
  final String? Function(String?)? validator;
  final int minLength;
  final bool enabled;
  final String? helperText;
  final FocusNode? focusNode;
  final ValueChanged<String>? onChanged;

  const AppPasswordField({
    super.key,
    required this.controller,
    this.label,
    this.hint,
    this.validator,
    this.minLength = 6,
    this.enabled = true,
    this.helperText,
    this.focusNode,
    this.onChanged,
  });

  @override
  State<AppPasswordField> createState() => _AppPasswordFieldState();
}

class _AppPasswordFieldState extends State<AppPasswordField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      controller: widget.controller,
      label: widget.label ?? 'Password',
      hint: widget.hint ?? 'Enter password',
      validator: widget.validator ??
          (value) => Validators.password(value, minLength: widget.minLength),
      keyboardType: TextInputType.visiblePassword,
      obscureText: _obscureText,
      prefixIcon: Icons.lock_outline,
      suffixIcon: _obscureText ? Icons.visibility : Icons.visibility_off,
      onSuffixTap: () => setState(() => _obscureText = !_obscureText),
      enabled: widget.enabled,
      helperText: widget.helperText,
      focusNode: widget.focusNode,
      onChanged: widget.onChanged,
    );
  }
}

/// Email field with automatic validation
class AppEmailField extends StatelessWidget {
  final TextEditingController controller;
  final String? label;
  final String? hint;
  final bool enabled;
  final FocusNode? focusNode;
  final ValueChanged<String>? onChanged;

  const AppEmailField({
    super.key,
    required this.controller,
    this.label,
    this.hint,
    this.enabled = true,
    this.focusNode,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      controller: controller,
      label: label ?? 'Email',
      hint: hint ?? 'Enter email address',
      validator: Validators.email,
      keyboardType: TextInputType.emailAddress,
      inputFormatters: [AppInputFormatters.email()],
      prefixIcon: Icons.email_outlined,
      enabled: enabled,
      focusNode: focusNode,
      onChanged: onChanged,
      textCapitalization: TextCapitalization.none,
    );
  }
}

