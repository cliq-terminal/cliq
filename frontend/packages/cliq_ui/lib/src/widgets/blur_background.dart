import 'dart:ui';

import 'package:cliq_ui/cliq_ui.dart';
import 'package:flutter/cupertino.dart';

class CliqBlurBackground extends StatelessWidget {
  final Widget? child;
  final BorderRadiusGeometry? borderRadius;
  final CliqBlurBackgroundStyle? style;

  const CliqBlurBackground({
    super.key,
    this.child,
    this.borderRadius,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    final style = this.style ?? context.theme.blurBackgroundStyle;

    return ClipRRect(
      borderRadius: borderRadius ?? style.borderRadius,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: style.blur, sigmaY: style.blur),
        child: ColoredBox(color: style.color, child: child),
      ),
    );
  }
}

final class CliqBlurBackgroundStyle {
  final Color color;
  final double blur;
  final BorderRadiusGeometry borderRadius;

  const CliqBlurBackgroundStyle({
    required this.color,
    required this.blur,
    required this.borderRadius,
  });

  factory CliqBlurBackgroundStyle.inherit({
    required CliqStyle style,
    required CliqColorScheme colorScheme,
  }) {
    return CliqBlurBackgroundStyle(
      color: colorScheme.secondaryBackground.withValues(alpha: .5),
      blur: 7.0,
      borderRadius: BorderRadius.circular(25),
    );
  }
}
