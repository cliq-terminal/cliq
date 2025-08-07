import 'package:cliq_ui/cliq_ui.dart';

final class CliqThemeData {
  final CliqBreakpoints breakpoints;
  final CliqGrid grid;
  final CliqColorScheme colorScheme;
  final CliqTypography typography;
  final CliqStyle style;

  final CliqBottomNavigationBarStyle bottomNavigationBarStyle;
  final CliqAppBarStyle appBarStyle;
  final CliqBlurContainerStyle blurContainerStyle;
  final CliqCardStyle cardStyle;
  final CliqChipStyle chipStyle;
  final CliqIconButtonStyle iconButtonStyle;
  final CliqScaffoldStyle scaffoldStyle;

  const CliqThemeData({
    required this.breakpoints,
    required this.grid,
    required this.colorScheme,
    this.typography = const CliqTypography(),
    required this.style,
    required this.bottomNavigationBarStyle,
    required this.appBarStyle,
    required this.blurContainerStyle,
    required this.cardStyle,
    required this.chipStyle,
    required this.iconButtonStyle,
    required this.scaffoldStyle,
  });

  factory CliqThemeData.inherit({
    required CliqColorScheme colorScheme,
    CliqBreakpoints? breakpoints,
    CliqGrid? grid,
    CliqTypography? typography,
    CliqStyle? style,
  }) {
    typography ??= CliqTypography.inherit(colorScheme: colorScheme);
    style ??= CliqStyle.inherit(
      colorScheme: colorScheme,
      typography: typography,
    );
    return CliqThemeData(
      breakpoints: breakpoints ?? CliqBreakpoints(),
      grid: grid ?? const CliqGrid(),
      colorScheme: colorScheme,
      typography: typography,
      style: style,
      bottomNavigationBarStyle: CliqBottomNavigationBarStyle.inherit(
        colorScheme: colorScheme,
      ),
      appBarStyle: CliqAppBarStyle.inherit(
        style: style,
        colorScheme: colorScheme,
      ),
      blurContainerStyle: CliqBlurContainerStyle.inherit(
        style: style,
        colorScheme: colorScheme,
      ),
      cardStyle: CliqCardStyle.inherit(style: style, colorScheme: colorScheme),
      chipStyle: CliqChipStyle.inherit(style: style, colorScheme: colorScheme),
      iconButtonStyle: CliqIconButtonStyle.inherit(
        style: style,
        colorScheme: colorScheme,
      ),
      scaffoldStyle: CliqScaffoldStyle.inherit(colorScheme: colorScheme),
    );
  }
}
