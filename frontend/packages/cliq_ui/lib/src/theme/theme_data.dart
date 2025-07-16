import 'package:cliq_ui/cliq_ui.dart';
import 'package:cliq_ui/src/widgets/blur_background.dart';

final class CliqThemeData {
  final CliqBreakpoints breakpoints;
  final CliqColorScheme colorScheme;
  final CliqTypography typography;
  final CliqStyle style;

  final CliqBottomNavigationBarStyle bottomNavigationBarStyle;
  final CliqAppBarStyle appBarStyle;
  final CliqBlurBackgroundStyle blurBackgroundStyle;
  final CliqIconButtonStyle iconButtonStyle;
  final CliqScaffoldStyle scaffoldStyle;

  const CliqThemeData({
    required this.breakpoints,
    required this.colorScheme,
    this.typography = const CliqTypography(),
    required this.style,
    required this.bottomNavigationBarStyle,
    required this.appBarStyle,
    required this.blurBackgroundStyle,
    required this.iconButtonStyle,
    required this.scaffoldStyle,
  });

  factory CliqThemeData.inherit({
    required CliqColorScheme colorScheme,
    CliqBreakpoints? breakpoints,
    CliqTypography? typography,
    CliqStyle? style,
  }) {
    typography ??= CliqTypography.inherit(colorScheme: colorScheme);
    style ??=
        CliqStyle.inherit(colorScheme: colorScheme, typography: typography);
    return CliqThemeData(
      breakpoints: breakpoints ?? const CliqBreakpoints(),
      colorScheme: colorScheme,
      typography: typography,
      style: style,
      bottomNavigationBarStyle:
      CliqBottomNavigationBarStyle.inherit(colorScheme: colorScheme),
      appBarStyle: CliqAppBarStyle.inherit(style: style, colorScheme: colorScheme),
      blurBackgroundStyle: CliqBlurBackgroundStyle.inherit(style: style, colorScheme: colorScheme),
      iconButtonStyle: CliqIconButtonStyle.inherit(style: style, colorScheme: colorScheme),
      scaffoldStyle: CliqScaffoldStyle.inherit(colorScheme: colorScheme),
    );
  }
}
