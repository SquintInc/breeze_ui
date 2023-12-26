import 'package:flutter/material.dart';
import 'package:tailwind_elements/widgets/state/widget_state.dart';
import 'package:tailwind_elements/widgets/style.dart';

/// A [StatefulWidget] subclass with support for [MaterialStatesController].
abstract class TwStatefulWidget extends StatefulWidget {
  /// Default style properties for this widget.
  /// Corresponds to [TwWidgetState.normal].
  final TwStyle style;

  /// Style override for when the widget is disabled.
  /// Corresponds to [TwWidgetState.disabled].
  final TwStyle? disabled;

  /// Style override for when the widget is pressed
  /// Corresponds to [TwWidgetState.pressed].
  final TwStyle? pressed;

  /// Style override for when the widget is hovered
  /// Corresponds to [TwWidgetState.hovered].
  final TwStyle? hovered;

  /// Style override for when the widget is dragged
  /// Corresponds to [TwWidgetState.dragged].
  final TwStyle? dragged;

  /// Style override for when the widget is focused (if applicable).
  /// Corresponds to [TwWidgetState.focused].
  final TwStyle? focused;

  /// Style override for when the widget is selected (if applicable).
  /// Corresponds to [TwWidgetState.selected].
  final TwStyle? selected;

  /// Style override for when the widget has an error (if applicable).
  /// Corresponds to [TwWidgetState.error].
  final TwStyle? errored;

  /// Whether or not the widget is disabled
  final bool isDisabled;

  /// Whether or not the widget is selectable (toggleable)
  final bool isSelectable;

  /// An optional material states controller that can be passed down from a
  /// parent widget to create a single shared 'group' of states which applies
  /// the same states to all widgets within this 'group'.
  final MaterialStatesController? statesController;

  bool get _isHoverable => hovered != null;

  bool get _isPressable => pressed != null;

  bool get _isDraggable => dragged != null;

  const TwStatefulWidget({
    required this.style,
    this.disabled,
    this.pressed,
    this.hovered,
    this.dragged,
    this.focused,
    this.selected,
    this.errored,
    this.isDisabled = false,
    this.isSelectable = false,
    this.statesController,
    super.key,
  });

  bool get requireGestureDetector =>
      _isPressable || _isDraggable || isSelectable;

  bool get requireMouseRegion => _isHoverable || _isDraggable;

  bool get hasTransitions =>
      !(style.transition?.isNone ?? true) ||
      !(disabled?.transition?.isNone ?? true) ||
      !(focused?.transition?.isNone ?? true) ||
      !(pressed?.transition?.isNone ?? true) ||
      !(hovered?.transition?.isNone ?? true) ||
      !(dragged?.transition?.isNone ?? true) ||
      !(selected?.transition?.isNone ?? true) ||
      !(errored?.transition?.isNone ?? true);

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

/// A widget [State] subclass with support for [MaterialStatesController] and
/// animated transitions.
abstract class TwState<T extends TwStatefulWidget> extends State<T> {
  /// The internal material states controller for this stateful widget.
  late MaterialStatesController? _statesController;
  TwWidgetState _widgetState = TwWidgetState.normal;
  TwWidgetState _prevWidgetState = TwWidgetState.normal;

  // Internal selectable toggle state
  bool _isSelected = false;

  @protected
  TwWidgetState get widgetState => _widgetState;

  @protected
  TwWidgetState get prevWidgetState => _prevWidgetState;

  /// Gets this widget's material states controller if it exists, otherwise uses
  /// the internal states controller from [_statesController].
  @protected
  MaterialStatesController get statesController =>
      widget.statesController ?? _statesController!;

  /// Gets this widget's style based on the provided widget state.
  @protected
  TwStyle? getStyle(final TwWidgetState widgetState) => switch (widgetState) {
        TwWidgetState.disabled => widget.disabled,
        TwWidgetState.focused => widget.focused,
        TwWidgetState.pressed => widget.pressed,
        TwWidgetState.hovered => widget.hovered,
        TwWidgetState.dragged => widget.dragged ?? widget.pressed,
        TwWidgetState.selected => widget.selected,
        TwWidgetState.error => widget.errored,
        TwWidgetState.normal => widget.style,
      };

  /// Rebuilds the widget when the material states controller changes.
  void onWidgetStateChange() {
    final newWidgetState = getPrimaryWidgetState(statesController.value);
    if (newWidgetState != _widgetState) {
      // Rebuild widget and update previous and current state
      final prevWidgetState = _widgetState;
      setState(() {
        _prevWidgetState = prevWidgetState;
        _widgetState = newWidgetState;
      });
      didWidgetStateChange(prevWidgetState, newWidgetState);
    }
  }

  /// Called when the widget state changes.
  void didWidgetStateChange(
    final TwWidgetState prevWidgetState,
    final TwWidgetState nextWidgetState,
  );

  void _initMaterialStatesController() {
    if (widget.statesController == null) {
      _statesController = MaterialStatesController();
    }
    statesController.addListener(onWidgetStateChange);
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

  @protected
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
        if (widget._isDraggable) {
          statesController
            ..update(MaterialState.pressed, false)
            ..update(MaterialState.dragged, true);
        }
      },
      onPanEnd: (final details) {
        if (widget._isDraggable) {
          statesController.update(MaterialState.dragged, false);
        } else {
          statesController.update(MaterialState.pressed, false);
        }
      },
      onTapDown: widget._isPressable
          ? (final details) {
              statesController.update(MaterialState.pressed, true);
            }
          : null,
      onTapUp: widget._isPressable || widget.isSelectable
          ? (final details) {
              statesController.update(MaterialState.pressed, false);
              if (widget.isSelectable) {
                _isSelected = !_isSelected;
                statesController.update(MaterialState.selected, _isSelected);
              }
            }
          : null,
      onLongPressDown: widget._isPressable
          ? (final details) {
              statesController.update(MaterialState.pressed, true);
            }
          : null,
      onLongPressUp: widget._isPressable
          ? () {
              statesController.update(MaterialState.pressed, false);
              if (widget.isSelectable) {
                _isSelected = !_isSelected;
                statesController.update(MaterialState.selected, _isSelected);
              }
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
      _widgetState,
    );

    // Wrap widget in gesture detector only if the widget is pressable,
    // draggable, or selectable.
    if (widget.requireGestureDetector) {
      builtWidget = _wrapGestureDetector(builtWidget);
    }

    // Wrap widget in mouse region only if the widget is hoverable or draggable.
    if (widget.requireMouseRegion) {
      builtWidget = _wrapMouseRegion(builtWidget);
    }

    return builtWidget;
  }
}
