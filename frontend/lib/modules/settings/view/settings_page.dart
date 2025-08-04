import 'package:cliq/modules/settings/model/settings_module.dart';
import 'package:cliq/routing/router.extension.dart';
import 'package:cliq_ui/cliq_ui.dart';
import 'package:flutter/material.dart' hide LicensePage;
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'license_page.dart';
import '../../../routing/page_path.dart';

class SettingsPage extends StatefulHookConsumerWidget {
  static const PagePathBuilder pagePath = PagePathBuilder('/settings');

  const SettingsPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DashboardPageState();
}

class _DashboardPageState extends ConsumerState<SettingsPage> {
  final List<SettingsModule> _modules = [];

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
        right: [
          CliqIconButton(
            icon: Icon(Icons.library_books_outlined),
            label: Text('Licenses'),
            onTap: () => context.pushPath(LicensePage.pagePath.build()),
          ),
        ],
      ),
      body: ListView(children: []),
    );
  }
}
