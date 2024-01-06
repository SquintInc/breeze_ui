import 'package:flutter/material.dart';
import 'package:tailwind_elements/base.dart';
import 'package:tailwind_elements/widgets/state/animated_material_state.dart';
import 'package:tailwind_elements/widgets/state/stateful_widget.dart';
import 'package:tailwind_elements/widgets/stateless/div.dart';
import 'package:tailwind_elements/widgets/style/style.dart';

/// A [Div] widget wrapper with support for Tailwind styled properties
/// and animated property transitions.
///
/// A [TwAnimationGroup] may be used to reuse the same animation controller
/// for multiple [TwStatefulWidget]s that support animations.
class TwDiv extends TwStatefulWidget {
  // Passthrough [Container] properties
  final Widget? child;
  final AlignmentGeometry? alignment;
  final Clip clipBehavior;
  final Matrix4? transform;
  final AlignmentGeometry? transformAlignment;

  const TwDiv({
    this.child,
    // Passthrough [Container] properties
    this.alignment = Alignment.topLeft,
    this.clipBehavior = Clip.none,
    this.transform,
    this.transformAlignment,
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
    super.onSelected,
    super.onHover,
    super.onDragged,
    super.onFocusChange,
    super.onTap,
    super.onLongPress,
    super.onDoubleTap,
    // Toggleable booleans
    super.isDisabled,
    super.isToggleable,
    super.isToggled,
    super.enableInputDetectors,
    super.enableFeedback,
    super.canRequestFocus,
    super.autofocus,
    // Input controllers
    super.hitTestBehavior,
    super.statesController,
    super.focusNode,
    super.key,
  });

  @override
  State createState() => _TwDiv();
}

class _TwDiv extends TwAnimatedMaterialState<TwDiv> {
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

    if (widget.hasOpacity) {
      current = Opacity(
        opacity: animatedStyle.opacity?.value ?? 1.0,
        child: current,
      );
    }

    // Will wrap the current widget with a [MouseRegion] and [GestureDetector]
    // if [enableInputDetectors] is true.
    current = conditionallyWrapInputDetectors(current);

    // Will wrap the current widget with a [Focus] if [canRequestFocus] is true.
    current = conditionallyWrapFocus(current);

    return current;
  }
}
