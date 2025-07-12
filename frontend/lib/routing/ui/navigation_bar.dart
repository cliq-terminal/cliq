import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'nav_destination.dart';

class AppNavigationBar extends HookConsumerWidget {
  final List<NavDestination> destinations;
  final int selectedIndex;
  final void Function(int) onDestinationSelected;

  const AppNavigationBar({
    super.key,
    required this.destinations,
    required this.selectedIndex,
    required this.onDestinationSelected,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final index = useState(0);

    return SafeArea(
      top: false,
      left: false,
      right: false,
      child: BottomNavigationBar(
        currentIndex: index.value,
        onTap: (i) {
          index.value = i;
          onDestinationSelected(i);
        },
        items: [
          for (final destination in destinations)
            BottomNavigationBarItem(
              icon: Icon(destination.iconData),
              label: destination.label,
            ),
        ],
      ),
    );
  }
}
