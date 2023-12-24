import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tailwind_elements/config/options/transitions/transition_property.dart';
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
  DecorationTween? _boxDecoration;
  BoxConstraintsTween? _boxConstraints;
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
    if (defaultStyle.hasTransition(TransitionProperty.color)) {
      _textColor = ColorTween(
        begin: defaultStyle.textColor?.color,
        end: defaultStyle.textColor?.color,
      );
    }
    if (defaultStyle.hasTransition(TransitionProperty.backgroundColor)) {
      _backgroundColor = ColorTween(
        begin: defaultStyle.backgroundColor?.color,
        end: defaultStyle.backgroundColor?.color,
      );
    }

    if (defaultStyle.hasTransition(TransitionProperty.borderColor)) {
      _borderColor = ColorTween(
        begin: defaultStyle.borderColor?.color,
        end: defaultStyle.borderColor?.color,
      );
    }

    // TODO: text decoration color
    // if (defaultStyle.hasTransition(TransitionProperty.textDecorationColor) ??
    //     false) {
    //   _textDecorationColor = ColorTween(
    //     begin: defaultStyle.textDecorationColor?.color,
    //     end: defaultStyle.textDecorationColor?.color,
    //   );
    // }

    if (defaultStyle.hasTransition(TransitionProperty.boxShadow)) {
      _boxDecoration = DecorationTween(
        begin: defaultStyle.getBoxDecoration(defaultStyle),
        end: defaultStyle.getBoxDecoration(defaultStyle),
      );
    }

    if (defaultStyle.hasTransition(TransitionProperty.width) ||
        defaultStyle.hasTransition(TransitionProperty.height)) {
      _boxConstraints = BoxConstraintsTween(
        begin: _trackedConstraints ?? BoxConstraints.tight(Size.zero),
        end: _trackedConstraints ?? BoxConstraints.tight(Size.zero),
      );
    }

    if (defaultStyle.hasTransition(TransitionProperty.opacity)) {
      _opacity = Tween<double>(
        begin: defaultStyle.opacity?.value ?? 1,
        end: defaultStyle.opacity?.value ?? 1,
      );
    }
  }

  void _updateTween<T>({
    required final Tween<T>? tween,
    required final T targetValue,
  }) {
    if (tween == null) return;
    final animation = _animationCurve;
    if (animation == null) return;
    tween
      ..begin = tween.evaluate(animation)
      ..end = targetValue;
  }

  /// Updates the tweens for the current transition.
  void updateTweens(final TwStyle defaultStyle, final TwStyle nextStyle) {
    _updateTween(
      tween: _textColor,
      targetValue: nextStyle.textColor?.color == Colors.transparent
          ? null
          : nextStyle.textColor?.color,
    );
    _updateTween(
      tween: _backgroundColor,
      // If the next style has a transparent background, set the target value to
      // null so that the background color does not transition from black.
      // See [ColorTween] for more details.
      targetValue: nextStyle.backgroundColor?.color == Colors.transparent
          ? null
          : nextStyle.backgroundColor?.color,
    );
    _updateTween(
      tween: _borderColor,
      targetValue: nextStyle.borderColor?.color == Colors.transparent
          ? null
          : nextStyle.borderColor?.color,
    );
    // TODO: update tween for text decoration color
    // _updateTween(
    //   tween: _textDecorationColor,
    //   targetValue: nextStyle.textDecorationColor?.color == Colors.transparent
    //       ? null
    //       : nextStyle.textDecorationColor?.color,
    // );
    _updateTween(
      tween: _boxDecoration,
      targetValue: _computeBoxDecoration(
        defaultStyle,
        nextStyle,
      ),
    );
    _updateTween(
      tween: _boxConstraints,
      targetValue: _trackedConstraints ?? BoxConstraints.tight(Size.zero),
    );
    _updateTween(
      tween: _opacity,
      targetValue: nextStyle.opacity?.value ?? 1,
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
  void updateTrackedConstraints(final BoxConstraints? constraints) {
    _updateTween(tween: _boxConstraints, targetValue: constraints);
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

  Decoration? _computeBoxDecoration(
    final TwStyle defaultStyle,
    final TwStyle currentStyle,
  ) {
    if (!canAnimate) return null;
    final bool isCircle = currentStyle.borderRadius?.isCircle ??
        defaultStyle.borderRadius?.isCircle ??
        false;
    final backgroundColor = currentStyle.backgroundColor?.color ??
        defaultStyle.backgroundColor?.color;
    final twBorder = currentStyle.border ?? defaultStyle.border;
    final targetBorderColor =
        currentStyle.borderColor?.color ?? defaultStyle.borderColor?.color;
    final border = twBorder?.toBorder(
      targetBorderColor,
      currentStyle.borderStrokeAlign ?? defaultStyle.borderStrokeAlign,
    );
    final trackedConstraints = _trackedConstraints;
    final borderRadius = isCircle && trackedConstraints != null
        ? BorderRadius.circular(
            max(trackedConstraints.minWidth, trackedConstraints.minHeight),
          )
        : currentStyle.borderRadius?.toBorderRadius() ??
            defaultStyle.borderRadius?.toBorderRadius();
    return BoxDecoration(
      shape: BoxShape.rectangle,
      color: backgroundColor,
      image: currentStyle.backgroundImage ?? defaultStyle.backgroundImage,
      gradient:
          currentStyle.backgroundGradient ?? defaultStyle.backgroundGradient,
      border: border,
      borderRadius: borderRadius,
      boxShadow:
          currentStyle.boxShadow?.toBoxShadows(currentStyle.boxShadowColor) ??
              defaultStyle.boxShadow?.toBoxShadows(defaultStyle.boxShadowColor),
    );
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

  Decoration? get boxDecoration =>
      canAnimate ? _boxDecoration?.evaluate(_animationCurve!) : null;

  BoxConstraints? get boxConstraints =>
      canAnimate ? _boxConstraints?.evaluate(_animationCurve!) : null;

  double? get opacity =>
      canAnimate ? _opacity?.evaluate(_animationCurve!) : null;
}
