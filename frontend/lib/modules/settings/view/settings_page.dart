import 'package:cliq_ui/cliq_ui.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
    return CliqScaffold(
      extendBehindAppBar: true,
      header: CliqAppBar(
        left: [
          CliqIconButton(
            icon: Icon(Icons.arrow_back_rounded),
            onTap: () => context.pop(),
          ),
        ],
      ),
      body: ListView(children: [Text('TODO: Settings')]),
    );
  }
}
