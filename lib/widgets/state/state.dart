import 'package:flutter/material.dart';
import 'package:tailwind_elements/widgets/animation/animation_group.dart';
import 'package:tailwind_elements/widgets/state/widget_state.dart';
import 'package:tailwind_elements/widgets/style/style.dart';

/// A [Widget] subclass with support for Tailwind styled properties.
abstract class TwWidget extends StatelessWidget {
  /// Default style properties for this widget.
  final TwStyle style;

  const TwWidget({
    required this.style,
    super.key,
  });
}

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

  /// Callback for when the widget is selected (if applicable).
  final ValueChanged<bool>? onSelected;

  /// Callback for when the widget is hovered (if applicable).
  final ValueChanged<bool>? onHovered;

  /// Callback for when the widget is dragged (if applicable).
  final ValueChanged<bool>? onDragged;

  /// Callback for when the widget is focused (if applicable).
  final ValueChanged<bool>? onFocused;

  /// Callback for when the widget is pressed (if applicable).
  final ValueChanged<bool>? onPressed;

  /// Callback for when the widget is disabled (if applicable).
  final ValueChanged<bool>? onDisabled;

  /// Callback for when the widget has an error (if applicable).
  final ValueChanged<bool>? onErrored;

  /// Style override for when the widget has an error (if applicable).
  /// Corresponds to [TwWidgetState.error].
  final TwStyle? errored;

  /// Whether or not the widget is disabled
  final bool isDisabled;

  /// Whether or not the widget is selectable (toggleable)
  final bool isSelectable;

  /// Whether or not the widget should be wrapped in a [GestureDetector] for
  /// handling material state controller inputs.
  final bool useGestureDetector;

  /// Whether or not the widget should be wrapped in a [MouseRegion] for
  /// handling material state controller inputs.
  final bool useMouseRegion;

  /// An optional material states controller that can be passed down from a
  /// parent widget to create a single shared 'group' of states which applies
  /// the same states to all widgets within this 'group'.
  final MaterialStatesController? statesController;

  final HitTestBehavior? gestureBehavior;

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
    this.useGestureDetector = true,
    this.useMouseRegion = true,
    this.onSelected,
    this.onHovered,
    this.onDragged,
    this.onFocused,
    this.onPressed,
    this.onDisabled,
    this.onErrored,
    this.gestureBehavior,
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

  bool get requiresLayoutBuilder =>
      (style.hasPercentageSize || style.hasPercentageConstraints) ||
      ((disabled?.hasPercentageSize ?? false) ||
          (disabled?.hasPercentageConstraints ?? false)) ||
      ((focused?.hasPercentageSize ?? false) ||
          (focused?.hasPercentageConstraints ?? false)) ||
      ((pressed?.hasPercentageSize ?? false) ||
          (pressed?.hasPercentageConstraints ?? false)) ||
      ((hovered?.hasPercentageSize ?? false) ||
          (hovered?.hasPercentageConstraints ?? false)) ||
      ((dragged?.hasPercentageSize ?? false) ||
          (dragged?.hasPercentageConstraints ?? false)) ||
      ((selected?.hasPercentageSize ?? false) ||
          (selected?.hasPercentageConstraints ?? false)) ||
      ((errored?.hasPercentageSize ?? false) ||
          (errored?.hasPercentageConstraints ?? false));

  bool get hasTypographyStyling =>
      style.hasTypographyProperties ||
      (disabled?.hasTypographyProperties ?? false) ||
      (focused?.hasTypographyProperties ?? false) ||
      (pressed?.hasTypographyProperties ?? false) ||
      (hovered?.hasTypographyProperties ?? false) ||
      (dragged?.hasTypographyProperties ?? false) ||
      (selected?.hasTypographyProperties ?? false) ||
      (errored?.hasTypographyProperties ?? false);
}

enum StatesControllerType {
  passedDown,
  internal,
  inherited,
}

/// A widget [State] subclass with support for [MaterialStatesController] and
/// animated transitions.
abstract class TwState<T extends TwStatefulWidget> extends State<T> {
  /// The internal material states controller for this stateful widget.
  late StatesControllerType statesControllerType;
  MaterialStatesController? internalStatesController;
  MaterialStatesController? animationGroupStatesController;

  /// Current material state for the widget
  late TwWidgetState _widgetState;

  /// Internal selectable toggle state, only used when the widget is selectable
  @protected
  bool isSelected = false;

  /// Gets the current material state for the widget.
  @protected
  TwWidgetState get widgetState => _widgetState;

  /// Gets the current merged style using the widget's current material state.
  @protected
  TwStyle get currentStyle => widget.style.merge(getStyle(_widgetState));

  /// Gets this widget's appropriate states controller based on the
  /// [statesControllerType].
  @protected
  MaterialStatesController get statesController =>
      switch (statesControllerType) {
        StatesControllerType.passedDown => widget.statesController!,
        StatesControllerType.internal => internalStatesController!,
        StatesControllerType.inherited => animationGroupStatesController!,
      };

  /// Gets this widget's style based on the provided widget state.
  /// Returns the default style if no style is set for the current widget state.
  @protected
  TwStyle getStyle(final TwWidgetState widgetState) => switch (widgetState) {
        TwWidgetState.disabled => widget.disabled ?? widget.style,
        TwWidgetState.focused => widget.focused ?? widget.style,
        TwWidgetState.pressed => widget.pressed ?? widget.style,
        TwWidgetState.hovered => widget.hovered ?? widget.style,
        TwWidgetState.dragged =>
          widget.dragged ?? widget.pressed ?? widget.style,
        TwWidgetState.selected => widget.selected ?? widget.style,
        TwWidgetState.error => widget.errored ?? widget.style,
        TwWidgetState.normal => widget.style,
      };

  /// Called when the widget state changes.
  void didWidgetStateChange();

  /// Rebuilds the widget when the material states controller changes.
  void handleStatesControllerChange() {
    final newWidgetState = getPrimaryWidgetState(statesController.value);
    if (newWidgetState != _widgetState) {
      // Rebuild widget and update previous and current state
      setState(() {
        _widgetState = newWidgetState;
      });
      didWidgetStateChange();
    }
  }

  void initStatesController() {
    final AnimationGroupData? animationGroup = AnimationGroupData.of(context);

    // Determine material states controller type
    if (animationGroup != null) {
      statesControllerType = StatesControllerType.inherited;
      animationGroupStatesController = animationGroup.statesController;
    } else if (widget.statesController != null) {
      statesControllerType = StatesControllerType.passedDown;
    } else {
      statesControllerType = StatesControllerType.internal;
      internalStatesController = MaterialStatesController();
    }

    // Set initial widget state in case the states controller being used already
    // has values set.
    statesController
      ..update(MaterialState.disabled, widget.isDisabled)
      ..update(MaterialState.selected, isSelected);
    _widgetState = getPrimaryWidgetState(statesController.value);
    statesController.addListener(handleStatesControllerChange);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    initStatesController();
  }

  @override
  void didUpdateWidget(final T oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.statesController != oldWidget.statesController) {
      oldWidget.statesController?.removeListener(handleStatesControllerChange);
      if (widget.statesController != null) {
        internalStatesController?.dispose();
        internalStatesController = null;
      }
      initStatesController();
    }
    if (widget.isDisabled != oldWidget.isDisabled) {
      statesController.update(MaterialState.disabled, widget.isDisabled);
      if (widget.isDisabled) {
        statesController.update(MaterialState.pressed, false);
      }
    }
  }

  @override
  void dispose() {
    statesController.removeListener(handleStatesControllerChange);
    internalStatesController?.dispose();
    super.dispose();
  }

  /// Manages [MaterialState.pressed] and [MaterialState.dragged] for this
  /// widget.
  Widget _wrapGestureDetector(final Widget child) {
    return GestureDetector(
      behavior: widget.gestureBehavior,
      onPanStart: (final details) {
        if (widget._isDraggable) {
          statesController
            ..update(MaterialState.pressed, false)
            ..update(MaterialState.dragged, true);
          widget.onPressed?.call(false);
          widget.onDragged?.call(true);
        }
      },
      onPanEnd: (final details) {
        if (widget._isDraggable) {
          if (statesController.value.contains(MaterialState.dragged)) {
            statesController.update(MaterialState.dragged, false);
            widget.onDragged?.call(false);
          } else {
            if (!statesController.value.contains(MaterialState.dragged)) {
              statesController.update(MaterialState.dragged, true);
              widget.onDragged?.call(true);
            }
          }
        }
      },
      onTapDown: widget._isPressable
          ? (final details) {
              if (!statesController.value.contains(MaterialState.pressed)) {
                statesController.update(MaterialState.pressed, true);
                widget.onPressed?.call(true);
              }
            }
          : null,
      onTapUp: widget._isPressable || widget.isSelectable
          ? (final details) {
              if (statesController.value.contains(MaterialState.pressed)) {
                statesController.update(MaterialState.pressed, false);
                widget.onPressed?.call(false);
              }
              if (widget.isSelectable) {
                isSelected = !isSelected;
                statesController.update(MaterialState.selected, isSelected);
                widget.onSelected?.call(isSelected);
              }
            }
          : null,
      onLongPressDown: widget._isPressable
          ? (final details) {
              if (!statesController.value.contains(MaterialState.pressed)) {
                statesController.update(MaterialState.pressed, true);
                widget.onPressed?.call(true);
              }
            }
          : null,
      onLongPressUp: widget._isPressable
          ? () {
              if (statesController.value.contains(MaterialState.pressed)) {
                statesController.update(MaterialState.pressed, false);
                widget.onPressed?.call(false);
              }
              if (widget.isSelectable) {
                isSelected = !isSelected;
                statesController.update(MaterialState.selected, isSelected);
                widget.onSelected?.call(isSelected);
              }
            }
          : null,
      child: child,
    );
  }

  /// Manages [MaterialState.hovered] for this widget.
  Widget _wrapMouseRegion(final Widget child) {
    return MouseRegion(
      hitTestBehavior: widget.gestureBehavior,
      onEnter: (final details) {
        if (!statesController.value.contains(MaterialState.hovered)) {
          statesController.update(MaterialState.hovered, true);
        }
      },
      onExit: (final details) {
        if (statesController.value.contains(MaterialState.hovered)) {
          statesController.update(MaterialState.hovered, false);
        }
      },
      child: child,
    );
  }

  @protected
  Widget buildForState(
    final BuildContext context,
  );

  @override
  Widget build(final BuildContext context) {
    final animationGroup = AnimationGroupData.of(context);
    Widget builtWidget = buildForState(context);

    final bool isAnimationGroupImmediateChild =
        animationGroup != null && identical(animationGroup.child, widget);
    final bool canWrap =
        isAnimationGroupImmediateChild || internalStatesController != null;

    // Wrap widget in gesture detector only if the widget is pressable,
    // draggable, or selectable.
    if (widget.useGestureDetector && widget.requireGestureDetector && canWrap) {
      builtWidget = _wrapGestureDetector(builtWidget);
    }

    // Wrap widget in mouse region only if the widget is hoverable or draggable.
    if (widget.useMouseRegion && widget.requireMouseRegion && canWrap) {
      builtWidget = _wrapMouseRegion(builtWidget);
    }

    return builtWidget;
  }
}
