import 'package:cliq_ui/cliq_ui.dart';

final class CliqThemeData {
  final CliqColorScheme colorScheme;
  final CliqTypography typography;
  final CliqStyle style;

  final CliqBottomNavigationBarStyle bottomNavigationBarStyle;
  final CliqScaffoldStyle scaffoldStyle;

  const CliqThemeData({
    required this.colorScheme,
    this.typography = const CliqTypography(),
    required this.style,
    required this.bottomNavigationBarStyle,
    required this.scaffoldStyle,
  });

  factory CliqThemeData.inherit({
    required CliqColorScheme colorScheme,
    CliqTypography? typography,
    CliqStyle? style,
  }) {
    typography ??= CliqTypography.inherit(colorScheme: colorScheme);
    style ??=
        CliqStyle.inherit(colorScheme: colorScheme, typography: typography);
    return CliqThemeData(
      colorScheme: colorScheme,
      typography: typography,
      style: style,
      bottomNavigationBarStyle:
      CliqBottomNavigationBarStyle.inherit(colorScheme: colorScheme),
      scaffoldStyle: CliqScaffoldStyle.inherit(colorScheme: colorScheme),
    );
  }
}
