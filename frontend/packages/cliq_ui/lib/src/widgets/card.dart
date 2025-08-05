import 'package:flutter/cupertino.dart';

import 'package:cliq_ui/cliq_ui.dart';

class CliqCard extends StatelessWidget {
  final Widget? title;
  final Widget? subtitle;
  final Widget? leading;
  final Widget? trailing;
  final Function()? onTap;
  final Widget? child;
  final CliqCardStyle? style;

  const CliqCard({
    super.key,
    this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.onTap,
    this.child,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    final style = this.style ?? context.theme.cardStyle;

    return CliqInteractable(
      onTap: onTap,
      child: CliqBlurContainer(
        borderRadius: style.borderRadius,
        child: Padding(
          padding: style.padding,
          child: Row(
            children: [
              if (leading != null)
                IconTheme(data: style.iconStyle, child: leading!),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (title != null)
                      DefaultTextStyle.merge(
                        style: context.theme.typography.xl.copyWith(
                          fontFamily: CliqFontFamily.secondary.fontFamily,
                          color:
                              context.theme.colorScheme.onSecondaryBackground,
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
                    if (child != null) ...[const SizedBox(height: 16), child!],
                  ],
                ),
              ),
              if (trailing != null)
                IconTheme(data: style.iconStyle, child: trailing!),
            ],
          ),
        ),
      ),
    );
  }
}

final class CliqCardStyle {
  final IconThemeData iconStyle;
  final BorderRadiusGeometry borderRadius;
  final EdgeInsetsGeometry padding;

  const CliqCardStyle({
    required this.iconStyle,
    required this.borderRadius,
    required this.padding,
  });

  factory CliqCardStyle.inherit({
    required CliqStyle style,
    required CliqColorScheme colorScheme,
  }) {
    return CliqCardStyle(
      iconStyle: IconThemeData(
        color: colorScheme.onSecondaryBackground,
        size: 24,
      ),
      borderRadius: BorderRadius.circular(24),
      padding: const EdgeInsets.all(16),
    );
  }
}
