import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tailwind_elements/config/options/units/measurement_unit.dart';
import 'package:tailwind_elements/widgets/rendering/input_padding.dart';
import 'package:tailwind_elements/widgets/state/animated_material_state.dart';
import 'package:tailwind_elements/widgets/state/stateful_widget.dart';
import 'package:tailwind_elements/widgets/stateless/div.dart';
import 'package:tailwind_elements/widgets/style/style.dart';

/// A widget meant to represent a [Switch] with custom styling via Tailwind
/// styled properties.
@immutable
class TwSwitch extends TwStatefulWidget {
  static const PxUnit minTapTargetSize = PxUnit(48.0);

  /// Initial value of the switch.
  final bool value;

  /// Called when the internal selected state of the switch changes.
  final ValueChanged<bool>? onToggled;

  /// The tap target size of the switch widget.
  /// Defaults to 48.0 pixels as per Material Design guidelines.
  final CssAbsoluteUnit tapTargetSize;

  /// The thumb widget to use for the switch.
  final Widget thumb;

  const TwSwitch({
    required this.thumb,
    this.onToggled,
    this.value = false,
    this.tapTargetSize = minTapTargetSize,
    // Style properties
    super.style = const TwStyle(),
    super.disabled,
    super.pressed,
    super.hovered,
    super.dragged,
    super.focused,
    super.selected,
    super.errored,
    // Toggleable booleans
    super.isDisabled,
    super.isToggleable = true,
    // Input controllers
    super.statesController,
    super.focusNode,
    super.key,
  }) : super(
          enableInputDetectors: isToggleable,
          enableFeedback: isToggleable,
          canRequestFocus: isToggleable,
          cursor: MaterialStateMouseCursor.clickable,
          onSelected: onToggled,
          isToggled: value,
          isDraggable: true,
        );

  @override
  State createState() => _SwitchTrackState();
}

class _SwitchTrackState extends TwAnimatedMaterialState<TwSwitch>
    with TickerProviderStateMixin {
  /// Internal (linear-time) animation controller for the thumb position
  AnimationController? thumbController;

  /// Current animation curve for the thumb position
  CurvedAnimation? thumbCurve;

  /// Alignment geometry tween
  final AlignmentGeometryTween thumbTween = AlignmentGeometryTween(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  @override
  void onIsSelectedChanged({required final bool isSelected}) {
    super.onIsSelectedChanged(isSelected: isSelected);
    animateThumb(delay, forward: isSelected);
  }

  @override
  void initAnimationController(final TwStyle currentStyle) {
    super.initAnimationController(currentStyle);
    _initThumbController(currentStyle);
  }

  @override
  void updateAnimationControllerData(final TwStyle currentStyle) {
    super.updateAnimationControllerData(currentStyle);
    updateThumbControllerData(currentStyle);
  }

  void updateThumbControllerData(final TwStyle currentStyle) {
    /// Update animation controller curve and duration if the controller exists
    final thumbController = this.thumbController;
    if (thumbController == null) return;

    // Compute new animation curve using current style's transition timing function,
    // with fallback to the default curve.
    final Curve nextCurve = currentStyle.transitionTimingFn?.curve ??
        TwAnimatedMaterialState.defaultCurve;
    this.thumbCurve ??= CurvedAnimation(
      parent: thumbController,
      curve: nextCurve,
    );
    final thumbCurve = this.thumbCurve;
    if (thumbCurve != null && thumbCurve.curve != nextCurve) {
      thumbCurve.curve = nextCurve;
    }

    // Compute new animation duration using current style's transition timing function,
    // with fallback to the default duration.
    final Duration nextDuration =
        currentStyle.transitionDuration?.duration.value ??
            TwAnimatedMaterialState.defaultDuration;
    if (thumbController.duration != nextDuration) {
      thumbController.duration = nextDuration;
    }
  }

  /// Initializes the animation controller and creates a new controller instance only if the widget
  /// has transitions enabled and if the controller has not already been initialized yet.
  void _initThumbController(final TwStyle currentStyle) {
    thumbController ??= AnimationController(
      vsync: this,
      duration: currentStyle.transitionDuration?.duration.value ??
          TwAnimatedMaterialState.defaultDuration,
      debugLabel: kDebugMode ? '${widget.toStringShort()}_thumb' : null,
    )
      ..addListener(handleAnimationControllerUpdate)
      ..value = isSelected ? 1.0 : 0.0;
  }

  void animateThumb(final Duration delay, {required final bool forward}) {
    final thumbController = this.thumbController;
    final thumbCurve = this.thumbCurve;
    if (thumbController != null && thumbCurve != null) {
      thumbController.value = forward ? 0.0 : 1.0;
      if (delay != Duration.zero) {
        Future.delayed(delay, () {
          if (forward) {
            thumbController.forward();
          } else {
            thumbController.reverse();
          }
        });
      } else {
        if (forward) {
          thumbController.forward();
        } else {
          thumbController.reverse();
        }
      }
    }
  }

  AlignmentGeometry? getAnimatedAlignment() {
    final thumbCurve = this.thumbCurve;
    if (thumbCurve != null) {
      return thumbTween.evaluate(thumbCurve);
    }
    return null;
  }

  @override
  void dispose() {
    thumbController?.removeListener(handleAnimationControllerUpdate);
    thumbController?.dispose();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) {
    final currentStyle = getCurrentStyle(currentStates);
    final animatedStyle = currentStyle.merge(getAnimatedStyle());

    final thumb = Align(
      alignment: getAnimatedAlignment() ?? Alignment.centerLeft,
      child: widget.thumb,
    );
    final div = Div(
      style: animatedStyle,
      staticConstraints: currentStyle.toConstraints(),
      parentControlsOpacity: true,
      child: thumb,
    );

    // Input padding needs to be wrapped in Semantics for hit test to be constrained
    return Semantics(
      container: true,
      checked: widget.value,
      enabled: !widget.isDisabled,
      child: InputPadding(
        minSize: Size.square(widget.tapTargetSize.pixels()),
        child: conditionallyWrapFocus(
          conditionallyWrapInputDetectors(
            conditionallyWrapOpacity(div, animatedStyle),
          ),
          includeFocusActions: true,
        ),
      ),
    );
  }

  @override
  TickerProvider getTickerProvider() => this;
}
