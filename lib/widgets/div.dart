import 'package:breeze_ui/base.dart';
import 'package:breeze_ui/widgets/inherited/parent_material_states_data.dart';
import 'package:breeze_ui/widgets/state/animated_material_state.dart';
import 'package:breeze_ui/widgets/state/stateful_widget.dart';
import 'package:breeze_ui/widgets/stateless/div.dart';
import 'package:breeze_ui/widgets/style/style.dart';
import 'package:flutter/material.dart';

/// A [Div] widget wrapper with support for Tailwind styled properties
/// and animated property transitions.
///
/// A [TwMaterialStatesGroup] may be used to reuse the same animation controller
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
    super.styleResolver,
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
    super.isDraggable,
    super.isToggled,
    super.isTristate,
    super.enableInputDetectors,
    super.enableFeedback,
    super.canRequestFocus,
    super.autofocus,
    super.includeFocusActions,
    // Input controllers
    super.hitTestBehavior,
    super.statesController,
    super.focusNode,
    super.cursor,
    super.key,
  });

  @override
  State createState() => _TwDiv();
}

class _TwDiv extends TwAnimatedMaterialState<TwDiv>
    with SingleTickerProviderStateMixin {
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

    return conditionallyWrapFocus(
      conditionallyWrapInputDetectors(
        conditionallyWrapOpacity(div, animatedStyle),
      ),
      includeFocusActions: widget.includeFocusActions,
    );
  }

  @override
  TickerProvider getTickerProvider() => this;
}
