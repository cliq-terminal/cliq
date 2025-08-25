part of '_preview.dart';

@Preview(name: 'CliqChip', wrapper: previewWrapper)
Widget chipPreview() {
  return CliqChip(
    leading: Icon(LucideIcons.plus),
    trailing: Icon(LucideIcons.chevronRight),
    title: Text('Add Item'),
    onTap: () {},
  );
}
