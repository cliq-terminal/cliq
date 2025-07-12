import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'nav_destination.dart';

class AppNavigationRail extends ConsumerWidget {
  final List<NavDestination> destinations;
  final int selectedIndex;
  final bool extended;
  final Function(int)? onDestinationSelected;
  final List<Widget> Function(bool)? trailingBuilder;

  const AppNavigationRail({
    super.key,
    required this.destinations,
    required this.selectedIndex,
    this.extended = true,
    this.onDestinationSelected,
    this.trailingBuilder,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    buildDestination(NavDestination destination, int index) {
      final bool isSelected = index == selectedIndex;
      bool isHovered = false;

      // TODO: implement

      return Container();
    }

    return AnimatedSize(
      duration: const Duration(milliseconds: 100),
      child: SizedBox(
        width: extended ? 350 : 100,
        child: Column(
          crossAxisAlignment:
          extended ? CrossAxisAlignment.start : CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 10),
            for (NavDestination destination in destinations)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: buildDestination(
                  destination,
                  destinations.indexOf(destination),
                ),
              ),
            if (trailingBuilder != null) ...trailingBuilder!(extended),
          ],
        ),
      ),
    );
  }
}
