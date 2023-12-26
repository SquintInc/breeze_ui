import 'package:flutter/material.dart';
import 'package:tailwind_elements/widgets/state/state.dart';
import 'package:tailwind_elements/widgets/state/transition_controller.dart';
import 'package:tailwind_elements/widgets/state/widget_state.dart';

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
    if (widget.hasTransitions) {
      // Only create animation controller if transitions are enabled
      _animationController = TwTransitionController(
        widget: widget,
        vsync: this,
        duration:
            widget.style.transitionDuration?.duration.value ?? defaultDuration,
        curve: widget.style.transitionTimingFn?.curve ?? defaultCurve,
        redrawAnimationFn: _redrawAnimation,
        animationStatusListener: animationListener,
      );

      // Run [initTweens] only once, after the first frame has been rendered to
      // ensure that the initial constraints have been already set.
      WidgetsBinding.instance.addPostFrameCallback((final timestamp) {
        _animationController?.initTweens(widget.style);
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
  void didWidgetStateChange(
    final TwWidgetState prevWidgetState,
    final TwWidgetState nextWidgetState,
  ) {
    // Update transitions and tweens
    if (widget.hasTransitions) {
      final animationController = this._animationController;
      if (animationController == null) return;
      final nextStyle = getStyle(nextWidgetState);

      // Compute the new animation curve, with fallback to the default curve
      // if it was set in the [style] property.
      final Curve? nextCurve = nextStyle.transitionTimingFn?.curve ??
          widget.style.transitionTimingFn?.curve;
      if (animationController.curve != nextCurve) {
        animationController.updateAnimationCurve(nextCurve);
      }

      // Compute the new animation duration, with fallback to the default
      // duration if it was set in the [style] property.
      final Duration? nextDuration =
          nextStyle.transitionDuration?.duration.value ??
              widget.style.transitionDuration?.duration.value;
      if (animationController.duration != nextDuration) {
        animationController.updateAnimationDuration(nextDuration);
      }

      animationController
        ..updateTweens(widget.style, nextStyle)
        ..animate(nextStyle.transitionDelay ?? widget.style.transitionDelay);
    }
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }
}
