import 'package:cliq_ui/cliq_ui.dart';
import 'package:flutter/cupertino.dart';

class CliqScaffold extends StatelessWidget {
  final Widget body;
  final Widget? header;
  final Widget? footer;
  final bool extendBehindAppBar;
  final bool safeAreaTop;
  final CliqScaffoldStyle? style;

  const CliqScaffold({
    super.key,
    required this.body,
    this.header,
    this.footer,
    this.extendBehindAppBar = false,
    this.safeAreaTop = false,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    final style = this.style ?? context.theme.scaffoldStyle;

    buildDefaultLayout() {
      return [
        ?header,
        Expanded(child: body),
        ?footer
      ];
    }

    buildExtendedLayout() {
      return [
        Expanded(
            child: Stack(
              children: [
                Positioned.fill(child: body),
                if (header != null)
                  Positioned(
                    top: 0,
                    child: header!,
                  ),
                if (footer != null)
                  Positioned(
                    bottom: 0,
                    child: footer!,
                  ),
              ],
            )),
      ];
    }

    return SafeArea(
      top: safeAreaTop,
      bottom: false,
      left: false,
      right: false,
      child: ColoredBox(
        color: style.backgroundColor,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ...(extendBehindAppBar
                ? buildExtendedLayout()
                : buildDefaultLayout()),
          ],
        ),
      ),
    );
  }
}

final class CliqScaffoldStyle {
  final Color backgroundColor;

  const CliqScaffoldStyle({required this.backgroundColor});

  factory CliqScaffoldStyle.inherit({required CliqColorScheme colorScheme}) {
    return CliqScaffoldStyle(backgroundColor: colorScheme.background);
  }
}
