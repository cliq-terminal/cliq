import 'package:cliq_ui/cliq_ui.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../routing/page_path.dart';

class HostsPage extends StatefulHookConsumerWidget {
  static const PagePathBuilder pagePath = PagePathBuilder('/');

  const HostsPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HostsPageState();
}

class _HostsPageState extends ConsumerState<HostsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: CliqGridContainer(
          fluid: true,
          decoration: BoxDecoration(color: Colors.green),
          children: [
            CliqGridContainer(
              decoration: BoxDecoration(color: Colors.purple),
              children: [
                CliqGridRow(
                  children: [
                    CliqGridColumn(
                      sizes: {Breakpoint.lg: 6, Breakpoint.sm: 12},
                      child: Container(height: 60, color: Colors.red),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
