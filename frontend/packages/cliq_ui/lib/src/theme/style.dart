import 'package:cliq_ui/cliq_ui.dart';
import 'package:flutter/cupertino.dart';

final class CliqStyle {
  final BorderRadius borderRadius;
  final double borderWidth;
  final EdgeInsets pagePadding;

  const CliqStyle({
    this.borderRadius = const BorderRadius.all(Radius.circular(8)),
    this.borderWidth = 1,
    this.pagePadding = const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
  });

  CliqStyle.inherit({
    required CliqColorScheme colorScheme,
    required CliqTypography typography,
  }) : this();
}
