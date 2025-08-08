import 'dart:ui';

import 'package:cliq_ui/cliq_ui.dart';

extension CliqThemes on Never {
  static final standard = (
    light: CliqThemeData.inherit(
      colorScheme: const CliqColorScheme(
        brightness: Brightness.dark,
        background: Color(0xFFFFFFFF),
        onBackground: Color(0xFF000000),
        secondaryBackground: Color(0xFFCBCBCB),
        onSecondaryBackground: Color(0xFF000000),
      ),
    ),
    dark: CliqThemeData.inherit(
      colorScheme: const CliqColorScheme(
        brightness: Brightness.dark,
        background: Color(0xFF161616),
        onBackground: Color(0xFFFFFFFF),
        secondaryBackground: Color(0xFF292929),
        onSecondaryBackground: Color(0xFFFFFFFF),
      ),
    ),
  );
}
