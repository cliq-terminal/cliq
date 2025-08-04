import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:cliq_ui/cliq_ui.dart';

class CliqAppBar extends StatelessWidget {
  final Widget? title;
  final List<Widget>? left;
  final List<Widget>? right;
  final CliqAppBarStyle? style;

  const CliqAppBar({super.key, this.title, this.left, this.right, this.style});

  @override
  Widget build(BuildContext context) {
    final style = this.style ?? context.theme.appBarStyle;
    final textStyle = context.theme.typography;

    return Padding(
      padding: EdgeInsets.only(
        top: style.pagePadding.vertical,
        left: style.pagePadding.horizontal,
        right: style.pagePadding.horizontal,
      ),
      child: Row(
        mainAxisAlignment: (left != null && left!.isNotEmpty) || title != null
            ? MainAxisAlignment.spaceBetween
            : MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (left != null)
            Row(spacing: 8, mainAxisSize: MainAxisSize.min, children: left!),
          if (title != null)
            CliqBlurContainer(
              child: DefaultTextStyle.merge(
                style: textStyle.xl.copyWith(
                  fontFamily: CliqFontFamily.secondary.fontFamily,
                  color: style.textColor,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: title ?? const SizedBox.shrink(),
                ),
              ),
            ),
          if (right != null)
            Row(spacing: 8, mainAxisSize: MainAxisSize.min, children: right!),
        ],
      ),
    );
  }
}

final class CliqAppBarStyle {
  final Color textColor;
  final EdgeInsetsGeometry pagePadding;

  const CliqAppBarStyle({required this.textColor, required this.pagePadding});

  factory CliqAppBarStyle.inherit({
    required CliqStyle style,
    required CliqColorScheme colorScheme,
  }) {
    return CliqAppBarStyle(
      textColor: colorScheme.onSecondaryBackground,
      pagePadding: style.pagePadding,
    );
  }
}
