import 'package:flutter/material.dart';
import 'package:tailwind_elements/base.dart';
import 'package:tailwind_elements/widgets/state/animated_material_state.dart';
import 'package:tailwind_elements/widgets/state/stateful_widget.dart';
import 'package:tailwind_elements/widgets/stateless/div.dart';
import 'package:tailwind_elements/widgets/style/style.dart';

/// A [Div] widget wrapper with support for styling different states.
class AnimatedDiv extends TwStatefulWidget {
  // Passthrough [Container] properties
  final Widget? child;
  final AlignmentGeometry? alignment;
  final Clip clipBehavior;
  final Matrix4? transform;
  final AlignmentGeometry? transformAlignment;

  const AnimatedDiv({
    this.child,
    this.alignment = Alignment.topLeft,
    this.clipBehavior = Clip.none,
    this.transform,
    this.transformAlignment,
    super.style = const TwStyle(),
    super.disabled,
    super.pressed,
    super.hovered,
    super.dragged,
    super.focused,
    super.selected,
    super.errored,
    super.onSelected,
    super.onHover,
    super.onDragged,
    super.onFocused,
    super.onTap,
    super.onLongPress,
    super.onDoubleTap,
    super.statesController,
    super.hitTestBehavior,
    super.isDisabled,
    super.isToggleable,
    super.isToggled,
    super.useInputDetectors,
    super.enableFeedback,
    super.key,
  });

  @override
  State createState() => _AnimatedDiv();
}

class _AnimatedDiv extends TwAnimatedMaterialState<AnimatedDiv> {
  @override
  Widget build(final BuildContext context) {
    final animatedStyle = getAnimatedStyle();

    final div = Div(
      style: animatedStyle,
      alignment: widget.alignment,
      clipBehavior: widget.clipBehavior,
      transform: widget.transform,
      transformAlignment: widget.transformAlignment,
      child: widget.child,
    );

    Widget current = div;

    if (widget.hasOpacity) {
      current = Opacity(
        opacity: animatedStyle.opacity?.value ?? 1.0,
        child: current,
      );
    }

    if (widget.hasTransitions) {
      // TODO: Implement animated transitions
    }

    current = conditionallyWrapInputDetectors(current);

    return current;
  }
}
