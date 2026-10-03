import 'package:flutter/material.dart';

class AppTextField extends StatefulWidget {
  final String label;
  final String? hint;
  final String? initialValue;
  final TextEditingController? controller;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final VoidCallback? onSuffixTap;
  final bool isPassword;
  final bool isRequired;
  final bool isReadOnly;
  final bool isMultiline;
  final int? maxLines;
  final int? minLines;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final FocusNode? focusNode;
  final String? errorText;
  final bool showCounter;
  final int? maxLength;
  
  const AppTextField({
    super.key,
    required this.label,
    this.hint,
    this.initialValue,
    this.controller,
    this.prefixIcon,
    this.suffixIcon,
    this.onSuffixTap,
    this.isPassword = false,
    this.isRequired = false,
    this.isReadOnly = false,
    this.isMultiline = false,
    this.maxLines,
    this.minLines,
    this.keyboardType,
    this.validator,
    this.onChanged,
    this.onSubmitted,
    this.focusNode,
    this.errorText,
    this.showCounter = false,
    this.maxLength,
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late TextEditingController _controller;
  bool _obscureText = true;
  String? _error;
  
  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController(text: widget.initialValue);
    _obscureText = widget.isPassword;
  }
  
  @override
  void didUpdateWidget(AppTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller == null &&
        widget.initialValue != oldWidget.initialValue) {
      _controller.text = widget.initialValue ?? '';
    }
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      obscureText: widget.isPassword ? _obscureText : false,
      readOnly: widget.isReadOnly,
      keyboardType: widget.keyboardType,
      maxLines: widget.isMultiline ? (widget.maxLines ?? 3) : (widget.maxLines ?? 1),
      minLines: widget.minLines,
      maxLength: widget.maxLength,
      focusNode: widget.focusNode,
      validator: widget.validator ?? (widget.isRequired ? _requiredValidator : null),
      onChanged: (value) {
        setState(() {
          _error = null;
        });
        widget.onChanged?.call(value);
      },
      onFieldSubmitted: widget.onSubmitted,
      decoration: InputDecoration(
        labelText: widget.isRequired ? '${widget.label} *' : widget.label,
        hintText: widget.hint,
        errorText: widget.errorText ?? _error,
        prefixIcon: widget.prefixIcon != null ? Icon(widget.prefixIcon) : null,
        suffixIcon: _buildSuffixIcon(),
        counterText: widget.showCounter ? null : '',
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
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.error,
            width: 2,
          ),
        ),
        filled: true,
        fillColor: widget.isReadOnly
            ? Theme.of(context).disabledColor.withValues(alpha: 0.05)
            : null,
      ),
    );
  }
  
  Widget? _buildSuffixIcon() {
    if (widget.isPassword) {
      return IconButton(
        icon: Icon(
          _obscureText ? Icons.visibility_outlined : Icons.visibility_off_outlined,
        ),
        onPressed: () {
          setState(() {
            _obscureText = !_obscureText;
          });
        },
      );
    }
    
    if (widget.suffixIcon != null) {
      return IconButton(
        icon: Icon(widget.suffixIcon),
        onPressed: widget.onSuffixTap,
      );
    }
    
    return null;
  }
  
  String? _requiredValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'هذا الحقل مطلوب';
    }
    return null;
  }
}
