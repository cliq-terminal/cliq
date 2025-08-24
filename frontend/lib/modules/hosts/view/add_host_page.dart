import 'package:cliq_ui/cliq_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../routing/page_path.dart';
import '../../../shared/ui/commons.dart';

enum _AddHostStep { host, auth, finish }

class AddHostsPage extends StatefulHookConsumerWidget {
  static const PagePathBuilder pagePath = PagePathBuilder('/host-setup');

  const AddHostsPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddHostsPageState();
}

class _AddHostsPageState extends ConsumerState<AddHostsPage> {
  @override
  Widget build(BuildContext context) {
    final step = useState(_AddHostStep.auth);

    return CliqScaffold(
      extendBehindAppBar: true,
      header: CliqHeader.progress(
        progress: (step.value.index + 1) / _AddHostStep.values.length,
        left: [Commons.backButton(context)],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 100),
        child: Row(
          children: [
            CliqButton(
              label: Text('debug'),
              onPressed: () => step.value = _AddHostStep
                  .values[(step.value.index + 1) % _AddHostStep.values.length],
            ),
          ],
        ),
      ),
    );
  }
}
