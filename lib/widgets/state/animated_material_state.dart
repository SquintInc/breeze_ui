import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tailwind_elements/config/options/transitions/transition_property.dart';
import 'package:tailwind_elements/widgets/animation/style_tween.dart';
import 'package:tailwind_elements/widgets/inherited/parent_constraints_data.dart';
import 'package:tailwind_elements/widgets/state/material_state.dart';
import 'package:tailwind_elements/widgets/state/stateful_widget.dart';
import 'package:tailwind_elements/widgets/style/style.dart';

/// An [TwMaterialState] with support for animated style transitions.
abstract class TwAnimatedMaterialState<T extends TwStatefulWidget>
    extends TwMaterialState<T> with SingleTickerProviderStateMixin {
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

  /// Tracks the current style's list of properties that can be tweened.
  Set<TransitionProperty> transitionProperties = {};

  /// Style tween
  TwStyleTween? styleTween;

  /// Parent constraints data
  BoxConstraints? _parentConstraints;

  /// Rebuilds the widget when the animation controller updates.
  void handleAnimationControllerUpdate() {
    setState(() {});
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final ParentConstraintsData? parentConstraintsData =
        ParentConstraintsData.of(context);
    _parentConstraints = parentConstraintsData?.constraints;
    final currentStyle = getCurrentStyle();
    initAnimationController(currentStyle);
    updateAnimationControllerData(currentStyle);
  }

  @override
  void handleStatesControllerChange() {
    super.handleStatesControllerChange();
    final currentStyle = getCurrentStyle();
    updateAnimationControllerData(currentStyle);
  }

  void updateAnimationControllerData(final TwStyle currentStyle) {
    /// Update animation controller curve and duration if the controller exists
    final animationController = this.animationController;
    if (animationController == null) return;

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
    _updateStyleTween(styleTween, currentStyle);
    _animate(delay);
  }

  @override
  void didUpdateWidget(final T oldWidget) {
    super.didUpdateWidget(oldWidget);
    final currentStyle = getCurrentStyle();
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

  /// Initializes the animation controller and creates a new controller instance only if the widget
  /// has transitions enabled and if the controller has not already been initialized yet.
  void initAnimationController(final TwStyle currentStyle) {
    if (widget.hasTransitions) {
      animationController ??= AnimationController(
        vsync: this,
        duration:
            widget.style.transitionDuration?.duration.value ?? defaultDuration,
        debugLabel: kDebugMode ? widget.toStringShort() : null,
      )..addListener(handleAnimationControllerUpdate);

      styleTween ??= TwStyleTween(
        begin: styleTween?.end ?? widget.style,
        end: widget.style,
      );
      styleTween?.setProperties(currentStyle.transition?.properties);
      styleTween?.setParentConstraints(_parentConstraints);
    }
  }

  void _updateStyleTween(
    final Tween<TwStyle?>? tween,
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
      ..end = targetStyle;
  }

  void _animate(final Duration delay) {
    final animationController = this.animationController;
    final animationCurve = this.animationCurve;
    if (animationController != null && animationCurve != null) {
      animationController.value = 0.0;
      if (delay != Duration.zero) {
        Future.delayed(delay, () {
          animationController.forward();
        });
      } else {
        animationController.forward();
      }
    }
  }

  @override
  void dispose() {
    animationController?.removeListener(handleAnimationControllerUpdate);
    animationController?.dispose();
    animationCurve?.dispose();
    super.dispose();
  }

  TwStyle getAnimatedStyle() {
    final currentStyle = getCurrentStyle();
    final animationCurve = this.animationCurve;
    if (animationCurve != null) {
      final tweenedStyle = styleTween?.evaluate(animationCurve);
      return currentStyle.merge(tweenedStyle);
    }
    return currentStyle;
  }
}
