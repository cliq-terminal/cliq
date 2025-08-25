part of '_preview.dart';

@Preview(name: 'CliqHeader', wrapper: previewWrapper, size: previewSize)
Widget headerPreview() {
  return CliqHeader(
    title: Text('Header Title'),
    left: [
      CliqIconButton(onPressed: () {}, icon: Icon(LucideIcons.chevronLeft)),
    ],
    right: [CliqIconButton(onPressed: () {}, icon: Icon(LucideIcons.settings))],
  );
}
