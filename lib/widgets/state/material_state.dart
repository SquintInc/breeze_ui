import 'package:flutter/material.dart';
import 'package:tailwind_elements/widgets/animation/animation_group.dart';
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

  /// The internal focus node for this stateful widget.
  late FocusNode? _focusNode;

  FocusNode? get focusNode => widget.focusNode ?? _focusNode;

  /// If the widget is selectable, this keeps track of the widget's selection / toggle state.
  bool _isSelected = false;

  /// Getter for [_isSelected].
  bool get isSelected => _isSelected;

  @override
  void initState() {
    super.initState();
    // Track initial toggle selection state from the value passed to the widget
    _isSelected = widget.isToggled;
    // Create a new focus node if one wasn't passed to the widget
    if (widget.focusNode == null) {
      _focusNode = FocusNode();
    }
  }

  /// Rebuilds the widget when the material states controller changes.
  void handleStatesControllerChange() {
    setState(() {});
  }

  void initStatesController() {
    final MaterialStatesGroup? animationGroup = MaterialStatesGroup.of(context);

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
    _focusNode?.dispose();
    super.dispose();
  }

  @protected
  TwStyle getCurrentStyle() {
    final states = currentStates;
    if (states.contains(MaterialState.disabled)) {
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
    if (states.contains(MaterialState.selected)) {
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
      cursor: _resolveCursor() ?? MouseCursor.defer,
      child: child,
    );
  }

  void handleTap() {
    if (!widget.isDisabled) {
      if (widget.isToggleable) {
        _isSelected = !_isSelected;
        _statesController.update(MaterialState.selected, _isSelected);
        if (widget.onSelected != null) {
          widget.onSelected!(_isSelected);
          if (widget.enableFeedback) {
            Feedback.forTap(context);
          }
        }
      }
      if (widget.onTap != null) {
        if (widget.enableFeedback) {
          Feedback.forTap(context);
        }
        widget.onTap!();
      }
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

  Widget _wrapGestureDetector(final Widget child) {
    return GestureDetector(
      excludeFromSemantics: true,
      behavior: widget.hitTestBehavior,
      onPanStart: (final DragStartDetails details) {
        if (widget.isDraggable) {
          _statesController.update(MaterialState.dragged, true);
          widget.onDragged?.call(true);
        }
      },
      onPanEnd: (final DragEndDetails details) {
        _statesController.update(MaterialState.pressed, false);
        if (widget.isDraggable) {
          _statesController.update(MaterialState.dragged, false);
          widget.onDragged?.call(false);
        }
      },
      onPanCancel: () {
        _statesController.update(MaterialState.pressed, false);
        if (widget.isDraggable) {
          _statesController.update(MaterialState.dragged, false);
          widget.onDragged?.call(false);
        }
      },
      onPanDown: (final DragDownDetails details) {
        _statesController.update(MaterialState.pressed, true);
      },
      onTap:
          widget.onTap != null || widget.onSelected != null ? handleTap : null,
      onLongPress: widget.onLongPress != null ? handleLongPress : null,
      onDoubleTap: widget.onDoubleTap != null ? handleDoubleTap : null,
      child: child,
    );
  }

  Widget conditionallyWrapOpacity(final Widget child, final TwStyle style) {
    if (widget.hasOpacity) {
      return Opacity(
        opacity: style.opacity?.value ?? 1.0,
        child: child,
      );
    }
    return child;
  }

  Widget conditionallyWrapInputDetectors(final Widget child) {
    if (widget.enableInputDetectors) {
      return _wrapMouseRegion(_wrapGestureDetector(child));
    }
    return child;
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
    if (widget.canRequestFocus) {
      final focus = Focus(
        onFocusChange: (final bool hasFocus) {
          _statesController.update(MaterialState.focused, hasFocus);
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
    return child;
  }
}
