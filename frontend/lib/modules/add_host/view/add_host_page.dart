import 'package:cliq_ui/cliq_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../routing/page_path.dart';
import '../../../shared/ui/commons.dart';

class AddHostsPage extends StatefulHookConsumerWidget {
  static const PagePathBuilder pagePath = PagePathBuilder('/hosts');

  const AddHostsPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddHostsPageState();
}

class _AddHostsPageState extends ConsumerState<AddHostsPage> {
  @override
  Widget build(BuildContext context) {
    return CliqScaffold(
      extendBehindAppBar: true,
      header: CliqHeader(
        title: Text('Add Host'),
        left: [Commons.backButton(context)],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 80),
        child: CliqGridContainer(
          children: [
            CliqGridRow(
              children: [
                CliqGridColumn(child: CliqButton(label: Text('Save Host'))),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
