import 'package:cliq_ui/src/widgets/progress_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:cliq_ui/cliq_ui.dart';

part 'progress_header.dart';

class CliqHeader extends StatelessWidget {
  final Widget? title;
  final List<Widget>? left;
  final List<Widget>? right;
  final CliqAppBarStyle? style;

  const CliqHeader({super.key, this.title, this.left, this.right, this.style});

  const factory CliqHeader.progress({
    Key? key,
    List<Widget>? left,
    List<Widget>? right,
    CliqAppBarStyle? style,
    required double progress,
  }) = _CliqProgressHeader;

  @override
  Widget build(BuildContext context) {
    final style = this.style ?? context.theme.appBarStyle;
    final textStyle = context.theme.typography;

    return Padding(
      padding: EdgeInsets.only(top: style.verticalPagePadding),
      child: CliqGridContainer(
        children: [
          CliqGridRow(
            children: [
              CliqGridColumn(
                child: Row(
                  mainAxisAlignment:
                      (left != null && left!.isNotEmpty) || title != null
                      ? MainAxisAlignment.spaceBetween
                      : MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (left != null)
                      Row(
                        spacing: 8,
                        mainAxisSize: MainAxisSize.min,
                        children: left!,
                      ),
                    if (title != null)
                      CliqBlurContainer(
                        child: CliqDefaultTypography(
                          size: textStyle.copyXL,
                          color: style.textColor,
                          fontFamily: CliqFontFamily.secondary,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 32),
                            child: title ?? const SizedBox.shrink(),
                          ),
                        ),
                      ),
                    if (right != null)
                      Row(
                        spacing: 8,
                        mainAxisSize: MainAxisSize.min,
                        children: right!,
                      ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

final class CliqAppBarStyle {
  final Color textColor;
  final double verticalPagePadding;

  const CliqAppBarStyle({
    required this.textColor,
    required this.verticalPagePadding,
  });

  factory CliqAppBarStyle.inherit({
    required CliqStyle style,
    required CliqColorScheme colorScheme,
  }) {
    return CliqAppBarStyle(
      textColor: colorScheme.onSecondaryBackground,
      verticalPagePadding: style.verticalPagePadding,
    );
  }
}
