import 'package:flutter/cupertino.dart';

import 'package:cliq_ui/cliq_ui.dart';

/// An implementation of the bootstrap grid col in flutter.
/// Inspired by the flutter_bootstrap package.
class CliqGridColumn extends StatelessWidget {
  final Widget child;
  final FlexFit fit;
  late final BreakpointMap sizes;
  final List<Breakpoint> invisible;
  final bool absoluteSizes;

  CliqGridColumn({
    super.key,
    required this.child,
    this.fit = FlexFit.loose,
    this.absoluteSizes = true,
    BreakpointMap sizes = const {},
    this.invisible = const [],
  }) : sizes = sizes.cascadeUp();

  @override
  Widget build(BuildContext context) {
    final grid = context.theme.grid;
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final breakpoint = context.theme.breakpoints.getBreakpoint(
          absoluteSizes
              ? MediaQuery.of(context).size.width
              : constraints.maxWidth,
        );

        if (invisible.contains(breakpoint)) {
          return SizedBox.shrink();
        }

        return SizedBox(
          width:
              sizes[breakpoint]! * constraints.maxWidth * grid.oneColumnRatio,
          child: Padding(
            padding: grid.gutterSize == 0.0
                ? EdgeInsets.zero
                : EdgeInsets.symmetric(horizontal: grid.gutterSize / 2),
            child: child,
          ),
        );
      },
    );
  }
}
