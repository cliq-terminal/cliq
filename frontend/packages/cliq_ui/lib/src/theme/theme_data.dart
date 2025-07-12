import 'package:cliq_ui/cliq_ui.dart';
import 'package:cliq_ui/src/widgets/blur_background.dart';

final class CliqThemeData {
  final CliqColorScheme colorScheme;
  final CliqTypography typography;
  final CliqStyle style;

  final CliqBottomNavigationBarStyle bottomNavigationBarStyle;
  final CliqAppBarStyle appBarStyle;
  final CliqBlurBackgroundStyle blurBackgroundStyle;
  final CliqIconButtonStyle iconButtonStyle;
  final CliqScaffoldStyle scaffoldStyle;

  const CliqThemeData({
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
      CliqBottomNavigationBarStyle.inherit(style: style, colorScheme: colorScheme),
      appBarStyle: CliqAppBarStyle.inherit(style: style, colorScheme: colorScheme),
      blurBackgroundStyle: CliqBlurBackgroundStyle.inherit(style: style, colorScheme: colorScheme),
      iconButtonStyle: CliqIconButtonStyle.inherit(style: style, colorScheme: colorScheme),
      scaffoldStyle: CliqScaffoldStyle.inherit(colorScheme: colorScheme),
    );
  }
}
