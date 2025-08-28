import 'package:cliq/shared/validators.dart';
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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _portController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _pemController = TextEditingController();

  @override
  void dispose() {
    _addressController.dispose();
    _portController.dispose();
    _usernameController.dispose();
    _pemController.dispose();
    super.dispose();
  }

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
              alignment: WrapAlignment.center,
              children: [
                CliqGridColumn(
                  sizes: {Breakpoint.lg: 8, Breakpoint.xl: 6},
                  child: Column(
                    spacing: 24,
                    children: [
                      Form(
                        key: _formKey,
                        child: Column(
                          spacing: 16,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CliqTextFormField(
                              label: Text('Address'),
                              hint: Text('127.0.0.1'),
                              controller: _addressController,
                              validator: Validators.address,
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                            ),
                            CliqTextFormField(
                              label: Text('Port'),
                              hint: Text('22'),
                              controller: _portController,
                              validator: Validators.port,
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                            ),
                            CliqTextFormField(
                              label: Text('Username'),
                              hint: Text('root'),
                              controller: _usernameController,
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                            ),
                            CliqTextFormField(
                              label: Text('Private Key (PEM)'),
                              hint: Text('-----BEGIN OPENSSH PRIVATE KEY-----'),
                              controller: _pemController,
                              validator: Validators.pem,
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: CliqButton(
                          label: Text('Save Host'),
                          onPressed: () {
                            if (!_formKey.currentState!.validate()) {
                              return;
                            }

                            // TODO: save in db
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
