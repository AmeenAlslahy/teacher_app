import 'package:flutter/material.dart';

class AppDropdown<T> extends StatelessWidget {
  final String label;
  final T? value;
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?>? onChanged;
  final bool isRequired;
  final String? Function(T?)? validator;
  final IconData? prefixIcon;
  final bool isReadOnly;
  
  const AppDropdown({
    super.key,
    required this.label,
    required this.items,
    this.value,
    this.onChanged,
    this.isRequired = false,
    this.validator,
    this.prefixIcon,
    this.isReadOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      initialValue: value,
      items: items,
      onChanged: isReadOnly ? null : onChanged,
      validator: validator ?? (isRequired ? _requiredValidator : null),
      decoration: InputDecoration(
        labelText: isRequired ? '$label *' : label,
        prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Theme.of(context).dividerColor,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primary,
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.error,
          ),
        ),
      ),
    );
  }
  
  String? _requiredValidator(T? value) {
    if (value == null) {
      return 'هذا الحقل مطلوب';
    }
    return null;
  }
}
