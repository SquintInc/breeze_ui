import 'package:flutter/material.dart';
import 'package:tailwind_elements/config/options/units/measurement_unit.dart';
import 'package:tailwind_elements/widgets/rendering/input_padding.dart';
import 'package:tailwind_elements/widgets/state/animated_material_state.dart';
import 'package:tailwind_elements/widgets/state/stateful_widget.dart';
import 'package:tailwind_elements/widgets/stateless/div.dart';
import 'package:tailwind_elements/widgets/style/style.dart';

/// A Button widget with support for Tailwind styled properties.
@immutable
class TwButton extends TwStatefulWidget {
  static const PxUnit minTapTargetSize = PxUnit(48.0);

  // Pass-through properties for [TextButton]
  final Widget? child;
  final Clip clipBehavior;
  final bool isSemanticButton;
  final Matrix4? transform;
  final AlignmentGeometry? transformAlignment;
  final AlignmentGeometry alignment;

  /// The tap target size of the button widget.
  /// Defaults to 48.0 pixels as per Material Design guidelines.
  final CssAbsoluteUnit tapTargetSize;

  const TwButton({
    required final GestureTapCallback onPressed,
    this.tapTargetSize = minTapTargetSize,
    // Passthrough [TextButton] properties
    this.child,
    this.clipBehavior = Clip.none,
    this.isSemanticButton = true,
    this.transform,
    this.transformAlignment,
    this.alignment = Alignment.center,
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
    // Callbacks
    super.onDoubleTap,
    super.onLongPress,
    super.onHover,
    super.onFocusChange,
    // Toggleable booleans
    super.isDisabled,
    // Input controllers,
    super.statesController,
    super.focusNode,
    super.hitTestBehavior,
    super.key,
  }) : super(
          onTap: onPressed,
          enableFeedback: true,
          enableInputDetectors: true,
          canRequestFocus: true,
          cursor: MaterialStateMouseCursor.clickable,
        );

  @override
  State createState() => _TwButtonState();

  bool get enabled =>
      onTap != null || onLongPress != null || onDoubleTap != null;
}

class _TwButtonState extends TwAnimatedMaterialState<TwButton>
    with SingleTickerProviderStateMixin {
  /// Wrap the button by extending [TwStatefulWidget] and using a [Div] for simplicity of applying
  /// styles with support for animated transitions.
  @override
  Widget build(final BuildContext context) {
    final currentStyle = getCurrentStyle(currentStates);
    final animatedStyle = currentStyle.merge(getAnimatedStyle());

    final div = Div(
      style: animatedStyle,
      staticConstraints: currentStyle.toConstraints(),
      parentControlsOpacity: true,
      alignment: widget.alignment,
      clipBehavior: widget.clipBehavior,
      transform: widget.transform,
      transformAlignment: widget.transformAlignment,
      alwaysIncludeFilters: widget.hasFilters,
      child: widget.child,
    );

    // Input padding needs to be wrapped in Semantics for hit test to be constrained
    return Semantics(
      container: true,
      button: true,
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
