import 'package:cliq_ui/cliq_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class CliqTextField extends HookWidget {
  final TextEditingController? controller;
  final Widget? label;
  final Widget? hint;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool obscure;
  final CliqTextFieldStyle? style;

  const CliqTextField({
    super.key,
    this.controller,
    this.label,
    this.hint,
    this.prefixIcon,
    this.suffixIcon,
    this.obscure = false,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    final breakpoint = useBreakpoint();
    final typography = context.theme.typography;
    final style = this.style ?? context.theme.textFieldStyle;

    return Column(
      spacing: 8,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null)
          CliqDefaultTypography(size: typography.copyS, child: label!),
        CliqBlurContainer(
          borderRadius: style.borderRadius,
          child: Material(
            color: Colors.transparent,
            child: Padding(
              padding: style.padding,
              child: Theme(
                data: ThemeData(
                  textSelectionTheme: TextSelectionThemeData(
                    cursorColor: style.cursorColor,
                    selectionColor: style.selectionColor,
                  ),
                ),
                child: TextField(
                  controller: controller,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    iconColor: style.iconStyle.color,
                    prefixIcon: prefixIcon,
                    suffixIcon: suffixIcon,
                    hint: hint != null
                        ? CliqDefaultTypography(
                            size: typography.copyS,
                            color: style.hintColor,
                            fontFamily: CliqFontFamily.secondary,
                            child: hint!,
                          )
                        : null,
                  ),
                  obscureText: obscure,
                  style: typography.copyS[breakpoint]!.style,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

final class CliqTextFieldStyle {
  final IconThemeData iconStyle;
  final Color cursorColor;
  final Color selectionColor;
  final Color hintColor;
  final BorderRadiusGeometry borderRadius;
  final EdgeInsetsGeometry padding;

  const CliqTextFieldStyle({
    required this.iconStyle,
    required this.cursorColor,
    required this.selectionColor,
    required this.hintColor,
    required this.borderRadius,
    required this.padding,
  });

  factory CliqTextFieldStyle.inherit({
    required CliqStyle style,
    required CliqColorScheme colorScheme,
  }) {
    return CliqTextFieldStyle(
      iconStyle: IconThemeData(
        color: colorScheme.onSecondaryBackground,
        size: 24,
      ),
      cursorColor: colorScheme.primary,
      selectionColor: colorScheme.primary30,
      hintColor: colorScheme.onPrimary50,
      borderRadius: BorderRadius.circular(24),
      padding: const EdgeInsets.symmetric(horizontal: 16),
    );
  }
}
