import 'package:flutter/widgets.dart';

import 'package:cliq_ui/cliq_ui.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

final class CliqTypography extends HookWidget {
  final String data;
  final BreakpointMap<CliqTextStyle> size;
  final bool secondaryFont;
  final bool noPadding;
  final TextStyle Function(TextStyle style)? styleModifier;

  final StrutStyle? strutStyle;
  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final Locale? locale;
  final bool? softWrap;
  final TextOverflow? overflow;
  final TextScaler? textScaler;
  final int? maxLines;
  final String? semanticsLabel;
  final String? semanticsIdentifier;
  final TextWidthBasis? textWidthBasis;
  final TextHeightBehavior? textHeightBehavior;
  final Color? selectionColor;

  const CliqTypography(
    this.data, {
    super.key,
    required this.size,
    this.secondaryFont = false,
    this.noPadding = false,
    this.styleModifier,
    this.strutStyle,
    this.textAlign,
    this.textDirection,
    this.locale,
    this.softWrap,
    this.overflow,
    this.textScaler,
    this.maxLines,
    this.semanticsLabel,
    this.semanticsIdentifier,
    this.textWidthBasis = TextWidthBasis.parent,
    this.textHeightBehavior,
    this.selectionColor,
  });

  @override
  Widget build(BuildContext context) {
    final breakpoint = useBreakpoint();
    final style = size[breakpoint]!;

    final textStyle =
        (styleModifier == null ? style.style : styleModifier!.call(style.style))
            .copyWith(
              fontFamily:
                  (secondaryFont
                          ? CliqFontFamily.secondary
                          : CliqFontFamily.primary)
                      .fontFamily,
            );

    return Padding(
      padding: noPadding ? EdgeInsets.zero : style.padding ?? EdgeInsets.zero,
      child: Text(
        data,
        key: key,
        style: textStyle,
        strutStyle: strutStyle,
        textAlign: textAlign,
        textDirection: textDirection,
        locale: locale,
        softWrap: softWrap,
        overflow: overflow,
        textScaler: textScaler,
        maxLines: maxLines,
        semanticsLabel: semanticsLabel,
        semanticsIdentifier: semanticsIdentifier,
        textWidthBasis: textWidthBasis,
        textHeightBehavior: textHeightBehavior,
        selectionColor: selectionColor,
      ),
    );
  }
}
