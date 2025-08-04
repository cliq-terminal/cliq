import 'package:cliq/modules/settings/view/settings_page.dart';
import 'package:cliq_ui/cliq_ui.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../routing/page_path.dart';
import '../../../shared/ui/future_wrapper.dart';

class LicensePage extends ConsumerWidget {
  static const PagePathBuilder pagePath = PagePathBuilder.child(
    parent: SettingsPage.pagePath,
    path: 'licenses',
  );

  const LicensePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CliqScaffold(
      header: CliqAppBar(
        left: [
          CliqIconButton(
            icon: Icon(Icons.arrow_back_rounded),
            onTap: () => context.pop(),
          ),
        ],
      ),
      body: FutureWrapper(
        future: LicenseRegistry.licenses.toList(),
        onSuccess: (ctx, snap) {
          final List<LicenseEntry> licenses = snap.data ?? [];
          final Map<String, List<LicenseEntry>> licensesMap = {};

          for (final license in licenses) {
            for (final package in license.packages) {
              final identifier = package.toString();
              if (licensesMap.containsKey(identifier)) {
                licensesMap[identifier]!.add(license);
              } else {
                licensesMap[identifier] = [license];
              }
            }
          }

          return ListView.separated(
            padding: const EdgeInsets.only(top: 10),
            itemCount: licensesMap.length,
            separatorBuilder: (ctx, index) => const SizedBox(height: 20),
            itemBuilder: (ctx, index) {
              final MapEntry<String, List<LicenseEntry>> license = licensesMap
                  .entries
                  .elementAt(index);

              bool isExpanded = false;
              return StatefulBuilder(
                builder: (ctx, setState) {
                  return GestureDetector(
                    onTap: () => setState(() => isExpanded = !isExpanded),
                    child: CliqCard(
                      title: Text(license.key),
                      subtitle: Row(
                        children: [
                          Expanded(
                            child: Text('${license.value.length} license(s)'),
                          ),
                          isExpanded
                              ? Icon(Icons.arrow_upward)
                              : Icon(Icons.arrow_downward),
                        ],
                      ),
                      child: isExpanded
                          ? Column(
                              children: [
                                for (final entry in license.value) ...[
                                  for (final paragraph in entry.paragraphs) ...[
                                    Text(paragraph.text),
                                    const SizedBox(height: 10),
                                  ],
                                  const Divider(),
                                ],
                              ],
                            )
                          : null,
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
