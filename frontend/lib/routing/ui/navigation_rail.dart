import 'package:cliq_ui/cliq_ui.dart';
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

      return MouseRegion(
        onEnter: (event) => isHovered = true,
        onExit: (event) => isHovered = false,
        child:  CliqInteractable(
          onTap: () {
            if (onDestinationSelected != null) {
              onDestinationSelected!(index);
            }
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            decoration: BoxDecoration(
              color: isSelected
                  ? const Color(0xFFFFFFFF).withAlpha(70)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(destination.iconData),
                  if (extended && isSelected)
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(destination.label),
                    ),
                ],
              ),
            ),
          ),
        ),
      );
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
