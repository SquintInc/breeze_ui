import 'package:flutter/material.dart';
import 'package:tailwind_elements/widgets/animation/animation_group.dart';
import 'package:tailwind_elements/widgets/stateless/div.dart';
import 'package:tailwind_elements/widgets/style/style.dart';

enum MaterialStatesControllerType {
  passedDown,
  internal,
  inherited,
}

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
  final ValueChanged<bool>? onFocused;

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

  /// Whether or not the widget is toggle selected; initial toggle value if the widget is toggleable.
  final bool isToggled;

  /// Whether or not the widget should use [GestureDetector] and [MouseRegion] to manage material
  /// state controller values.
  final bool useInputDetectors;

  /// [HitTestBehavior] for when [GestureDetector] or [MouseRegion] are being used.
  final HitTestBehavior? hitTestBehavior;

  /// Whether or not to enable feedback for this widget.
  final bool enableFeedback;

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
    this.onFocused,
    this.onTap,
    this.onLongPress,
    this.onDoubleTap,
    this.statesController,
    this.hitTestBehavior,
    this.isDisabled = false,
    this.isToggleable = false,
    this.isToggled = false,
    this.useInputDetectors = false,
    this.enableFeedback = false,
    super.key,
  });

  /// Statically determine if this animation-supported widget has any transitions in any of its
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

  /// Statically determine if this animation-supported widget has any opacity values in any of its
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

abstract class TwMaterialState<T extends TwStatefulWidget> extends State<T> {
  /// The internal material states controller for this stateful widget.
  late MaterialStatesControllerType _statesControllerType;

  /// This value will be set if [_statesControllerType] is [MaterialStatesControllerType.internal].
  MaterialStatesController? _internalStatesController;

  /// This value will be set if [_statesControllerType] is [MaterialStatesControllerType.inherited].
  MaterialStatesController? _animationGroupStatesController;

  MaterialStatesController get _statesController =>
      switch (_statesControllerType) {
        MaterialStatesControllerType.passedDown => widget.statesController!,
        MaterialStatesControllerType.internal => _internalStatesController!,
        MaterialStatesControllerType.inherited =>
          _animationGroupStatesController!,
      };

  Set<MaterialState> get currentStates => _statesController.value;

  /// If the widget is selectable, this keeps track of the widget's selection / toggle state.
  bool _isSelected = false;

  @override
  void initState() {
    super.initState();
    // Track initial toggle selection state from the value passed to the widget
    _isSelected = widget.isToggled;
  }

  /// Rebuilds the widget when the material states controller changes.
  void handleStatesControllerChange() {
    setState(() {});
  }

  void initStatesController() {
    final AnimationGroupData? animationGroup = AnimationGroupData.of(context);

    // Determine material states controller type
    if (animationGroup != null) {
      _statesControllerType = MaterialStatesControllerType.inherited;
      _animationGroupStatesController = animationGroup.statesController;
    } else if (widget.statesController != null) {
      _statesControllerType = MaterialStatesControllerType.passedDown;
    } else {
      _statesControllerType = MaterialStatesControllerType.internal;
      _internalStatesController = MaterialStatesController();
    }

    // Set initial widget state in case the states controller being used already
    // has values set.
    _statesController
      ..update(MaterialState.disabled, widget.isDisabled)
      ..update(MaterialState.selected, _isSelected)
      ..addListener(handleStatesControllerChange);
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
      // Dispose old states controller and re-init a new one
      oldWidget.statesController?.removeListener(handleStatesControllerChange);
      if (widget.statesController != null) {
        _internalStatesController?.dispose();
        _internalStatesController = null;
      }
      initStatesController();
    }
    if (widget.isDisabled != oldWidget.isDisabled) {
      _statesController.update(MaterialState.disabled, widget.isDisabled);
      // Remove pressed state if applicable, if the widget is now disabled
      if (widget.isDisabled) {
        _statesController.update(MaterialState.pressed, false);
      }
    }
    if (widget.isToggled != oldWidget.isToggled) {
      _isSelected = widget.isToggled;
      _statesController.update(MaterialState.selected, _isSelected);
    }
  }

  @override
  void dispose() {
    _statesController.removeListener(handleStatesControllerChange);
    _internalStatesController?.dispose();
    super.dispose();
  }

  @protected
  TwStyle getCurrentStyle() {
    final states = currentStates;
    if (states.contains(MaterialState.disabled)) {
      return widget.disabled ?? widget.style;
    }
    if (states.contains(MaterialState.dragged)) {
      return widget.dragged ?? widget.pressed ?? widget.style;
    }
    if (states.contains(MaterialState.error)) {
      return widget.errored ?? widget.style;
    }
    if (states.contains(MaterialState.focused)) {
      return widget.focused ?? widget.style;
    }
    if (states.contains(MaterialState.pressed)) {
      return widget.pressed ?? widget.style;
    }
    if (states.contains(MaterialState.selected)) {
      return widget.selected ?? widget.style;
    }
    if (states.contains(MaterialState.hovered)) {
      return widget.hovered ?? widget.style;
    }
    return widget.style;
  }

  Widget _wrapMouseRegion(final Widget child) {
    return MouseRegion(
      onEnter: (final event) {
        _statesController.update(MaterialState.hovered, true);
        widget.onHover?.call(true);
      },
      onExit: (final event) {
        _statesController.update(MaterialState.hovered, false);
        widget.onHover?.call(false);
      },
      child: child,
    );
  }

  Widget _wrapGestureDetector(final Widget child) {
    return GestureDetector(
      excludeFromSemantics: true,
      behavior: widget.hitTestBehavior,
      onPanStart: (final DragStartDetails details) {
        if (widget.dragged != null) {
          _statesController.update(MaterialState.dragged, true);
          widget.onDragged?.call(true);
        }
      },
      onPanEnd: (final DragEndDetails details) {
        _statesController.update(MaterialState.pressed, false);
        if (widget.dragged != null) {
          _statesController.update(MaterialState.dragged, false);
          widget.onDragged?.call(false);
        }
      },
      onPanCancel: () {
        _statesController.update(MaterialState.pressed, false);
        if (widget.dragged != null) {
          _statesController.update(MaterialState.dragged, false);
          widget.onDragged?.call(false);
        }
      },
      onPanDown: (final DragDownDetails details) {
        _statesController.update(MaterialState.pressed, true);
      },
      onTap: () {
        if (widget.isToggleable) {
          _isSelected = !_isSelected;
          _statesController.update(MaterialState.selected, _isSelected);
          widget.onSelected?.call(_isSelected);
        }
        widget.onTap?.call();
      },
      onLongPress: widget.onLongPress,
      onDoubleTap: widget.onDoubleTap,
      child: child,
    );
  }
}

class _AnimatedDiv extends TwMaterialState<AnimatedDiv> {
  @override
  Widget build(final BuildContext context) {
    final currentStyle = getCurrentStyle();
    final mergedStyle = widget.style.merge(currentStyle);

    final animatedStyle = mergedStyle;

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

    if (widget.useInputDetectors) {
      current = _wrapMouseRegion(_wrapGestureDetector(current));
    }

    return current;
  }
}
