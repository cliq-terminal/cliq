import 'package:cliq/modules/settings/model/settings_module.dart';
import 'package:cliq_icons/cliq_icons.dart';
import 'package:flutter/material.dart';

final class ThemeModule extends SettingsModule {
  @override
  String get title => 'Themes';

  @override
  String? get description => 'Modify the app\'s appearance.';

  @override
  IconData get iconData => LucideIcons.paintbrush;

  @override
  Widget build(BuildContext context) {
    return Text('TODO');
  }
}
