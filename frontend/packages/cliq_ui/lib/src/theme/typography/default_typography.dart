import 'package:flutter/cupertino.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:cliq_ui/cliq_ui.dart';

final class CliqDefaultTypography extends HookWidget {
  final BreakpointMap<CliqTextStyle> size;
  final Widget child;
  final bool secondaryFont;

  final Color? color;

  const CliqDefaultTypography({
    super.key,
    required this.size,
    required this.child,
    this.secondaryFont = false,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final breakpoint = useBreakpoint();

    return DefaultTextStyle(
      style: size[breakpoint]!.style.copyWith(
        color: color,
        fontFamily:
            (secondaryFont ? CliqFontFamily.secondary : CliqFontFamily.primary)
                .fontFamily,
      ),
      child: child,
    );
  }
}
