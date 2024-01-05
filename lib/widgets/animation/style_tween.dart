import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:tailwind_elements/config/options/borders/border_radius.dart';
import 'package:tailwind_elements/config/options/borders/border_width.dart';
import 'package:tailwind_elements/config/options/colors.dart';
import 'package:tailwind_elements/config/options/effects/box_shadow.dart';
import 'package:tailwind_elements/config/options/effects/opacity.dart';
import 'package:tailwind_elements/config/options/sizing/height.dart';
import 'package:tailwind_elements/config/options/sizing/max_height.dart';
import 'package:tailwind_elements/config/options/sizing/max_width.dart';
import 'package:tailwind_elements/config/options/sizing/min_height.dart';
import 'package:tailwind_elements/config/options/sizing/min_width.dart';
import 'package:tailwind_elements/config/options/sizing/width.dart';
import 'package:tailwind_elements/config/options/transitions/transition_property.dart';
import 'package:tailwind_elements/config/options/typography/font_size.dart';
import 'package:tailwind_elements/config/options/typography/font_weight.dart';
import 'package:tailwind_elements/config/options/typography/letter_spacing.dart';
import 'package:tailwind_elements/config/options/typography/line_height.dart';
import 'package:tailwind_elements/config/options/typography/text_decoration_thickness.dart';
import 'package:tailwind_elements/widgets/style/style.dart';

class TwStyleTween extends Tween<TwStyle?> {
  final Set<TransitionProperty> _properties = {};
  BoxConstraints? _parentConstraints;

  TwStyleTween({super.begin, super.end});

  void setProperties(final Set<TransitionProperty>? properties) {
    _properties.clear();
    if (properties != null) {
      _properties.addAll(properties);
    }
  }

  void setParentConstraints(final BoxConstraints? parentConstraints) {
    _parentConstraints = parentConstraints;
  }

  bool has(final TransitionProperty property) =>
      // Check for all properties group
      _properties.contains(TransitionProperty.all) ||
      // Check for specific property
      _properties.contains(property) ||
      // If border property, check for border property group as well
      (property.isBorderProperty &&
          _properties.contains(TransitionProperty.border));

  TwBoxShadowColor? lerpBoxShadowColor(
    final TwBoxShadowColor? begin,
    final TwBoxShadowColor? end,
    final double t,
  ) {
    if (!has(TransitionProperty.boxShadow) || (begin == null && end == null)) {
      return null;
    }
    return TwBoxShadowColor.fromColor(
      Color.lerp(
        begin?.tweenColor,
        end?.tweenColor,
        t,
      ),
    );
  }

  TwTextColor? lerpTextColor(
    final TwTextColor? begin,
    final TwTextColor? end,
    final double t,
  ) {
    if (!has(TransitionProperty.textColor) || (begin == null && end == null)) {
      return null;
    }
    return TwTextColor.fromColor(
      Color.lerp(
        begin?.tweenColor,
        end?.tweenColor,
        t,
      ),
    );
  }

  TwBackgroundColor? lerpBackgroundColor(
    final TwBackgroundColor? begin,
    final TwBackgroundColor? end,
    final double t,
  ) {
    if (!has(TransitionProperty.backgroundColor) ||
        (begin == null && end == null)) return null;
    return TwBackgroundColor.fromColor(
      Color.lerp(
        begin?.tweenColor,
        end?.tweenColor,
        t,
      ),
    );
  }

  TwBorderColor? lerpBorderColor(
    final TwBorderColor? begin,
    final TwBorderColor? end,
    final double t,
  ) {
    if (!has(TransitionProperty.borderColor) ||
        (begin == null && end == null)) {
      return null;
    }
    return TwBorderColor.fromColor(
      Color.lerp(
        begin?.tweenColor,
        end?.tweenColor,
        t,
      ),
    );
  }

  TwTextDecorationColor? lerpTextDecorationColor(
    final TwTextDecorationColor? begin,
    final TwTextDecorationColor? end,
    final double t,
  ) {
    if (!has(TransitionProperty.textDecorationColor) ||
        (begin == null && end == null)) return null;
    return TwTextDecorationColor.fromColor(
      Color.lerp(
        begin?.tweenColor,
        end?.tweenColor,
        t,
      ),
    );
  }

  TwMinWidth? lerpMinWidth(
    final TwMinWidth? begin,
    final TwMinWidth? end,
    final double t,
  ) {
    if (!has(TransitionProperty.width) || (begin == null && end == null)) {
      return null;
    }
    final parentConstraints = _parentConstraints;
    if (begin == null || end == null) return null;
    final beginMinWidthPx = switch (begin.value) {
      CssAbsoluteUnit() => (begin.value as CssAbsoluteUnit).pixels(),
      CssRelativeUnit() => parentConstraints == null
          ? null
          : (begin.value as CssRelativeUnit).percentageFloat() *
              parentConstraints.maxWidth,
    };
    final endMinWidthPx = switch (end.value) {
      CssAbsoluteUnit() => (end.value as CssAbsoluteUnit).pixels(),
      CssRelativeUnit() => parentConstraints == null
          ? null
          : (end.value as CssRelativeUnit).percentageFloat() *
              parentConstraints.maxWidth,
    };
    final minWidthPx = ui.lerpDouble(beginMinWidthPx, endMinWidthPx, t);
    if (minWidthPx == null) return null;
    return TwMinWidth(PxUnit(minWidthPx));
  }

  TwMaxWidth? lerpMaxWidth(
    final TwMaxWidth? begin,
    final TwMaxWidth? end,
    final double t,
  ) {
    if (!has(TransitionProperty.width) || (begin == null && end == null)) {
      return null;
    }
    final parentConstraints = _parentConstraints;
    if (begin == null || end == null) return null;
    final beginMaxWidthPx = switch (begin.value) {
      CssAbsoluteUnit() => (begin.value as CssAbsoluteUnit).pixels(),
      CssRelativeUnit() => parentConstraints == null
          ? null
          : (begin.value as CssRelativeUnit).percentageFloat() *
              parentConstraints.maxWidth,
    };
    final endMaxWidthPx = switch (end.value) {
      CssAbsoluteUnit() => (end.value as CssAbsoluteUnit).pixels(),
      CssRelativeUnit() => parentConstraints == null
          ? null
          : (end.value as CssRelativeUnit).percentageFloat() *
              parentConstraints.maxWidth,
    };
    final maxWidthPx = ui.lerpDouble(beginMaxWidthPx, endMaxWidthPx, t);
    if (maxWidthPx == null) return null;
    return TwMaxWidth(PxUnit(maxWidthPx));
  }

  TwWidth? lerpWidth(
    final TwWidth? begin,
    final TwWidth? end,
    final double t,
  ) {
    if (!has(TransitionProperty.width) || (begin == null && end == null)) {
      return null;
    }
    final parentConstraints = _parentConstraints;
    if (begin == null || end == null) return null;
    final beginWidthPx = switch (begin.value) {
      CssAbsoluteUnit() => (begin.value as CssAbsoluteUnit).pixels(),
      CssRelativeUnit() => parentConstraints == null
          ? null
          : (begin.value as CssRelativeUnit).percentageFloat() *
              parentConstraints.maxWidth,
    };
    final endWidthPx = switch (end.value) {
      CssAbsoluteUnit() => (end.value as CssAbsoluteUnit).pixels(),
      CssRelativeUnit() => parentConstraints == null
          ? null
          : (end.value as CssRelativeUnit).percentageFloat() *
              parentConstraints.maxWidth,
    };
    final widthPx = ui.lerpDouble(beginWidthPx, endWidthPx, t);
    if (widthPx == null) return null;
    return TwWidth(PxUnit(widthPx));
  }

  TwHeight? lerpHeight(
    final TwHeight? begin,
    final TwHeight? end,
    final double t,
  ) {
    if (!has(TransitionProperty.height) || (begin == null && end == null)) {
      return null;
    }
    final parentConstraints = _parentConstraints;
    if (begin == null || end == null) return null;
    final beginHeightPx = switch (begin.value) {
      CssAbsoluteUnit() => (begin.value as CssAbsoluteUnit).pixels(),
      CssRelativeUnit() => parentConstraints == null
          ? null
          : (begin.value as CssRelativeUnit).percentageFloat() *
              parentConstraints.maxHeight,
    };
    final endHeightPx = switch (end.value) {
      CssAbsoluteUnit() => (end.value as CssAbsoluteUnit).pixels(),
      CssRelativeUnit() => parentConstraints == null
          ? null
          : (end.value as CssRelativeUnit).percentageFloat() *
              parentConstraints.maxHeight,
    };
    final heightPx = ui.lerpDouble(beginHeightPx, endHeightPx, t);
    if (heightPx == null) return null;
    return TwHeight(PxUnit(heightPx));
  }

  TwMinHeight? lerpMinHeight(
    final TwMinHeight? begin,
    final TwMinHeight? end,
    final double t,
  ) {
    if (!has(TransitionProperty.height) || (begin == null && end == null)) {
      return null;
    }
    final parentConstraints = _parentConstraints;
    if (begin == null || end == null) return null;
    final beginMinHeightPx = switch (begin.value) {
      CssAbsoluteUnit() => (begin.value as CssAbsoluteUnit).pixels(),
      CssRelativeUnit() => parentConstraints == null
          ? null
          : (begin.value as CssRelativeUnit).percentageFloat() *
              parentConstraints.maxHeight,
    };
    final endMinHeightPx = switch (end.value) {
      CssAbsoluteUnit() => (end.value as CssAbsoluteUnit).pixels(),
      CssRelativeUnit() => parentConstraints == null
          ? null
          : (end.value as CssRelativeUnit).percentageFloat() *
              parentConstraints.maxHeight,
    };
    final minHeightPx = ui.lerpDouble(beginMinHeightPx, endMinHeightPx, t);
    if (minHeightPx == null) return null;
    return TwMinHeight(PxUnit(minHeightPx));
  }

  TwMaxHeight? lerpMaxHeight(
    final TwMaxHeight? begin,
    final TwMaxHeight? end,
    final double t,
  ) {
    if (!has(TransitionProperty.height) || (begin == null && end == null)) {
      return null;
    }
    final parentConstraints = _parentConstraints;
    if (begin == null || end == null) return null;
    final beginMaxHeightPx = switch (begin.value) {
      CssAbsoluteUnit() => (begin.value as CssAbsoluteUnit).pixels(),
      CssRelativeUnit() => parentConstraints == null
          ? null
          : (begin.value as CssRelativeUnit).percentageFloat() *
              parentConstraints.maxHeight,
    };
    final endMaxHeightPx = switch (end.value) {
      CssAbsoluteUnit() => (end.value as CssAbsoluteUnit).pixels(),
      CssRelativeUnit() => parentConstraints == null
          ? null
          : (end.value as CssRelativeUnit).percentageFloat() *
              parentConstraints.maxHeight,
    };
    final maxHeightPx = ui.lerpDouble(beginMaxHeightPx, endMaxHeightPx, t);
    if (maxHeightPx == null) return null;
    return TwMaxHeight(PxUnit(maxHeightPx));
  }

  TwBorderRadius? lerpBorderRadius(
    final TwBorderRadius? begin,
    final TwBorderRadius? end,
    final double t,
  ) {
    if (!has(TransitionProperty.borderRadius) ||
        (begin == null && end == null)) {
      return null;
    }
    return TwBorderRadius.fromBorderRadius(
      BorderRadius.lerp(
        begin?.toBorderRadius() ?? BorderRadius.zero,
        end?.toBorderRadius() ?? BorderRadius.zero,
        t,
      ),
    );
  }

  TwBorder? lerpBorderWidth(
    final TwBorder? begin,
    final TwBorder? end,
    final double t,
  ) {
    if (!has(TransitionProperty.borderWidth) ||
        (begin == null && end == null)) {
      return null;
    }
    return TwBorder(
      top: TwBorderTop.fromPx(
        ui.lerpDouble(
          begin?.topPx ?? 0,
          end?.topPx ?? 0,
          t,
        ),
      ),
      right: TwBorderRight.fromPx(
        ui.lerpDouble(
          begin?.rightPx ?? 0,
          end?.rightPx ?? 0,
          t,
        ),
      ),
      bottom: TwBorderBottom.fromPx(
        ui.lerpDouble(
          begin?.bottomPx ?? 0,
          end?.bottomPx ?? 0,
          t,
        ),
      ),
      left: TwBorderLeft.fromPx(
        ui.lerpDouble(
          begin?.leftPx ?? 0,
          end?.leftPx ?? 0,
          t,
        ),
      ),
    );
  }

  TwBoxShadows? lerpBoxShadows(
    final TwBoxShadows? begin,
    final TwBoxShadows? end,
    final double t,
    final TwBoxShadowColor? beginBoxShadowColor,
    final TwBoxShadowColor? endBoxShadowColor,
  ) {
    if (!has(TransitionProperty.boxShadow) || (begin == null && end == null)) {
      return null;
    }
    return TwBoxShadows.fromBoxShadows(
      BoxShadow.lerpList(
        begin?.withColor(beginBoxShadowColor),
        end?.withColor(endBoxShadowColor),
        t,
      ),
    );
  }

  TwOpacity? lerpOpacity(
    final TwOpacity? begin,
    final TwOpacity? end,
    final double t,
  ) {
    if (!has(TransitionProperty.opacity) || (begin == null && end == null)) {
      return null;
    }
    return TwOpacity(
      ui.lerpDouble(
            begin?.value ?? 1,
            end?.value ?? 1,
            t,
          ) ??
          1,
    );
  }

  TwFontWeight? lerpFontWeight(
    final TwFontWeight? begin,
    final TwFontWeight? end,
    final double t,
  ) {
    if (!has(TransitionProperty.fontWeight) || (begin == null && end == null)) {
      return null;
    }
    return TwFontWeight(
      FontWeight.lerp(
            begin?.fontWeight ?? TwFontWeight.defaultFlutterFontWeight,
            end?.fontWeight ?? TwFontWeight.defaultFlutterFontWeight,
            t,
          )?.value ??
          400,
    );
  }

  TwLineHeight? lerpLineHeightAsPercentage(
    final TwStyle begin,
    final TwStyle end,
    final double t,
  ) {
    if (!has(TransitionProperty.lineHeight) ||
        (begin.lineHeight == null && end.lineHeight == null)) {
      return null;
    }
    final double beginLineHeightAsPercentage = (begin.lineHeight ??
            begin.fontSize?.lineHeight ??
            TwLineHeight.defaultLineHeight)
        .asPercentageFloat(begin.fontSizePx);
    final double endLineHeightAsPercentage = (end.lineHeight ??
            end.fontSize?.lineHeight ??
            TwLineHeight.defaultLineHeight)
        .asPercentageFloat(end.fontSizePx);
    return TwLineHeight(
      PercentUnit.fromFloat(
        ui.lerpDouble(
              beginLineHeightAsPercentage,
              endLineHeightAsPercentage,
              t,
            ) ??
            TwLineHeight.defaultLineHeightPercentage,
      ),
    );
  }

  TwFontSize? lerpFontSize(
    final TwStyle begin,
    final TwStyle end,
    final double t,
    final TwLineHeight? lerpedLineHeight,
  ) {
    if (!has(TransitionProperty.fontSize) ||
        (begin.fontSize == null && end.fontSize == null)) {
      return null;
    }
    return TwFontSize(
      PxUnit(
        ui.lerpDouble(begin.fontSizePx, end.fontSizePx, t) ??
            TwFontSize.defaultFontSizePx,
      ),
      lerpedLineHeight ?? TwLineHeight.defaultLineHeight,
    );
  }

  TwTextDecorationThickness? lerpTextDecorationThickness(
    final TwTextDecorationThickness? begin,
    final TwTextDecorationThickness? end,
    final double t,
    final TwFontSize? beginFontSize,
    final TwFontSize? endFontSize,
  ) {
    if (!has(TransitionProperty.textDecorationThickness) ||
        (begin == null && end == null)) {
      return null;
    }
    final thicknessPx = ui.lerpDouble(
      begin?.value.pixels(beginFontSize?.value.pixels()),
      end?.value.pixels(endFontSize?.value.pixels()),
      t,
    );
    if (thicknessPx == null) return null;
    return TwTextDecorationThickness(PxUnit(thicknessPx));
  }

  TwLetterSpacing? lerpLetterSpacing(
    final TwLetterSpacing? begin,
    final TwLetterSpacing? end,
    final double t,
    final TwFontSize? beginFontSize,
    final TwFontSize? endFontSize,
  ) {
    if (!has(TransitionProperty.letterSpacing) ||
        (begin == null && end == null)) {
      return null;
    }
    final letterSpacingPx = ui.lerpDouble(
      begin?.value.pixels(beginFontSize?.value.pixels()),
      end?.value.pixels(endFontSize?.value.pixels()),
      t,
    );
    if (letterSpacingPx == null) return null;
    return TwLetterSpacing(PxUnit(letterSpacingPx));
  }

  @override
  TwStyle? lerp(final double t) {
    final begin = this.begin;
    final end = this.end;
    if (begin == end) return begin;
    if (begin == null || end == null) return null;

    final lineHeight = lerpLineHeightAsPercentage(begin, end, t);

    return TwStyle(
      // Colors
      textColor: lerpTextColor(begin.textColor, end.textColor, t),
      backgroundColor:
          lerpBackgroundColor(begin.backgroundColor, end.backgroundColor, t),
      borderColor: lerpBorderColor(begin.borderColor, end.borderColor, t),
      boxShadowColor:
          lerpBoxShadowColor(begin.boxShadowColor, end.boxShadowColor, t),
      textDecorationColor: lerpTextDecorationColor(
        begin.textDecorationColor,
        end.textDecorationColor,
        t,
      ),
      // Sizing and constraints
      width: lerpWidth(begin.width, end.width, t),
      height: lerpHeight(begin.height, end.height, t),
      minWidth: lerpMinWidth(begin.minWidth, end.minWidth, t),
      maxWidth: lerpMaxWidth(begin.maxWidth, end.maxWidth, t),
      minHeight: lerpMinHeight(begin.minHeight, end.minHeight, t),
      maxHeight: lerpMaxHeight(begin.maxHeight, end.maxHeight, t),
      // Borders
      borderRadius: lerpBorderRadius(begin.borderRadius, end.borderRadius, t),
      border: lerpBorderWidth(begin.border, end.border, t),
      // Effects
      boxShadow: lerpBoxShadows(
        begin.boxShadow,
        end.boxShadow,
        t,
        begin.boxShadowColor ??
            TwBoxShadowColor.fromColor(begin.boxShadow?.firstColor),
        end.boxShadowColor ??
            TwBoxShadowColor.fromColor(end.boxShadow?.firstColor),
      ),
      opacity: lerpOpacity(begin.opacity, end.opacity, t),
      // Typography
      fontWeight: lerpFontWeight(begin.fontWeight, end.fontWeight, t),
      lineHeight: lineHeight,
      fontSize: lerpFontSize(begin, end, t, lineHeight),
      textDecorationThickness: lerpTextDecorationThickness(
        begin.textDecorationThickness,
        end.textDecorationThickness,
        t,
        begin.fontSize,
        end.fontSize,
      ),
      letterSpacing: lerpLetterSpacing(
        begin.letterSpacing,
        end.letterSpacing,
        t,
        begin.fontSize,
        end.fontSize,
      ),
    );
  }
}
