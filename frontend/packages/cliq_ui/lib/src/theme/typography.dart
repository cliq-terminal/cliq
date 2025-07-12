import 'package:flutter/widgets.dart';

import 'package:cliq_ui/cliq_ui.dart';

enum CliqFontFamily {
  primary('packages/cliq_ui/Inter'),
  secondary('packages/cliq_ui/IBMPlexMono'),;

  final String fontFamily;

  const CliqFontFamily(this.fontFamily);
}

final class CliqTypography {
  final TextStyle xxs;
  final TextStyle xs;
  final TextStyle sm;
  final TextStyle base;
  final TextStyle lg;
  final TextStyle xl;
  final TextStyle xl2;
  final TextStyle xl3;
  final TextStyle xl4;
  final TextStyle xl5;
  final TextStyle xl6;
  final TextStyle xl7;
  final TextStyle xl8;

  const CliqTypography({
    this.xxs = const TextStyle(fontSize: 10, height: 1),
    this.xs = const TextStyle(fontSize: 12, height: 1),
    this.sm = const TextStyle(fontSize: 14, height: 1.25),
    this.base = const TextStyle(fontSize: 16, height: 1.5),
    this.lg = const TextStyle(fontSize: 18, height: 1.75),
    this.xl = const TextStyle(fontSize: 20, height: 1.75),
    this.xl2 = const TextStyle(fontSize: 22, height: 2),
    this.xl3 = const TextStyle(fontSize: 30, height: 2.25),
    this.xl4 = const TextStyle(fontSize: 36, height: 2.5),
    this.xl5 = const TextStyle(fontSize: 48, height: 1),
    this.xl6 = const TextStyle(fontSize: 60, height: 1),
    this.xl7 = const TextStyle(fontSize: 72, height: 1),
    this.xl8 = const TextStyle(fontSize: 96, height: 1),
  });

  CliqTypography.inherit({required CliqColorScheme colorScheme, CliqFontFamily font = CliqFontFamily.primary})
    : xxs = TextStyle(color: colorScheme.onBackground, fontFamily: font.fontFamily, fontSize: 10, height: 1),
      xs = TextStyle(color: colorScheme.onBackground, fontFamily: font.fontFamily, fontSize: 12, height: 1),
      sm = TextStyle(color: colorScheme.onBackground, fontFamily: font.fontFamily, fontSize: 14, height: 1.25),
      base = TextStyle(color: colorScheme.onBackground, fontFamily: font.fontFamily, fontSize: 16, height: 1.5),
      lg = TextStyle(color: colorScheme.onBackground, fontFamily: font.fontFamily, fontSize: 18, height: 1.75),
      xl = TextStyle(color: colorScheme.onBackground, fontFamily: font.fontFamily, fontSize: 20, height: 1.75),
      xl2 = TextStyle(color: colorScheme.onBackground, fontFamily: font.fontFamily, fontSize: 22, height: 2),
      xl3 = TextStyle(color: colorScheme.onBackground, fontFamily: font.fontFamily, fontSize: 30, height: 2.25),
      xl4 = TextStyle(color: colorScheme.onBackground, fontFamily: font.fontFamily, fontSize: 36, height: 2.5),
      xl5 = TextStyle(color: colorScheme.onBackground, fontFamily: font.fontFamily, fontSize: 48, height: 1),
      xl6 = TextStyle(color: colorScheme.onBackground, fontFamily: font.fontFamily, fontSize: 60, height: 1),
      xl7 = TextStyle(color: colorScheme.onBackground, fontFamily: font.fontFamily, fontSize: 72, height: 1),
      xl8 = TextStyle(color: colorScheme.onBackground, fontFamily: font.fontFamily, fontSize: 96, height: 1);
}
