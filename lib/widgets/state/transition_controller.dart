import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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
    _boxShadow = BoxShadowsTween(
      begin: defaultStyle.boxShadow?.toBoxShadows(defaultStyle.boxShadowColor),
      end: defaultStyle.boxShadow?.toBoxShadows(defaultStyle.boxShadowColor),
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

  BorderRadius? _computeBorderRadius({
    required final TwStyle currentStyle,
    required final TwStyle defaultStyle,
  }) {
    final trackedConstraints = _trackedConstraints;
    if (trackedConstraints == null) {
      return currentStyle.borderRadius?.toBorderRadius() ??
          defaultStyle.borderRadius?.toBorderRadius();
    }

    if (currentStyle.borderRadius != null) {
      final bool isCircle = currentStyle.borderRadius!.isCircle;
      return isCircle
          ? BorderRadius.circular(trackedConstraints.circleRadius)
          : currentStyle.borderRadius!.toBorderRadius();
    }
    final bool isCircle = defaultStyle.borderRadius?.isCircle ?? false;
    return isCircle
        ? BorderRadius.circular(trackedConstraints.circleRadius)
        : defaultStyle.borderRadius?.toBorderRadius();
  }

  /// Updates the tweens for the current transition.
  void updateTweens(final TwStyle defaultStyle, final TwStyle nextStyle) {
    _updateTween(
      tween: _textColor,
      targetValue: (nextStyle.textColor != null)
          ? nextStyle.textColor!.tweenColor
          : defaultStyle.textColor?.tweenColor,
      shouldAnimate: canAnimateProperty(
        property: TransitionProperty.textColor,
        defaultStyle: defaultStyle,
        currentStyle: nextStyle,
      ),
    );
    _updateTween<Color?>(
      tween: _backgroundColor,
      // If the next style has a transparent background, set the target value to
      // null so that the background color does not transition from black.
      // See [ColorTween] for more details.
      targetValue: (nextStyle.backgroundColor != null)
          ? nextStyle.backgroundColor!.tweenColor
          : defaultStyle.backgroundColor?.tweenColor,
      shouldAnimate: canAnimateProperty(
        property: TransitionProperty.backgroundColor,
        defaultStyle: defaultStyle,
        currentStyle: nextStyle,
      ),
    );
    _updateTween<Color?>(
      tween: _borderColor,
      targetValue: (nextStyle.borderColor != null)
          ? nextStyle.borderColor!.tweenColor
          : defaultStyle.borderColor?.tweenColor,
      shouldAnimate: canAnimateProperty(
        property: TransitionProperty.borderColor,
        defaultStyle: defaultStyle,
        currentStyle: nextStyle,
      ),
    );
    _updateTween<BorderRadius?>(
      tween: _borderRadius,
      targetValue: _computeBorderRadius(
        currentStyle: nextStyle,
        defaultStyle: defaultStyle,
      ),
      shouldAnimate: canAnimateProperty(
        property: TransitionProperty.borderRadius,
        defaultStyle: defaultStyle,
        currentStyle: nextStyle,
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
      targetValue: nextStyle.boxShadow?.toBoxShadows(
            nextStyle.boxShadowColor ?? defaultStyle.boxShadowColor,
          ) ??
          defaultStyle.boxShadow?.toBoxShadows(
            nextStyle.boxShadowColor ?? defaultStyle.boxShadowColor,
          ),
      shouldAnimate: canAnimateProperty(
        property: TransitionProperty.boxShadow,
        defaultStyle: defaultStyle,
        currentStyle: nextStyle,
      ),
    );
    _updateTween<BoxConstraints>(
      tween: _boxConstraints,
      targetValue: _trackedConstraints ?? BoxConstraints.tight(Size.zero),
      shouldAnimate: canAnimateProperty(
            property: TransitionProperty.width,
            defaultStyle: defaultStyle,
            currentStyle: nextStyle,
          ) ||
          canAnimateProperty(
            property: TransitionProperty.height,
            defaultStyle: defaultStyle,
            currentStyle: nextStyle,
          ),
    );
    _updateTween<double>(
      tween: _opacity,
      targetValue: nextStyle.opacity?.value ?? 1,
      shouldAnimate: canAnimateProperty(
        property: TransitionProperty.opacity,
        defaultStyle: defaultStyle,
        currentStyle: nextStyle,
      ),
    );
  }

  /// Animates the transition.
  void animate() {
    if (!canAnimate) return;
    final animationController = _animationController;
    if (animationController != null) {
      animationController
        ..value = 0.0
        ..forward();
    }
  }

  /// Updates the tracked constraints and the tween value for the constraints.
  /// This may be called by the widget in the build method when using a
  /// [LayoutBuilder] to calculate the constraints.
  void updateTrackedConstraints({
    required final BoxConstraints? constraints,
    required final TwStyle currentStyle,
    required final TwStyle defaultStyle,
  }) {
    _updateTween(
      tween: _boxConstraints,
      targetValue: constraints,
      shouldAnimate: canAnimateProperty(
            property: TransitionProperty.width,
            defaultStyle: defaultStyle,
            currentStyle: currentStyle,
          ) ||
          canAnimateProperty(
            property: TransitionProperty.height,
            defaultStyle: defaultStyle,
            currentStyle: currentStyle,
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

  Decoration? getBoxDecoration({
    required final TwStyle defaultStyle,
    required final TwStyle currentStyle,
  }) {
    if (!canAnimate) return null;
    // Static background color
    final staticBackgroundColor = currentStyle.backgroundColor?.color ??
        defaultStyle.backgroundColor?.color;

    // Static border color
    final staticBorderColor =
        currentStyle.borderColor?.color ?? defaultStyle.borderColor?.color;

    // Static border radius
    final staticBorderRadius = _computeBorderRadius(
      currentStyle: currentStyle,
      defaultStyle: defaultStyle,
    );

    // Static box shadows
    final staticBoxShadows = currentStyle.boxShadow?.toBoxShadows(
          currentStyle.boxShadowColor,
        ) ??
        defaultStyle.boxShadow?.toBoxShadows(defaultStyle.boxShadowColor);

    final targetBorder = currentStyle.border ?? defaultStyle.border;

    return BoxDecoration(
      color: canAnimateProperty(
        property: TransitionProperty.backgroundColor,
        defaultStyle: defaultStyle,
        currentStyle: currentStyle,
      )
          ? backgroundColor ?? staticBackgroundColor
          : staticBackgroundColor,
      image: currentStyle.backgroundImage ?? defaultStyle.backgroundImage,
      gradient:
          currentStyle.backgroundGradient ?? defaultStyle.backgroundGradient,
      // TODO: animate border thickness
      border: targetBorder?.toBorder(
        canAnimateProperty(
          property: TransitionProperty.borderColor,
          defaultStyle: defaultStyle,
          currentStyle: currentStyle,
        )
            ? borderColor ?? staticBorderColor
            : staticBorderColor,
        currentStyle.borderStrokeAlign ?? defaultStyle.borderStrokeAlign,
      ),
      borderRadius: canAnimateProperty(
        property: TransitionProperty.borderRadius,
        defaultStyle: defaultStyle,
        currentStyle: currentStyle,
      )
          ? borderRadius ?? staticBorderRadius
          : staticBorderRadius,
      boxShadow: canAnimateProperty(
        property: TransitionProperty.boxShadow,
        defaultStyle: defaultStyle,
        currentStyle: currentStyle,
      )
          ? boxShadow ?? staticBoxShadows
          : staticBoxShadows,
    );
  }

  bool canAnimateProperty({
    required final TransitionProperty property,
    required final TwStyle defaultStyle,
    required final TwStyle currentStyle,
  }) {
    if (!canAnimate) return false;
    return (currentStyle.transition?.has(property) ?? false) ||
        (defaultStyle.transition?.has(property) ?? false);
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

  List<BoxShadow>? get boxShadow =>
      canAnimate ? _boxShadow?.evaluate(_animationCurve!) : null;

  BoxConstraints? get boxConstraints =>
      canAnimate ? _boxConstraints?.evaluate(_animationCurve!) : null;

  double? get opacity =>
      canAnimate ? _opacity?.evaluate(_animationCurve!) : null;
}
