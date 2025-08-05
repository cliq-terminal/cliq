part of 'scaffold.dart';

class _CliqGridScaffold extends CliqScaffold {
  const _CliqGridScaffold({
    super.key,
    required super.body,
    super.header,
    super.footer,
    super.extendBehindAppBar = false,
    super.safeAreaTop = false,
    super.style,
  });

  @override
  Widget build(BuildContext context) {
    return CliqScaffold(
      header: header,
      footer: footer,
      extendBehindAppBar: extendBehindAppBar,
      safeAreaTop: safeAreaTop,
      body: SingleChildScrollView(
        child: CliqGridContainer(children: [
          CliqGridRow(children: [
            CliqGridColumn(child: body)
          ])
        ]),
      ),
    );
  }
}
