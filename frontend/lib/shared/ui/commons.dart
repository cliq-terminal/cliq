import 'package:cliq_ui/cliq_ui.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Class for common UI components used across the application that don't fit
/// into the cliq_ui library.
class Commons {
  const Commons._();

  static Widget backButton(BuildContext ctx) => CliqIconButton(
    icon: Icon(Icons.arrow_back_rounded),
    onPressed: () => ctx.pop(),
  );
}
