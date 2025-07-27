import 'package:cliq_ui/cliq_ui.dart';
import 'package:cliq_ui/src/widgets/blur_background.dart';
import 'package:flutter/cupertino.dart';

class CliqIconButton extends StatelessWidget {
  final Widget icon;
  final Widget? label;
  final Function()? onTap;
  final CliqIconButtonStyle? style;

  const CliqIconButton({
    super.key,
    required this.icon,
    this.label,
    this.onTap,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    final style = this.style ?? context.theme.iconButtonStyle;

    return CliqInteractable(
      onTap: onTap,
      child: CliqBlurBackground(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconTheme(data: style.iconTheme, child: icon),
              ?label,
            ],
          ),
        ),
      ),
    );
  }
}

final class CliqIconButtonStyle {
  final IconThemeData iconTheme;
  final EdgeInsetsGeometry padding;

  const CliqIconButtonStyle({required this.iconTheme, required this.padding});

  factory CliqIconButtonStyle.inherit({
    required CliqStyle style,
    required CliqColorScheme colorScheme,
  }) {
    return CliqIconButtonStyle(
      iconTheme: IconThemeData(
        color: colorScheme.onSecondaryBackground,
        size: 20,
      ),
      padding: const EdgeInsets.all(8),
    );
  }
}
