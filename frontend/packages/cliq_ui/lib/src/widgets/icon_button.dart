import 'package:cliq_ui/cliq_ui.dart';
import 'package:cliq_ui/src/widgets/blur_background.dart';
import 'package:flutter/cupertino.dart';

class CliqIconButton extends StatelessWidget {
  final Widget icon;
  final Function()? onTap;
  final CliqIconButtonStyle? style;

  const CliqIconButton({
    super.key,
    required this.icon,
    this.onTap,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    final style = this.style ?? context.theme.iconButtonStyle;

    return CliqInteractable(
      child: CliqBlurBackground(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: IconTheme(data: style.iconTheme, child: icon),
        ),
      ),
    );
  }
}

final class CliqIconButtonStyle {
  final IconThemeData iconTheme;
  final EdgeInsetsGeometry padding;

  const CliqIconButtonStyle({
    required this.iconTheme,
    required this.padding,
  });

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
