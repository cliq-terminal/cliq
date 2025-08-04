import 'package:cliq_ui/cliq_ui.dart';
import 'package:flutter/cupertino.dart';

class CliqGridRow extends StatelessWidget {
  final List<Widget> children;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;

  const CliqGridRow({
    super.key,
    required this.children,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.start,
  });

  @override
  Widget build(BuildContext context) {
    final gutter = context.theme.grid.gutter;

    return Row(
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      children: children
          .map(
            (child) => Padding(
              padding: EdgeInsets.symmetric(horizontal: gutter / 2),
              child: child,
            ),
          )
          .toList(),
    );
  }
}
