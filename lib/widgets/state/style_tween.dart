import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:tailwind_elements/config/options/borders/border_radius.dart';
import 'package:tailwind_elements/config/options/borders/border_width.dart';
import 'package:tailwind_elements/config/options/colors.dart';
import 'package:tailwind_elements/config/options/effects/box_shadow.dart';
import 'package:tailwind_elements/config/options/effects/opacity.dart';
import 'package:tailwind_elements/config/options/transitions/transition_property.dart';
import 'package:tailwind_elements/widgets/style.dart';

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

  @override
  TwStyle? lerp(final double t) {
    final begin = this.begin;
    final end = this.end;
    if (begin == end) return begin;
    if (begin == null || end == null) return null;

    final boxShadowColor = Color.lerp(
      begin.boxShadowColor?.tweenColor,
      end.boxShadowColor?.tweenColor,
      t,
    );

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
      boxShadowColor: has(TransitionProperty.boxShadow)
          ? TwBoxShadowColor.fromColor(boxShadowColor)
          : null,
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
                begin.boxShadow?.boxShadows,
                end.boxShadow?.boxShadows,
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
    );
  }
}
