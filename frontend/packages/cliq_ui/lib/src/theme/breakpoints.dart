enum CliqScreenSize { sm, md, lg, xl, xxl }

final class CliqBreakpoints {
  final Map<CliqScreenSize, double> breakpoints;

  const CliqBreakpoints({
    this.breakpoints = const {
      CliqScreenSize.sm: 576,
      CliqScreenSize.md: 768,
      CliqScreenSize.lg: 992,
      CliqScreenSize.xl: 1200,
      CliqScreenSize.xxl: 1400,
    },
  }) : assert(
         breakpoints.length == CliqScreenSize.values.length,
         'Breakpoints must define all CliqScreenSize values.',
       );

  CliqScreenSize getScreenSize(double width) {
    for (final entry in breakpoints.entries) {
      if (width < entry.value) {
        return entry.key;
      }
    }
    return CliqScreenSize.xxl;
  }

  double getMaxWidth(double width) => breakpoints[getScreenSize(width)]!;
}
