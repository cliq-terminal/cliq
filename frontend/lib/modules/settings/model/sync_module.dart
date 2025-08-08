import 'package:cliq/modules/settings/model/settings_module.dart';
import 'package:lucide_flutter/lucide_flutter.dart';
import 'package:flutter/material.dart';

final class SyncModule extends SettingsModule {
  @override
  String get title => 'Sync';

  @override
  String? get description => 'Manage hosts and keychain syncing';

  @override
  IconData get iconData => LucideIcons.refreshCw;

  @override
  Widget build(BuildContext context) {
    return Text('TODO');
  }
}
