import 'package:flutter/material.dart';
import 'package:tailwind_elements/widgets/state/animated_material_state.dart';
import 'package:tailwind_elements/widgets/state/stateful_widget.dart';
import 'package:tailwind_elements/widgets/stateless/div.dart';
import 'package:tailwind_elements/widgets/style/style.dart';

/// A [TextButton] widget wrapper with support for Tailwind styled properties.
///
/// See the [build] method for more details about the implementation choice.
@immutable
class TwButton extends TwStatefulWidget {
  // Pass-through properties for [TextButton]
  final Widget? child;
  final Clip clipBehavior;
  final bool isSemanticButton;
  final Matrix4? transform;
  final AlignmentGeometry? transformAlignment;
  final AlignmentGeometry alignment;

  const TwButton({
    required final GestureTapCallback onPressed,
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

class _TwButtonState extends TwAnimatedMaterialState<TwButton> {
  /// Wrap the button by extending [TwStatefulWidget] and using a [Div] for simplicity of applying
  /// styles with support for animated transitions.
  @override
  Widget build(final BuildContext context) {
    final currentStyle = getCurrentStyle();
    final animatedStyle = currentStyle.merge(getAnimatedStyle());

    final div = Div(
      key: widget.key,
      style: animatedStyle,
      staticConstraints: currentStyle.toConstraints(),
      alignment: widget.alignment,
      clipBehavior: widget.clipBehavior,
      transform: widget.transform,
      transformAlignment: widget.transformAlignment,
      child: widget.child,
    );

    Widget current = div;
    current = conditionallyWrapOpacity(current, animatedStyle);
    current = conditionallyWrapInputDetectors(current);
    current = conditionallyWrapFocus(current, includeFocusActions: true);
    return current;
  }
}
