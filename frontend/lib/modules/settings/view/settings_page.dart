import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../routing/page_path.dart';

class SettingsPage extends StatefulHookConsumerWidget {
  static const PagePathBuilder pagePath = PagePathBuilder('/settings');

  const SettingsPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DashboardPageState();
}

class _DashboardPageState extends ConsumerState<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text('TODO: Settings')));
  }
}
