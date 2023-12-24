import 'dart:async';

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:tailwind_elements/widgets/style.dart';

enum TwWidgetState {
  disabled,
  dragged,
  error,
  focused,
  selected,
  pressed,
  hovered,
  normal,
}

TwWidgetState getWidgetState(final Set<MaterialState> states) {
  if (states.contains(MaterialState.disabled)) return TwWidgetState.disabled;
  if (states.contains(MaterialState.dragged)) return TwWidgetState.dragged;
  if (states.contains(MaterialState.error)) return TwWidgetState.error;
  if (states.contains(MaterialState.focused)) return TwWidgetState.focused;
  if (states.contains(MaterialState.selected)) return TwWidgetState.selected;
  if (states.contains(MaterialState.pressed)) return TwWidgetState.pressed;
  if (states.contains(MaterialState.hovered)) return TwWidgetState.hovered;
  return TwWidgetState.normal;
}

/// A [StatefulWidget] subclass with support for [MaterialStatesController].
abstract class TwStatefulWidget extends StatefulWidget {
  /// Default style properties for this widget
  final TwStyle style;

  /// Style override for when the widget is disabled
  final TwStyle? disabled;

  /// Style override for when the widget is focused
  final TwStyle? focused;

  /// Style override for when the widget is pressed
  final TwStyle? pressed;

  /// Style override for when the widget is hovered
  final TwStyle? hovered;

  /// Style override for when the widget is dragged
  final TwStyle? dragged;

  /// Whether or not the widget is disabled
  final bool isDisabled;

  /// An optional material states controller that can be passed down from a
  /// parent widget to create a single shared 'group' of states which applies
  /// the same states to all widgets within this 'group'.
  final MaterialStatesController? statesController;

  bool get isHoverable => hovered != null;

  bool get isPressable => pressed != null;

  bool get isDraggable => dragged != null;

  bool get isFocusable => focused != null;

  const TwStatefulWidget({
    required this.style,
    this.disabled,
    this.focused,
    this.pressed,
    this.hovered,
    this.dragged,
    this.isDisabled = false,
    this.statesController,
    super.key,
  });

  bool get requireGestureDetector => isPressable || isDraggable;

  bool get requireMouseRegion => isHoverable || isDraggable;

  bool get hasTransitions =>
      !(style.transition?.isNone ?? true) ||
      !(disabled?.transition?.isNone ?? true) ||
      !(focused?.transition?.isNone ?? true) ||
      !(pressed?.transition?.isNone ?? true) ||
      !(hovered?.transition?.isNone ?? true) ||
      !(dragged?.transition?.isNone ?? true);
}

/// A widget [State] subclass with support for [MaterialStatesController].
abstract class TwState<T extends TwStatefulWidget> extends State<T> {
  /// The internal states controller for this stateful widget.
  late MaterialStatesController? _statesController;
  TwWidgetState widgetState = TwWidgetState.normal;
  TwWidgetState prevWidgetState = TwWidgetState.normal;

  /// Gets this widget's material states controller if it exists, otherwise uses
  /// the internal states controller from [_statesController].
  MaterialStatesController get statesController =>
      widget.statesController ?? _statesController!;

  /// Gets this widget's current style based on the current widget state.
  TwStyle get currentStyle => switch (widgetState) {
        TwWidgetState.disabled => widget.disabled ?? widget.style,
        TwWidgetState.focused => widget.focused ?? widget.style,
        TwWidgetState.pressed => widget.pressed ?? widget.style,
        TwWidgetState.hovered => widget.hovered ?? widget.style,
        TwWidgetState.dragged =>
          widget.dragged ?? widget.pressed ?? widget.style,
        _ => widget.style,
      };

  /// Gets this widget's previous style based on the previous widget state.
  TwStyle get prevStyle => switch (prevWidgetState) {
        TwWidgetState.disabled => widget.disabled ?? widget.style,
        TwWidgetState.focused => widget.focused ?? widget.style,
        TwWidgetState.pressed => widget.pressed ?? widget.style,
        TwWidgetState.hovered => widget.hovered ?? widget.style,
        TwWidgetState.dragged =>
          widget.dragged ?? widget.pressed ?? widget.style,
        _ => widget.style,
      };

  /// Rebuilds the widget when the material states controller changes.
  void onWidgetStateChange() {
    scheduleMicrotask(() {
      final newWidgetState = getWidgetState(statesController.value);
      if (newWidgetState != widgetState) {
        setState(() {
          prevWidgetState = widgetState;
          widgetState = newWidgetState;
        });
        WidgetsBinding.instance.addPostFrameCallback((final timestamp) {
          didWidgetStateChange();
        });
      }
    });
  }

  @mustBeOverridden
  void didWidgetStateChange();

  void _initMaterialStatesController() {
    if (widget.statesController == null) {
      _statesController = MaterialStatesController();
    }

    // WidgetsBinding.instance.addPostFrameCallback((final timestamp) {
    statesController.addListener(onWidgetStateChange);
    // });
  }

  @override
  void initState() {
    _initMaterialStatesController();
    super.initState();
  }

  @override
  void dispose() {
    statesController
      ..removeListener(onWidgetStateChange)
      ..dispose();
    super.dispose();
  }

  @mustBeOverridden
  Widget buildForState(
    final BuildContext context,
    final MaterialStatesController controller,
    final TwWidgetState state,
  );

  /// Manages [MaterialState.pressed] and [MaterialState.dragged] for this
  /// widget.
  Widget _wrapGestureDetector(final Widget child) {
    return GestureDetector(
      onPanStart: (final details) {
        if (widget.isDraggable) {
          statesController
            ..update(MaterialState.pressed, false)
            ..update(MaterialState.dragged, true);
        }
      },
      onPanEnd: (final details) {
        if (widget.isDraggable) {
          statesController.update(MaterialState.dragged, false);
        } else {
          statesController.update(MaterialState.pressed, false);
        }
      },
      onTapDown: widget.isPressable
          ? (final details) {
              statesController.update(MaterialState.pressed, true);
            }
          : null,
      onTapUp: widget.isPressable
          ? (final details) {
              statesController.update(MaterialState.pressed, false);
            }
          : null,
      onLongPressDown: widget.isPressable
          ? (final details) {
              statesController.update(MaterialState.pressed, true);
            }
          : null,
      onLongPressUp: widget.isPressable
          ? () {
              statesController.update(MaterialState.pressed, false);
            }
          : null,
      child: child,
    );
  }

  /// Manages [MaterialState.hovered] for this widget.
  Widget _wrapMouseRegion(final Widget child) {
    return MouseRegion(
      hitTestBehavior: HitTestBehavior.translucent,
      onEnter: (final details) {
        statesController.update(MaterialState.hovered, true);
      },
      onExit: (final details) {
        statesController.update(MaterialState.hovered, false);
      },
      child: child,
    );
  }

  @override
  Widget build(final BuildContext context) {
    Widget builtWidget = buildForState(
      context,
      statesController,
      widgetState,
    );

    if (widget.requireGestureDetector) {
      builtWidget = _wrapGestureDetector(builtWidget);
    }
    if (widget.requireMouseRegion) {
      builtWidget = _wrapMouseRegion(builtWidget);
    }
    return builtWidget;
  }
}
