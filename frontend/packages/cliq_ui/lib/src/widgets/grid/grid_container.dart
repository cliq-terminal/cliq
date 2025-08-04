import 'package:cliq_ui/cliq_ui.dart';
import 'package:flutter/material.dart';

/// An implementation of the bootstrap grid container in flutter.
/// Inspired by the flutter_bootstrap package.
class CliqGridContainer extends StatelessWidget {
  final List<Widget> children;
  final bool fluid;
  final BoxDecoration? decoration;
  final EdgeInsetsGeometry? padding;

  const CliqGridContainer({
    super.key,
    required this.children,
    this.fluid = false,
    this.decoration,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final breakpoints = context.theme.breakpoints;
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: padding ?? EdgeInsets.zero,
            child: Container(
              width: fluid
                  ? constraints.maxWidth
                  : breakpoints.getNonFluidWidth(constraints.maxWidth),
              decoration: decoration,
              child: Wrap(
                alignment: WrapAlignment.start,
                direction: Axis.horizontal,
                children: children,
              ),
            ),
          ),
        );
      },
    );
  }
}
