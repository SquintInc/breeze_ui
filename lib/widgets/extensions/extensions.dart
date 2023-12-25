import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:tailwind_elements/config/options/borders/border_width.dart';
import 'package:tailwind_elements/config/options/box_types.dart';

Iterable<T> zip<T>(final Iterable<T> a, final Iterable<T> b) sync* {
  final iterA = a.iterator;
  final iterB = b.iterator;
  bool hasA, hasB;
  while ((hasA = iterA.moveNext()) | (hasB = iterB.moveNext())) {
    if (hasA) yield iterA.current;
    if (hasB) yield iterB.current;
  }
}

extension RadiusExt on BoxConstraints {
  double get circleRadius => (min(minWidth, minHeight) / 2).ceilToDouble();
}

extension BorderWidthExtension on TwBorder {
  Border? toBorder(
    final Color? borderColor,
    final double? borderStrokeAlign,
  ) {
    if (isEmpty) return null;

    return switch (type) {
      BoxSideType.all => Border.all(
          color: borderColor ?? const Color(0xFF000000),
          width: all.pixels.value,
          strokeAlign: borderStrokeAlign ?? BorderSide.strokeAlignInside,
        ),
      BoxSideType.trbl => Border(
          top: BorderSide(
            color: borderColor ?? const Color(0xFF000000),
            width: top.pixels.value,
            strokeAlign: borderStrokeAlign ?? BorderSide.strokeAlignInside,
          ),
          right: BorderSide(
            color: borderColor ?? const Color(0xFF000000),
            width: right.pixels.value,
            strokeAlign: borderStrokeAlign ?? BorderSide.strokeAlignInside,
          ),
          bottom: BorderSide(
            color: borderColor ?? const Color(0xFF000000),
            width: bottom.pixels.value,
            strokeAlign: borderStrokeAlign ?? BorderSide.strokeAlignInside,
          ),
          left: BorderSide(
            color: borderColor ?? const Color(0xFF000000),
            width: left.pixels.value,
            strokeAlign: borderStrokeAlign ?? BorderSide.strokeAlignInside,
          ),
        ),
      BoxSideType.x || BoxSideType.y || BoxSideType.xy => Border.symmetric(
          horizontal: x.pixels.value > 0
              ? BorderSide(
                  color: borderColor ?? const Color(0xFF000000),
                  width: x.pixels.value,
                  strokeAlign:
                      borderStrokeAlign ?? BorderSide.strokeAlignInside,
                )
              : BorderSide.none,
          vertical: y.pixels.value > 0
              ? BorderSide(
                  color: borderColor ?? const Color(0xFF000000),
                  width: y.pixels.value,
                  strokeAlign:
                      borderStrokeAlign ?? BorderSide.strokeAlignInside,
                )
              : BorderSide.none,
        ),
    };
  }
}

extension BoxConstraintsExtension on BoxConstraints {
  double limitedMaxWidth(final BuildContext context) {
    return (maxWidth.isInfinite) ? MediaQuery.of(context).size.width : maxWidth;
  }
}
