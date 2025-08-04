import 'package:flutter/cupertino.dart';

import 'package:cliq_ui/cliq_ui.dart';

// TODO: Work in progress

class CliqCard extends StatelessWidget {
  final Widget? title;
  final Widget? subtitle;
  final Function()? onTap;
  final Widget? child;
  final CliqCardStyle? style;

  const CliqCard({
    super.key,
    this.title,
    this.subtitle,
    this.onTap,
    this.child,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    final style = this.style ?? context.theme.iconButtonStyle;

    return CliqInteractable(
      onTap: onTap,
      child: CliqBlurContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (title != null)
              DefaultTextStyle.merge(
                style: context.theme.typography.xl.copyWith(
                  fontFamily: CliqFontFamily.secondary.fontFamily,
                  color: context.theme.colorScheme.onSecondaryBackground,
                ),
                child: title!,
              ),
            if (subtitle != null)
              DefaultTextStyle.merge(
                style: context.theme.typography.base.copyWith(
                  fontFamily: CliqFontFamily.primary.fontFamily,
                  color: context.theme.colorScheme.onSecondaryBackground
                      .withValues(alpha: .7),
                ),
                child: subtitle!,
              ),
            ?child,
          ],
        ),
      ),
    );
  }
}

// TODO: add styles

final class CliqCardStyle {
  const CliqCardStyle();

  factory CliqCardStyle.inherit({
    required CliqStyle style,
    required CliqColorScheme colorScheme,
  }) {
    return CliqCardStyle();
  }
}
