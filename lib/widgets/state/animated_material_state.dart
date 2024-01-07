import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tailwind_elements/config/options/borders/border_radius.dart';
import 'package:tailwind_elements/config/options/sizing/height.dart';
import 'package:tailwind_elements/config/options/sizing/max_height.dart';
import 'package:tailwind_elements/config/options/sizing/max_width.dart';
import 'package:tailwind_elements/config/options/sizing/min_height.dart';
import 'package:tailwind_elements/config/options/sizing/min_width.dart';
import 'package:tailwind_elements/config/options/sizing/width.dart';
import 'package:tailwind_elements/config/options/typography/font_size.dart';
import 'package:tailwind_elements/config/options/typography/line_height.dart';
import 'package:tailwind_elements/config/options/units/measurement_unit.dart';
import 'package:tailwind_elements/widgets/animation/style_tween.dart';
import 'package:tailwind_elements/widgets/inherited/parent_constraints_data.dart';
import 'package:tailwind_elements/widgets/state/material_state.dart';
import 'package:tailwind_elements/widgets/state/stateful_widget.dart';
import 'package:tailwind_elements/widgets/style/style.dart';

extension StyleRadiusExt on TwBorderRadius {
  TwBorderRadius? minimizeCircle(
    final PxUnit? width,
    final PxUnit? height,
    final TwFontSize fontSize,
    final TwLineHeight lineHeight,
  ) {
    final halfWidth =
        width != null ? (width.value / 2).ceilToDouble() : double.infinity;
    final halfHeight =
        height != null ? (height.value / 2).ceilToDouble() : double.infinity;
    if (halfWidth.isInfinite && halfHeight.isInfinite) {
      final fontSizePx = fontSize.value.pixels();
      final lineHeightPercentFloat = lineHeight.asPercentageFloat(fontSizePx);
      return TwBorderRadius.all(
        TwBorderRadiusAll(
          PxUnit(
            (fontSize.value.pixels() * lineHeightPercentFloat).ceilToDouble(),
          ),
        ),
      );
    }
    if (halfWidth.isInfinite) {
      return TwBorderRadius.all(
        TwBorderRadiusAll(
          PxUnit(halfHeight),
        ),
      );
    }
    if (halfHeight.isInfinite) {
      return TwBorderRadius.all(
        TwBorderRadiusAll(
          PxUnit(halfWidth),
        ),
      );
    }
    final minRadius = min(halfWidth, halfHeight);
    return TwBorderRadius.all(
      TwBorderRadiusAll(
        PxUnit(minRadius),
      ),
    );
  }
}

/// Extension method for [TwStyle] that converts relative sizing units to absolute units on the
/// constraint properties only (see also [TwConstraints]), and also minimizes the border radius
/// values for 'rounded-full' to the minimum value required to create a circular border.
extension TransformConstraints on TwStyle {
  TwStyle transformConstraintsToAbsolute(
    final BoxConstraints? parentConstraints,
  ) {
    if (parentConstraints == null) return this;

    final PxUnit? widthToAbsolute = switch (width?.value) {
      CssAbsoluteUnit() => PxUnit((width!.value as CssAbsoluteUnit).pixels()),
      CssRelativeUnit() => PxUnit(
          (width!.value as CssRelativeUnit).percentageFloat() *
              parentConstraints.maxWidth,
        ),
      _ => null,
    };

    final PxUnit? heightToAbsolute = switch (height?.value) {
      CssAbsoluteUnit() => PxUnit((height!.value as CssAbsoluteUnit).pixels()),
      CssRelativeUnit() => PxUnit(
          (height!.value as CssRelativeUnit).percentageFloat() *
              parentConstraints.maxHeight,
        ),
      _ => null,
    };

    final PxUnit? minWidthToAbsolute = switch (minWidth?.value) {
      CssAbsoluteUnit() =>
        PxUnit((minWidth!.value as CssAbsoluteUnit).pixels()),
      CssRelativeUnit() => PxUnit(
          (minWidth!.value as CssRelativeUnit).percentageFloat() *
              parentConstraints.maxWidth,
        ),
      _ => null,
    };

    final PxUnit? minHeightToAbsolute = switch (minHeight?.value) {
      CssAbsoluteUnit() =>
        PxUnit((minHeight!.value as CssAbsoluteUnit).pixels()),
      CssRelativeUnit() => PxUnit(
          (minHeight!.value as CssRelativeUnit).percentageFloat() *
              parentConstraints.maxHeight,
        ),
      _ => null,
    };

    final PxUnit? maxWidthToAbsolute = switch (maxWidth?.value) {
      CssAbsoluteUnit() =>
        PxUnit((maxWidth!.value as CssAbsoluteUnit).pixels()),
      CssRelativeUnit() => PxUnit(
          (maxWidth!.value as CssRelativeUnit).percentageFloat() *
              parentConstraints.maxWidth,
        ),
      _ => null,
    };

    final PxUnit? maxHeightToAbsolute = switch (maxHeight?.value) {
      CssAbsoluteUnit() =>
        PxUnit((maxHeight!.value as CssAbsoluteUnit).pixels()),
      CssRelativeUnit() => PxUnit(
          (maxHeight!.value as CssRelativeUnit).percentageFloat() *
              parentConstraints.maxHeight,
        ),
      _ => null,
    };

    return copyWith(
      width: widthToAbsolute != null ? TwWidth(widthToAbsolute) : null,
      height: heightToAbsolute != null ? TwHeight(heightToAbsolute) : null,
      minWidth:
          minWidthToAbsolute != null ? TwMinWidth(minWidthToAbsolute) : null,
      minHeight:
          minHeightToAbsolute != null ? TwMinHeight(minHeightToAbsolute) : null,
      maxWidth:
          maxWidthToAbsolute != null ? TwMaxWidth(maxWidthToAbsolute) : null,
      maxHeight:
          maxHeightToAbsolute != null ? TwMaxHeight(maxHeightToAbsolute) : null,
      borderRadius: (borderRadius?.isCircle ?? false)
          ? borderRadius?.minimizeCircle(
              widthToAbsolute ?? maxWidthToAbsolute,
              heightToAbsolute ?? maxHeightToAbsolute,
              fontSize ?? TwFontSize.defaultFontSize,
              lineHeight ?? TwLineHeight.defaultLineHeight,
            )
          : borderRadius,
    );
  }
}

/// An [TwMaterialState] with support for animated style transitions.
abstract class TwAnimatedMaterialState<T extends TwStatefulWidget>
    extends TwMaterialState<T> {
  /// Default transition property duration if a transition property is set.
  /// Value taken from https://tailwindcss.com/docs/transition-property.
  static const defaultDuration = Duration(milliseconds: 150);

  /// Default transition timing function if a transition property is set.
  /// Value taken from https://tailwindcss.com/docs/transition-property.
  static const defaultCurve = Cubic(0.4, 0, 0.2, 1);

  /// Current animation curve
  CurvedAnimation? animationCurve;

  /// Current animation delay
  Duration delay = Duration.zero;

  /// Internal (linear-time) animation controller for the widget using this class
  AnimationController? animationController;

  /// Style tween
  TwStyleTween? styleTween;

  /// Parent constraints data
  BoxConstraints? parentConstraints;

  /// Rebuilds the widget when the animation controller updates.
  void handleAnimationControllerUpdate() {
    if (mounted) {
      setState(() {});
    }
  }

  /// Called when an [InheritedWidget] that this widget depends on changes
  /// from upstream.
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final ParentConstraintsData? parentConstraintsData =
        ParentConstraintsData.of(context);
    parentConstraints = parentConstraintsData?.constraints;
    final currentStyle = getCurrentStyle(currentStates);
    initAnimationController(currentStyle);
    updateAnimationControllerData(currentStyle);
  }

  /// Called when the set of [MaterialState]s stored by the [statesController]
  /// changes.
  @override
  void handleStatesControllerChange() {
    final currentStyle = getCurrentStyle(currentStates);
    initAnimationController(currentStyle);
    updateAnimationControllerData(currentStyle);
    // Notify state change
    super.handleStatesControllerChange();
  }

  void updateAnimationControllerData(final TwStyle currentStyle) {
    /// Update animation controller curve and duration if the controller exists
    final animationController = this.animationController;
    if (animationController == null) return;

    styleTween?.setProperties(currentStyle.transition?.properties);
    styleTween?.setParentConstraints(parentConstraints);

    // Compute new animation curve using current style's transition timing function,
    // with fallback to the default curve.
    final Curve nextCurve =
        currentStyle.transitionTimingFn?.curve ?? defaultCurve;
    this.animationCurve ??= CurvedAnimation(
      parent: animationController,
      curve: nextCurve,
    );
    final animationCurve = this.animationCurve;
    if (animationCurve != null && animationCurve.curve != nextCurve) {
      animationCurve.curve = nextCurve;
    }

    // Compute new animation duration using current style's transition timing function,
    // with fallback to the default duration.
    final Duration nextDuration =
        currentStyle.transitionDuration?.duration.value ?? defaultDuration;
    if (animationController.duration != nextDuration) {
      animationController.duration = nextDuration;
    }

    // Compute new animation delay using current style's transition delay, with fallback to
    // zero.
    final Duration nextDelay =
        currentStyle.transitionDelay?.delay.value ?? Duration.zero;
    if (delay != nextDelay) {
      delay = nextDelay;
    }

    // Update animation controller tween values
    updateTweens(currentStyle);
    animateTweens(delay);
  }

  @override
  void didUpdateWidget(final T oldWidget) {
    super.didUpdateWidget(oldWidget);
    final currentStyle = getCurrentStyle(currentStates);
    if (widget.hasTransitions != oldWidget.hasTransitions) {
      // Dispose old animation controller and re-init a new one
      this.animationController?.removeListener(handleAnimationControllerUpdate);
      this.animationController?.dispose();
      this.animationController = null;
      this.animationCurve?.dispose();
      this.animationCurve = null;
      initAnimationController(currentStyle);
    }
    updateAnimationControllerData(currentStyle);
  }

  TickerProvider getTickerProvider();

  /// Initializes the animation controller and creates a new controller instance only if the widget
  /// has transitions enabled and if the controller has not already been initialized yet.
  void initAnimationController(final TwStyle currentStyle) {
    if (widget.hasTransitions) {
      animationController ??= AnimationController(
        vsync: getTickerProvider(),
        duration:
            currentStyle.transitionDuration?.duration.value ?? defaultDuration,
        debugLabel: kDebugMode ? widget.toStringShort() : null,
      )..addListener(handleAnimationControllerUpdate);

      styleTween ??= TwStyleTween(
        begin: currentStyle.transformConstraintsToAbsolute(parentConstraints),
        end: currentStyle.transformConstraintsToAbsolute(parentConstraints),
        parentConstraints: parentConstraints,
      );
    }
  }

  void updateTweens(final TwStyle currentStyle) {
    _updateStyleTween(styleTween, currentStyle);
  }

  void _updateStyleTween(
    final TwStyleTween? tween,
    final TwStyle targetStyle,
  ) {
    if (tween == null) {
      return;
    }
    final animationCurve = this.animationCurve;
    if (animationCurve == null) {
      return;
    }
    tween
      ..begin = tween.evaluate(animationCurve)
      ..end = targetStyle.transformConstraintsToAbsolute(parentConstraints);
  }

  void animateTweens(final Duration delay) {
    final animationController = this.animationController;
    final animationCurve = this.animationCurve;
    if (!(animationController != null && animationCurve != null && mounted)) {
      return;
    }

    animationController.value = 0.0;

    if (delay != Duration.zero) {
      Future.delayed(delay, () {
        animationController.forward();
      });
    } else {
      animationController.forward();
    }
  }

  @override
  void dispose() {
    animationController?.removeListener(handleAnimationControllerUpdate);
    animationController?.dispose();
    animationCurve?.dispose();
    super.dispose();
  }

  TwStyle? getAnimatedStyle() {
    final animationCurve = this.animationCurve;
    if (animationCurve != null) {
      return styleTween?.evaluate(animationCurve);
    }
    return null;
  }
}
