import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tailwind_elements/config/options/borders/border_radius.dart';
import 'package:tailwind_elements/config/options/transitions/transition_delay.dart';
import 'package:tailwind_elements/widgets/state/style_tween.dart';
import 'package:tailwind_elements/widgets/style/style.dart';

/// Controller class that contains all the tracked variables and tween values
/// for animated transitions.
class TwTransitionController {
  /// Current animation curve
  CurvedAnimation? _animationCurve;

  /// Internal animation controller for the widget using this class
  AnimationController? _animationController;

  // Tween values for animated transitions
  // NOTE: no support for fill, stroke, transform, filter, and backdropFilter
  TwStyleTween? _style;
  BoxConstraintsTween? _boxConstraints;

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

  void initStyleTween(final TwStyle style) {
    _style = TwStyleTween(
      begin: style,
      end: style,
    );
    refreshStyleTweenProperties(style);
  }

  void initBoxConstraintsTween(final TwStyle style) {
    _boxConstraints = BoxConstraintsTween(
      begin: _trackedConstraints ?? BoxConstraints.tight(Size.zero),
      end: _trackedConstraints ?? BoxConstraints.tight(Size.zero),
    );
  }

  /// Sets the transition properties that are valid for tween evaluation for the
  /// current style, inside the [TwStyleTween].
  void refreshStyleTweenProperties(final TwStyle style) {
    _style?.setProperties(style.transition?.properties);
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

  TwBorderRadius? _computeBorderRadius(final TwStyle mergedStyle) {
    final trackedConstraints = _trackedConstraints;
    if (trackedConstraints == null) {
      return mergedStyle.borderRadius;
    }

    final bool isCircle = mergedStyle.borderRadius!.isCircle;
    return isCircle
        ? TwBorderRadius.all(
            TwBorderRadiusAll(PxUnit(trackedConstraints.circleRadius)),
          )
        : mergedStyle.borderRadius;
  }

  /// Updates the tweens for the current transition.
  void updateTweens(final TwStyle mergedStyle) {
    final computedStyle = mergedStyle.copyWith(
      borderRadius: _computeBorderRadius(mergedStyle),
    );
    _updateTween(
      tween: _style,
      targetValue: computedStyle,
    );
    _updateTween<BoxConstraints>(
      tween: _boxConstraints,
      targetValue: _trackedConstraints ?? BoxConstraints.tight(Size.zero),
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
    if (_trackedConstraints != constraints) {
      _updateTween(
        tween: _boxConstraints,
        targetValue: constraints,
      );
      _trackedConstraints = constraints;
    }
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

  TwStyle? get animatedStyle =>
      canAnimate ? _style?.evaluate(_animationCurve!) : null;

  BoxConstraints? get animatedBoxConstraints =>
      canAnimate ? _boxConstraints?.evaluate(_animationCurve!) : null;
}
