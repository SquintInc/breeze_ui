import 'package:flutter/material.dart';
import 'package:tailwind_elements/widgets/style/style.dart';

/// A [StatefulWidget] subclass with support for [MaterialStatesController].
abstract class TwStatefulWidget extends StatefulWidget {
  /// Default style properties for this widget.
  final TwStyle style;

  /// Style override for when the widget is disabled.
  final TwStyle? disabled;

  /// Style override for when the widget is pressed.
  final TwStyle? pressed;

  /// Style override for when the widget is hovered.
  final TwStyle? hovered;

  /// Style override for when the widget is dragged.
  final TwStyle? dragged;

  /// Style override for when the widget is focused (if applicable).
  final TwStyle? focused;

  /// Style override for when the widget is selected (if applicable).
  final TwStyle? selected;

  /// Style override for when the widget has an error (if applicable).
  final TwStyle? errored;

  /// Callback for when the widget is selected (if applicable).
  final ValueChanged<bool>? onSelected;

  /// Callback for when the widget is hovered (if applicable).
  final ValueChanged<bool>? onHover;

  /// Callback for when the widget is dragged (if applicable).
  final ValueChanged<bool>? onDragged;

  /// Callback for when the widget is focused (if applicable).
  final ValueChanged<bool>? onFocusChange;

  /// Callback for when the widget is tapped (if applicable).
  final GestureTapCallback? onTap;

  /// Callback for when the widget is long pressed (if applicable).
  final GestureLongPressCallback? onLongPress;

  /// Callback for when the widget is double tapped (if applicable).
  final GestureTapCallback? onDoubleTap;

  /// An optional [MaterialStatesController] that can be passed down from a
  /// parent widget to create a single shared 'group' of states which applies
  /// the same states to all widgets within this 'group'.
  final MaterialStatesController? statesController;

  /// Whether or not the widget is disabled.
  final bool isDisabled;

  /// Whether or not the widget can be toggle selected.
  final bool isToggleable;

  /// Whether or not the widget can have a drag state.
  final bool isDraggable;

  /// Whether or not the widget is toggle selected; initial toggle value if the widget is toggleable.
  final bool isToggled;

  /// Whether or not the widget should use [GestureDetector] and [MouseRegion] to manage material
  /// state controller values.
  final bool enableInputDetectors;

  /// [HitTestBehavior] for when [GestureDetector] or [MouseRegion] are being used.
  final HitTestBehavior? hitTestBehavior;

  /// Whether or not to enable feedback for this widget.
  final bool enableFeedback;

  /// Whether or not this widget can be focused.
  final bool canRequestFocus;

  /// The [FocusNode] for this widget.
  final FocusNode? focusNode;

  /// Whether or not this widget should request focus when mounted.
  final bool autofocus;

  /// Whether or not to include focus actions for this widget. See [Actions] and [Intent] for more.
  final bool includeFocusActions;

  /// The cursor for this widget used by the [MouseRegion] when [enableInputDetectors] is true.
  final MouseCursor? cursor;

  const TwStatefulWidget({
    this.style = const TwStyle(),
    this.disabled,
    this.pressed,
    this.hovered,
    this.dragged,
    this.focused,
    this.selected,
    this.errored,
    this.onSelected,
    this.onHover,
    this.onDragged,
    this.onFocusChange,
    this.onTap,
    this.onLongPress,
    this.onDoubleTap,
    this.statesController,
    this.hitTestBehavior,
    this.isDisabled = false,
    this.isToggleable = false,
    this.isDraggable = false,
    this.isToggled = false,
    this.enableInputDetectors = false,
    this.enableFeedback = false,
    this.canRequestFocus = false,
    this.focusNode,
    this.autofocus = false,
    this.includeFocusActions = false,
    this.cursor,
    super.key,
  });

  /// Determine upfront if this animation-supported widget has any transitions in any of its
  /// stateful styles.
  bool get hasTransitions =>
      !(style.transition?.isNone ?? true) ||
      !(disabled?.transition?.isNone ?? true) ||
      !(focused?.transition?.isNone ?? true) ||
      !(pressed?.transition?.isNone ?? true) ||
      !(hovered?.transition?.isNone ?? true) ||
      !(dragged?.transition?.isNone ?? true) ||
      !(selected?.transition?.isNone ?? true) ||
      !(errored?.transition?.isNone ?? true);

  /// Determine upfront if this animation-supported widget has any opacity values in any of its
  /// stateful styles.
  bool get hasOpacity =>
      style.opacity != null ||
      disabled?.opacity != null ||
      focused?.opacity != null ||
      pressed?.opacity != null ||
      hovered?.opacity != null ||
      dragged?.opacity != null ||
      selected?.opacity != null ||
      errored?.opacity != null;
}
