import 'dart:math';

import 'package:flutter/cupertino.dart';

final class CliqColorScheme {
  final Brightness brightness;
  final Color background;
  final Color onBackground;
  final Color secondaryBackground;
  final Color onSecondaryBackground;

  const CliqColorScheme({
    required this.brightness,
    required this.background,
    required this.onBackground,
    required this.secondaryBackground,
    required this.onSecondaryBackground,
  });
}
