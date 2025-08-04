import 'package:cliq_ui/cliq_ui.dart';
import 'package:flutter/cupertino.dart';

class CliqGridContainer extends StatelessWidget {
  final BoxDecoration? decoration;
  final EdgeInsetsGeometry? padding;
  final List<Widget> children;

  const CliqGridContainer({
    super.key,
    this.decoration,
    this.padding,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Align(
          alignment: Alignment.topCenter,
          child: Container(
            width: context.theme.breakpoints.getMaxWidth(constraints.maxWidth),
            decoration: decoration,
            padding: padding,
            child: Wrap(
              alignment: WrapAlignment.start,
              direction: Axis.horizontal,
              children: children,
            ),
          ),
        );
      },
    );
  }
}
