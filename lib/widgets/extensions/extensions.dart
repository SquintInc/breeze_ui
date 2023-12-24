import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:tailwind_elements/config/options/borders/border_radius.dart';
import 'package:tailwind_elements/config/options/borders/border_width.dart';
import 'package:tailwind_elements/config/options/box_types.dart';
import 'package:tailwind_elements/config/options/colors.dart';
import 'package:tailwind_elements/config/options/effects/box_shadow.dart';
import 'package:tailwind_elements/config/options/spacing/margin.dart';
import 'package:tailwind_elements/config/options/spacing/padding.dart';
import 'package:tailwind_elements/config/options/typography/font_size.dart';
import 'package:tailwind_elements/config/options/typography/font_weight.dart';
import 'package:tailwind_elements/config/options/typography/line_height.dart';
import 'package:tailwind_elements/config/options/units.dart';

Iterable<T> zip<T>(final Iterable<T> a, final Iterable<T> b) sync* {
  final iterA = a.iterator;
  final iterB = b.iterator;
  bool hasA, hasB;
  while ((hasA = iterA.moveNext()) | (hasB = iterB.moveNext())) {
    if (hasA) yield iterA.current;
    if (hasB) yield iterB.current;
  }
}

extension FontWeightExtension on TwFontWeight {
  FontWeight get fontWeight {
    if (weight == 100) {
      return FontWeight.w100;
    } else if (weight == 200) {
      return FontWeight.w200;
    } else if (weight == 300) {
      return FontWeight.w300;
    } else if (weight == 400) {
      return FontWeight.w400;
    } else if (weight == 500) {
      return FontWeight.w500;
    } else if (weight == 600) {
      return FontWeight.w600;
    } else if (weight == 700) {
      return FontWeight.w700;
    } else if (weight == 800) {
      return FontWeight.w800;
    } else if (weight == 900) {
      return FontWeight.w900;
    }
    return FontWeight.w400;
  }
}

extension FontSizeExtension on TwFontSize {
  double getLineHeight(final TwLineHeight? height) {
    if (height != null) {
      return height.value.isPercentageBased
          ? height.value.percentage
          : (height.value.logicalPixels / value.logicalPixels);
    }
    return lineHeight.value.isPercentageBased
        ? lineHeight.value.percentage
        : (lineHeight.value.logicalPixels / value.logicalPixels);
  }
}

extension MarginExtension on TwMargin {
  EdgeInsetsGeometry toEdgeInsets() => switch (type) {
        BoxSideType.all => EdgeInsets.all(all.value.logicalPixels),
        BoxSideType.trbl => EdgeInsets.only(
            top: top.value.logicalPixels,
            right: right.value.logicalPixels,
            bottom: bottom.value.logicalPixels,
            left: left.value.logicalPixels,
          ),
        BoxSideType.x ||
        BoxSideType.y ||
        BoxSideType.xy =>
          EdgeInsets.symmetric(
            horizontal: x.value.logicalPixels,
            vertical: y.value.logicalPixels,
          ),
      };
}

extension PaddingExtension on TwPadding {
  EdgeInsetsGeometry toEdgeInsets() => switch (type) {
        BoxSideType.all => EdgeInsets.all(all.value.logicalPixels),
        BoxSideType.trbl => EdgeInsets.only(
            top: top.value.logicalPixels,
            right: right.value.logicalPixels,
            bottom: bottom.value.logicalPixels,
            left: left.value.logicalPixels,
          ),
        BoxSideType.x ||
        BoxSideType.y ||
        BoxSideType.xy =>
          EdgeInsets.symmetric(
            horizontal: x.value.logicalPixels,
            vertical: y.value.logicalPixels,
          ),
      };
}

extension RadiusExt on BoxConstraints {
  double get circleRadius => (min(minWidth, minHeight) / 2).ceilToDouble();
}

extension BorderRadiusExtension on TwBorderRadius {
  BorderRadius toBorderRadius() => switch (type) {
        BoxCornerType.all => BorderRadius.circular(all.value.logicalPixels),
        BoxCornerType.tltrbrbl => BorderRadius.only(
            topLeft: topLeft.value.logicalPixels > 0
                ? Radius.circular(topLeft.value.logicalPixels)
                : Radius.zero,
            topRight: topRight.value.logicalPixels > 0
                ? Radius.circular(topRight.value.logicalPixels)
                : Radius.zero,
            bottomRight: bottomRight.value.logicalPixels > 0
                ? Radius.circular(bottomRight.value.logicalPixels)
                : Radius.zero,
            bottomLeft: bottomLeft.value.logicalPixels > 0
                ? Radius.circular(bottomLeft.value.logicalPixels)
                : Radius.zero,
          ),
        BoxCornerType.trbl => BorderRadius.only(
            topLeft: Radius.circular(
              max(top.value.logicalPixels, left.value.logicalPixels),
            ),
            topRight: Radius.circular(
              max(top.value.logicalPixels, right.value.logicalPixels),
            ),
            bottomRight: Radius.circular(
              max(bottom.value.logicalPixels, right.value.logicalPixels),
            ),
            bottomLeft: Radius.circular(
              max(bottom.value.logicalPixels, left.value.logicalPixels),
            ),
          )
      };
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

extension BoxShadowExtension on TwBoxShadows {
  List<BoxShadow> toBoxShadows(final TwBoxShadowColor? boxShadowColor) =>
      boxShadows
          .map(
            (final boxShadow) => BoxShadow(
              color: boxShadowColor?.color ?? boxShadow.color.color,
              offset: Offset(
                boxShadow.offsetX.logicalPixels,
                boxShadow.offsetY.logicalPixels,
              ),
              blurRadius: boxShadow.blurRadius.logicalPixels,
              spreadRadius: boxShadow.spreadRadius.logicalPixels,
            ),
          )
          .toList();
}

extension BoxConstraintsExtension on BoxConstraints {
  double limitedMaxWidth(final BuildContext context) {
    return (maxWidth.isInfinite) ? MediaQuery.of(context).size.width : maxWidth;
  }
}
