import 'package:flutter/cupertino.dart';

class NavDestination {
  final String label;
  final IconData iconData;
  final IconData? selectedIconData;

  const NavDestination({
    required this.label,
    required this.iconData,
    this.selectedIconData,
  });
}
