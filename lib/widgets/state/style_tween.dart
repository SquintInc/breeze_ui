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

  TwMinWidth? lerpMinWidth(
    final TwMinWidth? begin,
    final TwMinWidth? end,
    final double t,
  ) {
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

  @override
  TwStyle? lerp(final double t) {
    final begin = this.begin;
    final end = this.end;
    if (begin == end) return begin;
    if (begin == null || end == null) return null;

    return TwStyle(
      backgroundColor: has(TransitionProperty.backgroundColor)
          ? TwBackgroundColor.fromColor(
              Color.lerp(
                begin.backgroundColor?.tweenColor,
                end.backgroundColor?.tweenColor,
                t,
              ),
            )
          : null,
      width: has(TransitionProperty.width)
          ? lerpWidth(begin.width, end.width, t)
          : null,
      height: has(TransitionProperty.height)
          ? lerpHeight(begin.height, end.height, t)
          : null,
      minWidth: has(TransitionProperty.width)
          ? lerpMinWidth(begin.minWidth, end.minWidth, t)
          : null,
      maxWidth: has(TransitionProperty.width)
          ? lerpMaxWidth(begin.maxWidth, end.maxWidth, t)
          : null,
      minHeight: has(TransitionProperty.height)
          ? lerpMinHeight(begin.minHeight, end.minHeight, t)
          : null,
      maxHeight: has(TransitionProperty.height)
          ? lerpMaxHeight(begin.maxHeight, end.maxHeight, t)
          : null,
    );
  }
}

/// Tween class for [TwStyle] values. Supports conditional evaluation of
/// properties to be tweened via [setProperties], which is used by
/// [TwTransitionController].
class TwStyleTweenOLD extends Tween<TwStyle?> {
  final Set<TransitionProperty> _properties = {};

  TwStyleTweenOLD({super.begin, super.end});

  void setProperties(final Set<TransitionProperty>? properties) {
    _properties.clear();
    if (properties != null) {
      _properties.addAll(properties);
    }
  }

  bool has(final TransitionProperty property) =>
      // check for all properties 'group'
      _properties.contains(TransitionProperty.all) ||
      // Check for specific property
      _properties.contains(property) ||
      // Check for border property 'group'
      (property.isBorderProperty &&
          _properties.contains(TransitionProperty.border));

  Color? _lerpBoxShadowColor(
    final TwStyle begin,
    final TwStyle end,
    final double t,
  ) {
    final beginBoxShadowColor =
        begin.boxShadowColor?.color ?? begin.boxShadow?.firstColor;
    final endBoxShadowColor =
        end.boxShadowColor?.color ?? end.boxShadow?.firstColor;
    return Color.lerp(
      beginBoxShadowColor == Colors.transparent ? null : beginBoxShadowColor,
      endBoxShadowColor == Colors.transparent ? null : endBoxShadowColor,
      t,
    );
  }

  TwLineHeight _lerpLineHeightPercentage(
    final TwStyle begin,
    final TwStyle end,
    final double t,
  ) {
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

  @override
  TwStyle? lerp(final double t) {
    final begin = this.begin;
    final end = this.end;
    if (begin == end) return begin;
    if (begin == null || end == null) return null;

    final boxShadowColor = (has(TransitionProperty.boxShadow))
        ? TwBoxShadowColor.fromColor(_lerpBoxShadowColor(begin, end, t))
        : null;

    final lineHeight = has(TransitionProperty.lineHeight)
        ? _lerpLineHeightPercentage(begin, end, t)
        : null;

    final fontSize = has(TransitionProperty.fontSize)
        ? TwFontSize(
            PxUnit(
              ui.lerpDouble(begin.fontSizePx, end.fontSizePx, t) ??
                  TwFontSize.defaultFontSizePx,
            ),
            lineHeight ?? TwLineHeight.defaultLineHeight,
          )
        : null;

    return TwStyle(
      textColor: has(TransitionProperty.textColor)
          ? TwTextColor.fromColor(
              Color.lerp(
                begin.textColor?.tweenColor,
                end.textColor?.tweenColor,
                t,
              ),
            )
          : null,
      backgroundColor: has(TransitionProperty.backgroundColor)
          ? TwBackgroundColor.fromColor(
              Color.lerp(
                begin.backgroundColor?.tweenColor,
                end.backgroundColor?.tweenColor,
                t,
              ),
            )
          : null,
      borderColor: has(TransitionProperty.borderColor)
          ? TwBorderColor.fromColor(
              Color.lerp(
                begin.borderColor?.tweenColor,
                end.borderColor?.tweenColor,
                t,
              ),
            )
          : null,
      boxShadowColor: boxShadowColor,
      textDecorationColor: has(TransitionProperty.textDecorationColor)
          ? TwTextDecorationColor.fromColor(
              Color.lerp(
                begin.textDecorationColor?.tweenColor,
                end.textDecorationColor?.tweenColor,
                t,
              ),
            )
          : null,
      borderRadius: has(TransitionProperty.borderRadius)
          ? TwBorderRadius.fromBorderRadius(
              BorderRadius.lerp(
                begin.borderRadius?.toBorderRadius() ?? BorderRadius.zero,
                end.borderRadius?.toBorderRadius() ?? BorderRadius.zero,
                t,
              ),
            )
          : null,
      border: has(TransitionProperty.borderWidth)
          ? TwBorder(
              top: TwBorderTop.fromPx(
                ui.lerpDouble(
                  begin.border?.topPx ?? 0,
                  end.border?.topPx ?? 0,
                  t,
                ),
              ),
              right: TwBorderRight.fromPx(
                ui.lerpDouble(
                  begin.border?.rightPx ?? 0,
                  end.border?.rightPx ?? 0,
                  t,
                ),
              ),
              bottom: TwBorderBottom.fromPx(
                ui.lerpDouble(
                  begin.border?.bottomPx ?? 0,
                  end.border?.bottomPx ?? 0,
                  t,
                ),
              ),
              left: TwBorderLeft.fromPx(
                ui.lerpDouble(
                  begin.border?.leftPx ?? 0,
                  end.border?.leftPx ?? 0,
                  t,
                ),
              ),
            )
          : null,
      boxShadow: has(TransitionProperty.boxShadow)
          ? TwBoxShadows.fromBoxShadows(
              BoxShadow.lerpList(
                begin.boxShadow?.withColor(boxShadowColor),
                end.boxShadow?.withColor(boxShadowColor),
                t,
              ),
            )
          : null,
      opacity: has(TransitionProperty.opacity)
          ? TwOpacity(
              ui.lerpDouble(
                    begin.opacity?.value ?? 1,
                    end.opacity?.value ?? 1,
                    t,
                  ) ??
                  1,
            )
          : null,
      fontWeight: has(TransitionProperty.fontWeight)
          ? TwFontWeight(
              FontWeight.lerp(
                    begin.fontWeight?.fontWeight ??
                        TwFontWeight.defaultFlutterFontWeight,
                    end.fontWeight?.fontWeight ??
                        TwFontWeight.defaultFlutterFontWeight,
                    t,
                  )?.value ??
                  400,
            )
          : null,
      lineHeight: lineHeight,
      fontSize: fontSize,
      textDecorationThickness: has(TransitionProperty.textDecorationThickness)
          ? TwTextDecorationThickness(
              PxUnit(
                ui.lerpDouble(
                      begin.textDecorationThickness?.value
                              .pixels(fontSize?.value.pixels()) ??
                          0,
                      end.textDecorationThickness?.value
                              .pixels(fontSize?.value.pixels()) ??
                          0,
                      t,
                    ) ??
                    0,
              ),
            )
          : const TwTextDecorationThickness(PxUnit(0)),
      letterSpacing: has(TransitionProperty.letterSpacing)
          ? TwLetterSpacing(
              fontSize != null
                  ? EmUnit(
                      ui.lerpDouble(
                            begin.letterSpacing?.value
                                    .pixels(fontSize.value.pixels()) ??
                                0,
                            end.letterSpacing?.value
                                    .pixels(fontSize.value.pixels()) ??
                                0,
                            t,
                          ) ??
                          0,
                    )
                  : const EmUnit(0),
            )
          : null,
    );
  }
}
