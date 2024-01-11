import 'package:flutter/material.dart';
import 'package:tailwind_elements/widgets/inherited/parent_material_states_data.dart';
import 'package:tailwind_elements/widgets/state/stateful_widget.dart';
import 'package:tailwind_elements/widgets/style/style.dart';

enum MaterialStatesControllerType {
  passedDown,
  internal,
  inherited,
}

/// A [State] subclass with support for [MaterialStatesController] to keep track of gesture and
/// pointer events. By reading the [currentStates] set, this allows a [TwStatefulWidget] to
/// determine which style to use.
abstract class TwMaterialState<T extends TwStatefulWidget> extends State<T> {
  /// The internal material states controller for this stateful widget.
  late MaterialStatesControllerType _statesControllerType;

  /// This value will be set if [statesControllerType] is [MaterialStatesControllerType.internal].
  MaterialStatesController? _internalStatesController;

  /// This value will be set if [statesControllerType] is [MaterialStatesControllerType.inherited]
  /// and if a [ParentMaterialStatesData] is found.
  ParentMaterialStatesData? _parentStates;

  /// Getter for [_statesControllerType].
  MaterialStatesControllerType get statesControllerType =>
      _statesControllerType;

  /// Gets the correct states controller based on the [statesControllerType]
  MaterialStatesController get statesController =>
      switch (statesControllerType) {
        MaterialStatesControllerType.passedDown => widget.statesController!,
        MaterialStatesControllerType.internal => _internalStatesController!,
        MaterialStatesControllerType.inherited => _parentStates!.controller,
      };

  /// Getter for [_parentStates].
  ParentMaterialStatesData? get parentStates => _parentStates;

  /// Returns the material state controller's current states.
  /// Returns the current states from the [ParentMaterialStatesData] if it exists,
  /// otherwise returns the [statesController] state values which depends on the
  /// [statesControllerType].
  Set<MaterialState> get currentStates =>
      parentStates != null ? parentStates!.states : statesController.value;

  /// The internal focus node for this stateful widget.
  late FocusNode? _focusNode;

  /// Getter for the widget's focus node, or the internal [_focusNode] if the widget's focus node
  /// is null.
  FocusNode? get focusNode => widget.focusNode ?? _focusNode;

  /// If the widget is selectable, this keeps track of the widget's selection / toggle state upon
  /// widget initialization.
  bool? _isSelected = false;

  /// If the widget is selectable and tristate is enabled, this keeps track of the widget's
  /// previous value.
  bool? _previousSelected = false;

  /// This keeps track of the widget's disabled state upon widget initialization.
  bool _isDisabled = false;

  /// Getter for [_isSelected].
  bool? get isSelected => _isSelected;

  /// Getter for [_previousSelected].
  bool? get previousSelected => _previousSelected;

  /// Getter for [_isDisabled].
  bool get isDisabled => _isDisabled;

  @override
  void initState() {
    super.initState();
    // Track initial toggle selection state from the value passed to the widget
    _isSelected = widget.isToggled;
    _previousSelected = widget.isToggled;

    // Track initial disabled state from the value passed to the widget
    _isDisabled = widget.isDisabled;

    // Create a new focus node if one wasn't passed to the widget
    if (widget.focusNode == null) {
      _focusNode = FocusNode();
    }
  }

  /// Called when the set of [MaterialState]s stored by the [statesController]
  /// changes.
  void handleStatesControllerChange() {
    if (mounted) {
      setState(() {});
    }
  }

  /// Updates the [statesController] values to match the widget's initial state.
  /// This should only be called after [initState] is called.
  void _updateInitialControllerStates() {
    statesController
      ..update(MaterialState.disabled, isDisabled)
      ..update(MaterialState.selected, isSelected ?? false);
  }

  /// Initializes the [statesController] based on the [statesControllerType].
  ///
  /// Attempts to read the [ParentMaterialStatesData] from the widget tree, and if it exists, uses
  /// the [ParentMaterialStatesData.controller] as the [MaterialStatesControllerType.inherited]
  /// [statesController] for this widget.
  ///
  /// Then, if the [TwStatefulWidget.statesController] is not null, it will be used as the
  /// [MaterialStatesControllerType.passedDown] [statesController] for this widget.
  ///
  /// Otherwise, a new internal [MaterialStatesController] will be created and used as the
  /// [MaterialStatesControllerType.internal] [statesController] for this widget.
  void initStatesController() {
    final ParentMaterialStatesData? parentStates =
        ParentMaterialStatesData.of(context);
    if (parentStates != null) {
      _parentStates = parentStates;
      _statesControllerType = MaterialStatesControllerType.inherited;

      if (parentStates.child == widget) {
        // This widget is the top-most widget in the [ParentMaterialStatesData] tree, so update the
        // material states controller's values to match the widget's initial state.
        _updateInitialControllerStates();
        statesController
          ..removeListener(parentStates.onStateChange)
          ..addListener(parentStates.onStateChange);
      } else {
        // Descendant widgets under the top-most widget in the [ParentMaterialStatesData] tree
        // should read and use the material states controller's selected state.
        //
        // Since the top-level [TwParentMaterialStates] calls setState in a post-frame callback,
        // these descendant widgets can listen and react to the material states controller's changes
        // via setState directly, as these will resolve first before the top-level widget's setState
        // call.

        // For isSelected, only update from the parent if the widget is not tristate enabled.
        if (!widget.isTristate) {
          _isSelected =
              parentStates.controller.value.contains(MaterialState.selected);
        }

        // For isDisabled, if the current widget isn't already disabled, update from the parent
        // to see if the parent is also disabled.
        if (!widget.isDisabled) {
          _isDisabled =
              parentStates.controller.value.contains(MaterialState.disabled);
        }

        statesController
          ..removeListener(handleStatesControllerChange)
          ..addListener(handleStatesControllerChange);
      }
      return;
    }

    // [ParentMaterialStatesData] was not found, so determine if the widget has an external
    // states controller passed in or not.
    if (widget.statesController != null) {
      _statesControllerType = MaterialStatesControllerType.passedDown;
    } else {
      _statesControllerType = MaterialStatesControllerType.internal;
      _internalStatesController = MaterialStatesController();
    }
    _updateInitialControllerStates();
    statesController
      ..removeListener(handleStatesControllerChange)
      ..addListener(handleStatesControllerChange);
  }

  /// Called when an [InheritedWidget] that this widget depends on changes
  /// from upstream.
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
      statesController.update(MaterialState.disabled, widget.isDisabled);
      // Remove pressed state if applicable, if the widget is now disabled
      if (widget.isDisabled) {
        statesController.update(MaterialState.pressed, false);
      }
    }
    if (widget.isToggled != oldWidget.isToggled) {
      _isSelected = widget.isToggled;
      _previousSelected = oldWidget.isToggled;
      onIsSelectedChanged(isSelected: isSelected);
    }
  }

  @override
  void dispose() {
    if (parentStates?.onStateChange != null) {
      statesController.removeListener(parentStates!.onStateChange);
    }
    statesController.removeListener(handleStatesControllerChange);
    _internalStatesController?.dispose();
    _focusNode?.dispose();
    super.dispose();
  }

  @protected
  TwStyle getCurrentStyle(final Set<MaterialState> states) {
    if (widget.styleResolver != null) {
      return widget.styleResolver!(
        states,
        isSelected: isSelected,
        previousSelected: previousSelected,
        isDisabled: isDisabled,
        style: widget.style,
        disabled: widget.disabled,
        pressed: widget.pressed,
        hovered: widget.hovered,
        dragged: widget.dragged,
        focused: widget.focused,
        selected: widget.selected,
        errored: widget.errored,
      );
    }

    if (isDisabled || states.contains(MaterialState.disabled)) {
      return widget.style.merge(widget.disabled);
    }
    if (states.contains(MaterialState.dragged)) {
      return widget.style.merge(widget.pressed).merge(widget.dragged);
    }
    if (states.contains(MaterialState.error)) {
      return widget.style.merge(widget.errored);
    }
    if (states.contains(MaterialState.focused)) {
      return widget.style.merge(widget.focused);
    }
    if (states.contains(MaterialState.pressed)) {
      return widget.style.merge(widget.pressed);
    }
    // The widget could have its [isToggled] property set to true, but the states controller may
    // not have been updated yet.
    // Also default to true if the widget supports tristates and the value is neutral (null).
    if ((isSelected ?? true) || states.contains(MaterialState.selected)) {
      return widget.style.merge(widget.selected);
    }
    if (states.contains(MaterialState.hovered)) {
      return widget.style.merge(widget.hovered);
    }
    return widget.style;
  }

  MouseCursor? _resolveCursor() {
    final cursor = widget.cursor;
    if (cursor != null && cursor is MaterialStateMouseCursor) {
      return cursor.resolve(currentStates);
    }
    return cursor;
  }

  Widget wrapMouseRegion(final Widget child) {
    return MouseRegion(
      onEnter: (final event) {
        statesController.update(MaterialState.hovered, true);
        widget.onHover?.call(true);
      },
      onExit: (final event) {
        statesController.update(MaterialState.hovered, false);
        widget.onHover?.call(false);
      },
      cursor: _resolveCursor() ?? MouseCursor.defer,
      child: child,
    );
  }

  void onIsSelectedChanged({required final bool? isSelected}) {
    if (isSelected == null) {
      handleStatesControllerChange();
      return;
    }
    statesController.update(MaterialState.selected, isSelected);
  }

  bool? _computeIsSelected(
    final bool isTristate,
    final bool? isSelected,
    final bool? previousSelected,
  ) {
    if (isTristate) {
      if (isSelected == null) {
        return previousSelected != null ? !previousSelected : true;
      }
      return null;
    }
    // [previousSelected] should never be null if [isTristate] is false
    return !isSelected!;
  }

  void _handleTapForToggleable() {
    final nextIsSelected =
        _computeIsSelected(widget.isTristate, _isSelected, _previousSelected);
    _previousSelected = _isSelected;
    _isSelected = nextIsSelected;
    onIsSelectedChanged(isSelected: isSelected);
    if (widget.onSelected != null) {
      widget.onSelected!(_isSelected);
      if (widget.enableFeedback) {
        Feedback.forTap(context);
      }
    }
  }

  void _handleTapForTappable() {
    if (widget.onTap != null) {
      if (widget.enableFeedback) {
        Feedback.forTap(context);
      }
      widget.onTap!();
    }
  }

  void handleTap() {
    if (!widget.isDisabled) {
      if (widget.isToggleable) {
        _handleTapForToggleable();
      }
      _handleTapForTappable();
    }
  }

  void handlePrimaryIntent(final Intent? intent) {
    handleTap();
  }

  void handleLongPress() {
    if (!widget.isDisabled) {
      if (widget.enableFeedback) {
        Feedback.forLongPress(context);
      }
      widget.onLongPress!();
    }
  }

  void handleDoubleTap() {
    if (!widget.isDisabled) {
      if (widget.enableFeedback) {
        Feedback.forTap(context);
      }
      widget.onDoubleTap!();
    }
  }

  Widget wrapGestureDetector(final Widget child) {
    return GestureDetector(
      excludeFromSemantics: true,
      behavior: widget.hitTestBehavior,
      onPanUpdate: (final DragUpdateDetails details) {
        if (widget.isDraggable) {
          statesController.update(MaterialState.dragged, true);
          widget.onDragged?.call(true);
        }
      },
      onPanEnd: (final DragEndDetails details) {
        statesController.update(MaterialState.pressed, false);
        if (widget.isDraggable) {
          statesController.update(MaterialState.dragged, false);
          widget.onDragged?.call(false);
        }
      },
      onPanCancel: () {
        statesController.update(MaterialState.pressed, false);
        if (widget.isDraggable) {
          statesController.update(MaterialState.dragged, false);
          widget.onDragged?.call(false);
        }
      },
      onPanDown: (final DragDownDetails details) {
        statesController.update(MaterialState.pressed, true);
      },
      onTap:
          widget.onTap != null || widget.onSelected != null ? handleTap : null,
      onLongPress: widget.onLongPress != null ? handleLongPress : null,
      onDoubleTap: widget.onDoubleTap != null ? handleDoubleTap : null,
      child: child,
    );
  }

  Widget conditionallyWrapOpacity(final Widget child, final TwStyle style) {
    if (!widget.hasOpacity) return child;
    return Opacity(
      opacity: style.opacity?.value ?? 1.0,
      child: child,
    );
  }

  Widget conditionallyWrapInputDetectors(final Widget child) {
    if (!widget.enableInputDetectors) return child;
    return wrapMouseRegion(wrapGestureDetector(child));
  }

  late final Map<Type, Action<Intent>> _actionMap = <Type, Action<Intent>>{
    ActivateIntent:
        CallbackAction<ActivateIntent>(onInvoke: handlePrimaryIntent),
    ButtonActivateIntent:
        CallbackAction<ButtonActivateIntent>(onInvoke: handlePrimaryIntent),
  };

  Widget conditionallyWrapFocus(
    final Widget child, {
    final bool includeFocusActions = false,
  }) {
    if (!widget.canRequestFocus) return child;
    final focus = Focus(
      onFocusChange: (final bool hasFocus) {
        statesController.update(MaterialState.focused, hasFocus);
        widget.onFocusChange?.call(hasFocus);
      },
      focusNode: focusNode,
      autofocus: widget.autofocus,
      child: child,
    );
    return includeFocusActions
        ? Actions(
            actions: _actionMap,
            child: focus,
          )
        : focus;
  }
}
