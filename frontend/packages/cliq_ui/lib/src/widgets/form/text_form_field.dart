import 'package:cliq_ui/cliq_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class CliqTextFormField extends HookWidget {
  final TextEditingController? controller;
  final Widget? label;
  final Widget? hint;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool obscure;
  final CliqTextFieldStyle? style;

  final String? Function(Object?)? validator;
  final AutovalidateMode? autovalidateMode;

  const CliqTextFormField({
    super.key,
    this.controller,
    this.label,
    this.hint,
    this.prefixIcon,
    this.suffixIcon,
    this.obscure = false,
    this.style,
    this.validator,
    this.autovalidateMode
  });

  @override
  Widget build(BuildContext context) {
    return FormField(
      validator: validator,
      autovalidateMode: autovalidateMode,
      builder: (state) {
        return CliqTextField(
          label: label,
          hint: hint,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          obscure: obscure,
          style: style,
        );
      },
    );
  }
}
