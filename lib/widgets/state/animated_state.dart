import 'package:flutter/material.dart';
import 'package:tailwind_elements/widgets/state/state.dart';
import 'package:tailwind_elements/widgets/state/transition_controller.dart';

/// Animated [State] extension over [TwState] that adds support for animated
/// transitions via an internal [TwTransitionController].
abstract class TwAnimatedState<T extends TwStatefulWidget> extends TwState<T>
    with SingleTickerProviderStateMixin {
  /// Default transition property duration if a transition property is set.
  /// Value taken from https://tailwindcss.com/docs/transition-property.
  static const defaultDuration = Duration(milliseconds: 150);

  /// Default transition timing function if a transition property is set.
  /// Value taken from https://tailwindcss.com/docs/transition-property.
  static const defaultCurve = Cubic(0.4, 0, 0.2, 1);

  TwTransitionController? _animationController;

  @protected
  TwTransitionController? get animationController => _animationController;

  @override
  void initState() {
    super.initState();
    _initAnimationController();
  }

  void _initAnimationController() {
    if (widget.hasTransitions) {
      // Only create animation controller if transitions are enabled
      _animationController ??= TwTransitionController(
        widget: widget,
        vsync: this,
        duration:
            widget.style.transitionDuration?.duration.value ?? defaultDuration,
        curve: widget.style.transitionTimingFn?.curve ?? defaultCurve,
        redrawAnimationFn: _redrawAnimation,
        animationStatusListener: animationListener,
      );

      // Run [initBoxConstraintsTween] only once, after the first frame has been
      // rendered to ensure that the initial constraints have been already set.
      WidgetsBinding.instance.addPostFrameCallback((final timestamp) {
        _animationController?.initStyleTween(widget.style);
        _animationController?.initBoxConstraintsTween(widget.style);
      });
    }
  }

  /// Rebuilds the widget whenever the animation controller ticks.
  void _redrawAnimation() {
    setState(() {});
  }

  @protected
  void animationListener(final AnimationStatus status);

  @override
  void didUpdateWidget(final T oldWidget) {
    super.didUpdateWidget(oldWidget);
    _animationController?.refreshStyleTweenProperties(widget.style);
    didWidgetStateChange();
  }

  @override
  void didWidgetStateChange() {
    // Update transitions and tweens
    if (widget.hasTransitions) {
      final animationController = this._animationController;
      if (animationController == null) return;
      final mergedStyle = currentStyle;

      // Compute the new animation curve, with fallback to the default curve
      // if it was set in the [style] property.
      final Curve nextCurve =
          mergedStyle.transitionTimingFn?.curve ?? defaultCurve;
      if (animationController.curve != nextCurve) {
        animationController.updateAnimationCurve(nextCurve);
      }

      // Compute the new animation duration, with fallback to the default
      // duration if it was set in the [style] property.
      final Duration nextDuration =
          mergedStyle.transitionDuration?.duration.value ?? defaultDuration;
      if (animationController.duration != nextDuration) {
        animationController.updateAnimationDuration(nextDuration);
      }

      animationController
        ..updateTweens(mergedStyle)
        ..animate(mergedStyle.transitionDelay);
    }
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }
}
