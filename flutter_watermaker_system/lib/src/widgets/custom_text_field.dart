import 'package:flutter/material.dart';
import 'package:flutter_watermaker_system/flutter_watermaker_system.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final Widget? suffixIcon;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onFieldSubmitted;
  final TextInputType? keyboardType;

  const CustomTextField({
    super.key,
    this.controller,
    this.hintText,
    this.suffixIcon,
    this.onChanged,
    this.onFieldSubmitted,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    final theme = CustomTheme.of(context);
    final inputBorder = OutlineInputBorder(
      borderSide: BorderSide(width: 1, color: theme.colors.secondary2),
      borderRadius: BorderRadius.circular(24),
    );

    return TextFormField(
      controller: controller,
      style: theme.fontStyle.bodyMedium,
      onChanged: onChanged,
      onFieldSubmitted: onFieldSubmitted,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: theme.fontStyle.bodyMedium.cl(Colors.black38),
        border: inputBorder,
        enabledBorder: inputBorder,
        focusedBorder: inputBorder,
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 1, color: Colors.redAccent),
          borderRadius: BorderRadius.circular(24),
        ),
        suffixIcon: suffixIcon,
      ),
    );
  }
}
