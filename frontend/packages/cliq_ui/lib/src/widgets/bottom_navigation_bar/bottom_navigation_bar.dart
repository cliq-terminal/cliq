import 'dart:ui';

import 'package:cliq_ui/cliq_ui.dart';
import 'package:flutter/material.dart';

class CliqBottomNavigationBar extends StatelessWidget {
  final List<CliqBottomNavigationBarItem> items;
  final int currentIndex;
  final Function(int)? onItemSelected;
  final CliqBottomNavigationBarStyle? style;

  const CliqBottomNavigationBar(
      {super.key,
        required this.items,
        required this.currentIndex,
        required this.onItemSelected,
        this.style});

  @override
  Widget build(BuildContext context) {
    final style = this.style ?? context.theme.bottomNavigationBarStyle;
    final textStyle = context.theme.typography;

    buildItemButton(CliqBottomNavigationBarItem item, int index) {
      final bool isSelected = index == currentIndex;
      return CliqInteractable(
        onTap: () => onItemSelected?.call(index),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            color: isSelected
                ? const Color(0xFFFFFFFF).withAlpha(70)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Row(
                mainAxisSize: MainAxisSize.min,
                spacing: 10, children: [
              ?item.icon,
              if (isSelected) Text(item.label),
            ]),
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipRRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: style.color.withValues(alpha: 0.5),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: DefaultTextStyle(
                    style: textStyle.base.copyWith(color: style.textColor),
                    child: Row(
                      spacing: 10,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        for (final item in items)
                          buildItemButton(item, items.indexOf(item)),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

final class CliqBottomNavigationBarStyle {
  final Color color;
  final Color textColor;

  const CliqBottomNavigationBarStyle({required this.color, required this.textColor});

  factory CliqBottomNavigationBarStyle.inherit(
      {required CliqColorScheme colorScheme}) {
    return CliqBottomNavigationBarStyle(
        color: colorScheme.secondaryBackground,
        textColor: colorScheme.onSecondaryBackground
    );
  }
}
