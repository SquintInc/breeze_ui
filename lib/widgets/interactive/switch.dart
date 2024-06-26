import 'package:breeze_ui/config/options/units/measurement_unit.dart';
import 'package:breeze_ui/widgets/rendering/input_padding.dart';
import 'package:breeze_ui/widgets/state/animated_material_state.dart';
import 'package:breeze_ui/widgets/state/stateful_widget.dart';
import 'package:breeze_ui/widgets/stateless/div.dart';
import 'package:breeze_ui/widgets/style/style.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// A Switch widget with support for Tailwind styled properties. This widget allows animating the
/// alignment of the thumb, but does not support sharing material states with the thumb itself.
///
/// Consider wrapping a [TwSwitch] in a [TwMaterialStatesGroup] to allow the track and the thumb
/// to respond to the same material states values and have different styling applied.
@immutable
class TwSwitch extends TwStatefulWidget {
  static const PxUnit minTapTargetSize = PxUnit(48.0);

  /// Initial value of the switch.
  final bool value;

  /// Called when the internal selected state of the switch changes.
  final ValueChanged<bool?>? onToggled;

  /// The tap target size of the switch widget.
  /// Defaults to 48.0 pixels as per Material Design guidelines.
  final CssAbsoluteUnit tapTargetSize;

  /// The thumb widget to use for the switch.
  final Widget thumb;

  const TwSwitch({
    required this.thumb,
    this.tapTargetSize = minTapTargetSize,
    this.onToggled,
    this.value = false,
    // Style properties
    super.style = const TwStyle(),
    super.disabled,
    super.pressed,
    super.hovered,
    super.dragged,
    super.focused,
    super.selected,
    super.errored,
    super.styleResolver,
    // Toggleable booleans
    super.isDisabled = false,
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
  void onIsSelectedChanged({required final bool? isSelected}) {
    super.onIsSelectedChanged(isSelected: isSelected);
    animateThumb(delay, forward: isSelected ?? false);
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
      ..value = (isSelected ?? false) ? 1.0 : 0.0;
  }

  /// Animates the thumb in the corresponding direction, with an optional delay.
  void animateThumb(final Duration delay, {required final bool forward}) {
    final thumbController = this.thumbController;
    final thumbCurve = this.thumbCurve;
    if (!(thumbController != null && thumbCurve != null && mounted)) {
      return;
    }

    // Don't animate if the thumb is already in the desired position
    if (thumbController.value == (forward ? 1.0 : 0.0)) {
      return;
    }

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
    disposeController();
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
    final div = TwDiv(
      style: animatedStyle,
      staticConstraints: currentStyle.toConstraints(),
      parentControlsOpacity: true,
      alwaysIncludeFilters: widget.hasFilters,
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
