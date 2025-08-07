import 'package:flutter/cupertino.dart';

abstract class SettingsModule {
  String get title;
  String? get description;
  IconData get iconData;
  Widget build(BuildContext context);
}
