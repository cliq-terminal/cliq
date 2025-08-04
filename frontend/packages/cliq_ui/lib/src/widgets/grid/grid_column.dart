import 'package:cliq_ui/cliq_ui.dart';
import 'package:flutter/cupertino.dart';

class CliqGridColumn extends StatelessWidget {
  final Map<CliqScreenSize, int> spans;
  final Widget child;

  CliqGridColumn({super.key, required this.spans, required this.child})
    : assert(spans.isNotEmpty);

  int _currentSpan(CliqScreenSize size) {
    CliqScreenSize? best;
    for (var bp in spans.keys) {
      if (bp.index <= size.index) {
        if (best == null || bp.index > best.index) best = bp;
      }
    }
    return spans[best] ?? 12;
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final screenSize = context.theme.breakpoints.getScreenSize(width);
    final span = _currentSpan(screenSize);
    final gutter = context.theme.grid.gutter.toDouble();

    return Expanded(
      flex: span,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: gutter / 2),
        child: child,
      ),
    );
  }
}
