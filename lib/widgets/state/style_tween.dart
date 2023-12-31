import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:tailwind_elements/config/options/borders/border_radius.dart';
import 'package:tailwind_elements/config/options/borders/border_width.dart';
import 'package:tailwind_elements/config/options/colors.dart';
import 'package:tailwind_elements/config/options/effects/box_shadow.dart';
import 'package:tailwind_elements/config/options/effects/opacity.dart';
import 'package:tailwind_elements/config/options/transitions/transition_property.dart';
import 'package:tailwind_elements/config/options/typography/font_size.dart';
import 'package:tailwind_elements/config/options/typography/font_weight.dart';
import 'package:tailwind_elements/config/options/typography/letter_spacing.dart';
import 'package:tailwind_elements/config/options/typography/line_height.dart';
import 'package:tailwind_elements/config/options/typography/text_decoration_thickness.dart';
import 'package:tailwind_elements/widgets/style/style.dart';

/// Tween class for [TwStyle] values. Supports conditional evaluation of
/// properties to be tweened via [setProperties], which is used by
/// [TwTransitionController].
class TwStyleTween extends Tween<TwStyle?> {
  final Set<TransitionProperty> _properties = {};

  TwStyleTween({super.begin, super.end});

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
