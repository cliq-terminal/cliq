import 'package:cliq_ui/cliq_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CliqGridScaffold extends StatelessWidget {
  final Widget body;
  final Widget? header;
  final Widget? footer;
  final bool extendBehindAppBar;
  final bool safeAreaTop;
  final CliqScaffoldStyle? style;

  const CliqGridScaffold({
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
    return CliqScaffold(
      header: header,
      footer: footer,
      extendBehindAppBar: extendBehindAppBar,
      safeAreaTop: safeAreaTop,
      body: SingleChildScrollView(
        child: CliqGridContainer(children: [
          CliqGridRow(children: [
            CliqGridColumn(child: body)
          ])
        ]),
      ),
    );
  }
}
