import 'package:cliq_ui/cliq_ui.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lucide_flutter/lucide_flutter.dart';

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
    final typography = context.theme.typography;

    buildNoHosts() {
      return SizedBox.fromSize(
        size: MediaQuery.sizeOf(context),
        child: Column(
          spacing: 8,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CliqTypography(
              'Add your first host by clicking the button below.',
              textAlign: TextAlign.center,
              size: typography.copyM,
            ),
            const SizedBox(height: 8),
            CliqButton(icon: Icon(LucideIcons.plus), label: Text('Add Host')),
          ],
        ),
      );
    }

    return CliqScaffold.grid(body: buildNoHosts());
  }
}
