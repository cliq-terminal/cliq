import 'package:flutter/cupertino.dart';

import 'package:cliq_ui/cliq_ui.dart';

class CliqTheme extends StatelessWidget {
  final CliqThemeData data;

  final TextDirection? textDirection;

  final Widget child;

  const CliqTheme({
    super.key,
    required this.data,
    required this.child,
    this.textDirection,
  });

  static CliqThemeData of(BuildContext context) {
    final theme = context.dependOnInheritedWidgetOfExactType<_InheritedTheme>();
    return theme?.data ?? CliqThemes.standard.light;
  }

  @override
  Widget build(BuildContext context) => _InheritedTheme(
    data: data,
    child: Directionality(
      textDirection:
          textDirection ?? Directionality.maybeOf(context) ?? TextDirection.ltr,
      child: DefaultTextStyle(
        style: data.typography.base.copyWith(
          fontFamily: CliqFontFamily.primary.fontFamily,
          color: data.colorScheme.onBackground,
        ),
        child: child,
      ),
    ),
  );
}

class _InheritedTheme extends InheritedWidget {
  final CliqThemeData data;

  const _InheritedTheme({required this.data, required super.child});

  @override
  bool updateShouldNotify(covariant _InheritedTheme old) => data != old.data;
}

extension ThemeBuildContext on BuildContext {
  CliqThemeData get theme => CliqTheme.of(this);
}
