import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tailwind_elements/config/options/transitions/transition_delay.dart';
import 'package:tailwind_elements/config/options/transitions/transition_property.dart';
import 'package:tailwind_elements/widgets/state/animations/box_shadows_tween.dart';
import 'package:tailwind_elements/widgets/style.dart';

/// Controller class that contains all the tracked variables and tween values
/// for animated transitions.
class TwTransitionController {
  /// Current animation curve
  CurvedAnimation? _animationCurve;

  /// Internal animation controller for the widget using this class
  AnimationController? _animationController;

  // Tween values for animated transitions
  // NOTE: no support for fill, stroke, transform, filter, and backdropFilter
  ColorTween? _textColor;
  ColorTween? _backgroundColor;
  ColorTween? _borderColor;
  ColorTween? _textDecorationColor;
  BorderRadiusTween? _borderRadius;
  Tween<double>? _borderTopPx;
  Tween<double>? _borderRightPx;
  Tween<double>? _borderBottomPx;
  Tween<double>? _borderLeftPx;
  BoxConstraintsTween? _boxConstraints;
  BoxShadowsTween? _boxShadow;
  Tween<double>? _opacity;

  /// Temporary box constraint value tracked for transitions, necessary due to
  /// the fact that [LayoutBuilder] might be used during build time to compute
  /// the constraints for the widget.
  BoxConstraints? _trackedConstraints;

  final VoidCallback redrawAnimationFn;
  final AnimationStatusListener animationStatusListener;

  Curve? get curve => _animationCurve?.curve;

  Duration? get duration => _animationController?.duration;

  bool get canAnimate => curve != null && duration != null;

  TwTransitionController({
    required final Widget widget,
    required final TickerProvider vsync,
    required final Duration? duration,
    required final Curve curve,
    required this.redrawAnimationFn,
    required this.animationStatusListener,
  }) {
    final animationController = AnimationController(
      vsync: vsync,
      duration: duration,
      debugLabel: kDebugMode ? widget.toStringShort() : null,
    )
      ..addListener(redrawAnimationFn)
      ..addStatusListener(animationStatusListener);
    final animationCurve = CurvedAnimation(
      parent: animationController,
      curve: curve,
    );
    _animationCurve = animationCurve;
    _animationController = animationController;
  }

  void updateAnimationDuration(final Duration? duration) {
    final animationController = _animationController;
    if (animationController != null) {
      animationController.duration = duration;
    }
  }

  /// Disposes current internal animation curve and sets it to the provided
  /// [curve].
  void updateAnimationCurve(final Curve? curve) {
    final animationCurve = _animationCurve;
    if (animationCurve != null) {
      animationCurve.dispose();
      final animationController = _animationController;
      if (curve != null && animationController != null) {
        _animationCurve = CurvedAnimation(
          parent: animationController,
          curve: curve,
        );
      } else {
        _animationCurve = null;
      }
    }
  }

  void initTweens(final TwStyle defaultStyle) {
    _textColor = ColorTween(
      begin: defaultStyle.textColor?.color,
      end: defaultStyle.textColor?.color,
    );
    _backgroundColor = ColorTween(
      begin: defaultStyle.backgroundColor?.color,
      end: defaultStyle.backgroundColor?.color,
    );
    _borderColor = ColorTween(
      begin: defaultStyle.borderColor?.color,
      end: defaultStyle.borderColor?.color,
    );
    _borderRadius = BorderRadiusTween(
      begin: defaultStyle.borderRadius?.toBorderRadius() ?? BorderRadius.zero,
      end: defaultStyle.borderRadius?.toBorderRadius() ?? BorderRadius.zero,
    );
    // TODO: text decoration color
    // if (defaultStyle.hasTransition(TransitionProperty.textDecorationColor) ??
    //     false) {
    //   _textDecorationColor = ColorTween(
    //     begin: defaultStyle.textDecorationColor?.color,
    //     end: defaultStyle.textDecorationColor?.color,
    //   );
    // }
    _borderTopPx = Tween<double>(
      begin: defaultStyle.border?.topPx ?? 0,
      end: defaultStyle.border?.topPx ?? 0,
    );
    _borderRightPx = Tween<double>(
      begin: defaultStyle.border?.rightPx ?? 0,
      end: defaultStyle.border?.rightPx ?? 0,
    );
    _borderBottomPx = Tween<double>(
      begin: defaultStyle.border?.bottomPx ?? 0,
      end: defaultStyle.border?.bottomPx ?? 0,
    );
    _borderLeftPx = Tween<double>(
      begin: defaultStyle.border?.leftPx ?? 0,
      end: defaultStyle.border?.leftPx ?? 0,
    );
    _boxShadow = BoxShadowsTween(
      begin: defaultStyle.boxShadow?.withColor(defaultStyle.boxShadowColor),
      end: defaultStyle.boxShadow?.withColor(defaultStyle.boxShadowColor),
    );
    _boxConstraints = BoxConstraintsTween(
      begin: _trackedConstraints ?? BoxConstraints.tight(Size.zero),
      end: _trackedConstraints ?? BoxConstraints.tight(Size.zero),
    );
    _opacity = Tween<double>(
      begin: defaultStyle.opacity?.value ?? 1,
      end: defaultStyle.opacity?.value ?? 1,
    );
  }

  void _updateTween<T>({
    required final Tween<T>? tween,
    required final T targetValue,
    required final bool shouldAnimate,
  }) {
    if (tween == null) return;
    final animation = _animationCurve;
    if (animation == null) return;
    tween
      ..begin = shouldAnimate ? tween.evaluate(animation) : targetValue
      ..end = targetValue;
  }

  BorderRadius? _computeBorderRadius(final TwStyle mergedStyle) {
    final trackedConstraints = _trackedConstraints;
    if (trackedConstraints == null) {
      return mergedStyle.borderRadius?.toBorderRadius();
    }

    final bool isCircle = mergedStyle.borderRadius!.isCircle;
    return isCircle
        ? BorderRadius.circular(trackedConstraints.circleRadius)
        : mergedStyle.borderRadius?.toBorderRadius();
  }

  /// Updates the tweens for the current transition.
  void updateTweens(final TwStyle mergedStyle) {
    _updateTween(
      tween: _textColor,
      targetValue: mergedStyle.textColor?.tweenColor,
      shouldAnimate: canAnimateProperty(
        property: TransitionProperty.textColor,
        mergedStyle: mergedStyle,
      ),
    );
    _updateTween<Color?>(
      tween: _backgroundColor,
      targetValue: mergedStyle.backgroundColor?.tweenColor,
      shouldAnimate: canAnimateProperty(
        property: TransitionProperty.backgroundColor,
        mergedStyle: mergedStyle,
      ),
    );
    _updateTween<Color?>(
      tween: _borderColor,
      targetValue: mergedStyle.borderColor?.tweenColor,
      shouldAnimate: canAnimateProperty(
        property: TransitionProperty.borderColor,
        mergedStyle: mergedStyle,
      ),
    );
    _updateTween<BorderRadius?>(
      tween: _borderRadius,
      targetValue: _computeBorderRadius(mergedStyle),
      shouldAnimate: canAnimateProperty(
        property: TransitionProperty.borderRadius,
        mergedStyle: mergedStyle,
      ),
    );
    _updateTween<double>(
      tween: _borderTopPx,
      targetValue: mergedStyle.border?.topPx ?? 0,
      shouldAnimate: canAnimateProperty(
        property: TransitionProperty.borderWidth,
        mergedStyle: mergedStyle,
      ),
    );
    _updateTween<double>(
      tween: _borderRightPx,
      targetValue: mergedStyle.border?.rightPx ?? 0,
      shouldAnimate: canAnimateProperty(
        property: TransitionProperty.borderWidth,
        mergedStyle: mergedStyle,
      ),
    );
    _updateTween<double>(
      tween: _borderBottomPx,
      targetValue: mergedStyle.border?.bottomPx ?? 0,
      shouldAnimate: canAnimateProperty(
        property: TransitionProperty.borderWidth,
        mergedStyle: mergedStyle,
      ),
    );
    _updateTween<double>(
      tween: _borderLeftPx,
      targetValue: mergedStyle.border?.leftPx ?? 0,
      shouldAnimate: canAnimateProperty(
        property: TransitionProperty.borderWidth,
        mergedStyle: mergedStyle,
      ),
    );
    // TODO: update tween for text decoration color
    // _updateTween(
    //   tween: _textDecorationColor,
    //   targetValue: nextStyle.textDecorationColor?.color == Colors.transparent
    //       ? null
    //       : nextStyle.textDecorationColor?.color,
    // );
    _updateTween<List<BoxShadow>?>(
      tween: _boxShadow,
      targetValue: mergedStyle.boxShadow?.withColor(
        mergedStyle.boxShadowColor,
      ),
      shouldAnimate: canAnimateProperty(
        property: TransitionProperty.boxShadow,
        mergedStyle: mergedStyle,
      ),
    );
    _updateTween<BoxConstraints>(
      tween: _boxConstraints,
      targetValue: _trackedConstraints ?? BoxConstraints.tight(Size.zero),
      shouldAnimate: canAnimateProperty(
            property: TransitionProperty.width,
            mergedStyle: mergedStyle,
          ) ||
          canAnimateProperty(
            property: TransitionProperty.height,
            mergedStyle: mergedStyle,
          ),
    );
    _updateTween<double>(
      tween: _opacity,
      targetValue: mergedStyle.opacity?.value ?? 1,
      shouldAnimate: canAnimateProperty(
        property: TransitionProperty.opacity,
        mergedStyle: mergedStyle,
      ),
    );
  }

  /// Animates the transition.
  void animate(final TwTransitionDelay? transitionDelay) {
    if (!canAnimate) return;
    final animationController = _animationController;
    if (animationController != null) {
      animationController.value = 0.0;
      if (transitionDelay != null) {
        Future.delayed(transitionDelay.delay.value, () {
          animationController.forward();
        });
      } else {
        animationController.forward();
      }
    }
  }

  /// Updates the tracked constraints and the tween value for the constraints.
  /// This may be called by the widget in the build method when using a
  /// [LayoutBuilder] to calculate the constraints.
  void updateTrackedConstraints({
    required final BoxConstraints? constraints,
    required final TwStyle mergedStyle,
  }) {
    _updateTween(
      tween: _boxConstraints,
      targetValue: constraints,
      shouldAnimate: canAnimateProperty(
            property: TransitionProperty.width,
            mergedStyle: mergedStyle,
          ) ||
          canAnimateProperty(
            property: TransitionProperty.height,
            mergedStyle: mergedStyle,
          ),
    );
    _trackedConstraints = constraints;
  }

  void dispose() {
    final animationController = _animationController;
    if (animationController != null) {
      animationController
        ..removeListener(redrawAnimationFn)
        ..removeStatusListener(animationStatusListener)
        ..dispose();
    }
  }

  Decoration? getBoxDecoration(final TwStyle mergedStyle) {
    if (!canAnimate) return null;
    // Static background color
    final Color? staticBackgroundColor = mergedStyle.backgroundColor?.color;

    // Static border color
    final Color? staticBorderColor = mergedStyle.borderColor?.color;

    // Static border radius
    final BorderRadius? staticBorderRadius = _computeBorderRadius(mergedStyle);

    // Static box shadows
    final List<BoxShadow>? staticBoxShadows = mergedStyle.boxShadow?.withColor(
      mergedStyle.boxShadowColor,
    );

    // Static border
    final double strokeAlign =
        mergedStyle.borderStrokeAlign ?? BorderSide.strokeAlignInside;
    final staticBorder =
        mergedStyle.border?.toBorder(staticBorderColor, strokeAlign);

    final bool canAnimateBorderWidth = canAnimateProperty(
      property: TransitionProperty.borderWidth,
      mergedStyle: mergedStyle,
    );
    final bool canAnimateBorderColor = canAnimateProperty(
      property: TransitionProperty.borderColor,
      mergedStyle: mergedStyle,
    );
    final bool shouldUseTweenedBoxBorder =
        canAnimateBorderWidth || canAnimateBorderColor;

    final Color? tweenedBorderColor =
        canAnimateBorderColor ? borderColor : null;
    final Border? tweenedBorder = shouldUseTweenedBoxBorder
        ? Border(
            top: BorderSide(
              color:
                  tweenedBorderColor ?? staticBorderColor ?? Colors.transparent,
              width: borderTopPx ?? staticBorder?.top.width ?? 0,
              strokeAlign: strokeAlign,
            ),
            right: BorderSide(
              color:
                  tweenedBorderColor ?? staticBorderColor ?? Colors.transparent,
              width: borderRightPx ?? staticBorder?.right.width ?? 0,
              strokeAlign: strokeAlign,
            ),
            bottom: BorderSide(
              color:
                  tweenedBorderColor ?? staticBorderColor ?? Colors.transparent,
              width: borderBottomPx ?? staticBorder?.bottom.width ?? 0,
              strokeAlign: strokeAlign,
            ),
            left: BorderSide(
              color:
                  tweenedBorderColor ?? staticBorderColor ?? Colors.transparent,
              width: borderLeftPx ?? staticBorder?.left.width ?? 0,
              strokeAlign: strokeAlign,
            ),
          )
        : null;

    return BoxDecoration(
      color: canAnimateProperty(
        property: TransitionProperty.backgroundColor,
        mergedStyle: mergedStyle,
      )
          ? backgroundColor ?? staticBackgroundColor
          : staticBackgroundColor,
      image: mergedStyle.backgroundImage,
      gradient: mergedStyle.backgroundGradient,
      border: tweenedBorder ?? staticBorder,
      borderRadius: canAnimateProperty(
        property: TransitionProperty.borderRadius,
        mergedStyle: mergedStyle,
      )
          ? borderRadius ?? staticBorderRadius
          : staticBorderRadius,
      boxShadow: canAnimateProperty(
        property: TransitionProperty.boxShadow,
        mergedStyle: mergedStyle,
      )
          ? boxShadow ?? staticBoxShadows
          : staticBoxShadows,
    );
  }

  bool canAnimateProperty({
    required final TransitionProperty property,
    required final TwStyle mergedStyle,
  }) {
    if (!canAnimate) return false;
    return mergedStyle.transition?.has(property) ?? false;
  }

  BoxConstraints? get trackedConstraints => _trackedConstraints;

  Color? get textColor =>
      canAnimate ? _textColor?.evaluate(_animationCurve!) : null;

  Color? get backgroundColor =>
      canAnimate ? _backgroundColor?.evaluate(_animationCurve!) : null;

  Color? get borderColor =>
      canAnimate ? _borderColor?.evaluate(_animationCurve!) : null;

  Color? get textDecorationColor =>
      canAnimate ? _textDecorationColor?.evaluate(_animationCurve!) : null;

  BorderRadius? get borderRadius =>
      canAnimate ? _borderRadius?.evaluate(_animationCurve!) : null;

  double? get borderTopPx =>
      canAnimate ? _borderTopPx?.evaluate(_animationCurve!) : null;

  double? get borderRightPx =>
      canAnimate ? _borderRightPx?.evaluate(_animationCurve!) : null;

  double? get borderBottomPx =>
      canAnimate ? _borderBottomPx?.evaluate(_animationCurve!) : null;

  double? get borderLeftPx =>
      canAnimate ? _borderLeftPx?.evaluate(_animationCurve!) : null;

  List<BoxShadow>? get boxShadow =>
      canAnimate ? _boxShadow?.evaluate(_animationCurve!) : null;

  BoxConstraints? get boxConstraints =>
      canAnimate ? _boxConstraints?.evaluate(_animationCurve!) : null;

  double? get opacity =>
      canAnimate ? _opacity?.evaluate(_animationCurve!) : null;
}
