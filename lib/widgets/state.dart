import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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

/// Controller class that contains all the tracked variables and tween values
/// for animated transitions.
class TwAnimationController {
  /// Current animation curve
  CurvedAnimation? _animationCurve;

  /// Internal animation controller for the widget using this class
  AnimationController? _animationController;

  // Tween values for animated transitions
  BoxConstraintsTween? _boxConstraints;
  ColorTween? _backgroundColor;

  /// Temporary box constraint value tracked for transitions, necessary due to
  /// the fact that [LayoutBuilder] might be used during build time to compute
  /// the constraints for the widget.
  BoxConstraints? _trackedConstraints;

  final VoidCallback redrawAnimationFn;
  final AnimationStatusListener animationStatusListener;

  Curve? get curve => _animationCurve?.curve;

  Duration? get duration => _animationController?.duration;

  bool get canAnimate => curve != null && duration != null;

  TwAnimationController({
    required final Widget widget,
    required final TickerProvider vsync,
    required final Duration duration,
    required final Curve curve,
    required this.redrawAnimationFn,
    required this.animationStatusListener,
  }) {
    final animationController = AnimationController(
      vsync: vsync,
      duration: duration,
      debugLabel: kDebugMode ? widget.toStringShort() : null,
    )
      ..addListener(redrawAnimationFn)
      ..addStatusListener(animationStatusListener);
    final animationCurve = CurvedAnimation(
      parent: animationController,
      curve: curve,
    );
    _animationCurve = animationCurve;
    _animationController = animationController;
  }

  void updateAnimationDuration(final Duration? duration) {
    final animationController = _animationController;
    if (animationController != null) {
      animationController.duration = duration;
    }
  }

  /// Disposes current internal animation curve and sets it to the provided
  /// [curve].
  void updateAnimationCurve(final Curve? curve) {
    final animationCurve = _animationCurve;
    if (animationCurve != null) {
      animationCurve.dispose();
      final animationController = _animationController;
      if (curve != null && animationController != null) {
        _animationCurve = CurvedAnimation(
          parent: animationController,
          curve: curve,
        );
      } else {
        _animationCurve = null;
      }
    }
  }

  void initTweens(final TwStyle defaultStyle) {
    _boxConstraints = BoxConstraintsTween(
      begin: _trackedConstraints ?? BoxConstraints.tight(Size.zero),
      end: _trackedConstraints ?? BoxConstraints.tight(Size.zero),
    );
    _backgroundColor = ColorTween(
      begin: defaultStyle.backgroundColor?.color,
      end: defaultStyle.backgroundColor?.color,
    );
  }

  void _updateTween<T>({
    required final Tween<T>? tween,
    required final T targetValue,
  }) {
    if (tween == null) return;
    final animation = _animationCurve;
    if (animation == null) return;
    tween
      ..begin = tween.evaluate(animation)
      ..end = targetValue;
  }

  void updateTweens(
    final TwStyle prevStyle,
    final TwStyle nextStyle,
  ) {
    _updateTween(
      tween: _boxConstraints,
      targetValue: _trackedConstraints ?? BoxConstraints.tight(Size.zero),
    );
    _updateTween(
      tween: _backgroundColor,
      targetValue: nextStyle.backgroundColor?.color,
    );
  }

  void animate() {
    if (!canAnimate) return;
    final animationController = _animationController;
    if (animationController != null) {
      animationController
        ..value = 0.0
        ..forward();
    }
  }

  void updateTrackedConstraints(final BoxConstraints? constraints) {
    _updateTween(tween: _boxConstraints, targetValue: constraints);
    _trackedConstraints = constraints;
  }

  void dispose() {
    final animationController = _animationController;
    if (animationController != null) {
      animationController
        ..removeListener(redrawAnimationFn)
        ..removeStatusListener(animationStatusListener)
        ..dispose();
    }
  }

  BoxConstraints? get trackedConstraints => _trackedConstraints;

  BoxConstraints? get boxConstraints =>
      canAnimate ? _boxConstraints?.evaluate(_animationCurve!) : null;

  Color? get backgroundColor =>
      canAnimate ? _backgroundColor?.evaluate(_animationCurve!) : null;
}

abstract class TwAnimatedState<T extends TwStatefulWidget> extends TwState<T>
    with SingleTickerProviderStateMixin {
  TwAnimationController? _animationController;

  @protected
  TwAnimationController? get animationController => _animationController;

  @override
  void initState() {
    super.initState();
    if (widget.hasTransitions) {
      // Only create animation controller if transitions are enabled
      _animationController = TwAnimationController(
        widget: widget,
        vsync: this,
        duration: widget.style.transitionDuration?.duration.value ??
            const Duration(milliseconds: 150),
        curve: widget.style.transitionTimingFn?.curve ??
            const Cubic(0.4, 0, 0.2, 1),
        redrawAnimationFn: _redrawAnimation,
        animationStatusListener: animationListener,
      );

      // Run initTweens only once, after the Widget's first frame is rendered to
      // ensure that the initial constraints have been already set.
      WidgetsBinding.instance.addPostFrameCallback((final timestamp) {
        _animationController?.initTweens(widget.style);
      });
    }
  }

  /// Rebuilds the widget whenever the animation controller ticks.
  void _redrawAnimation() {
    setState(() {});
  }

  @protected
  void animationListener(final AnimationStatus status);

  @override
  void didWidgetStateChange(
    final TwWidgetState prevWidgetState,
    final TwWidgetState nextWidgetState,
  ) {
    // Update transitions and tweens
    if (widget.hasTransitions) {
      final animationController = this._animationController;
      if (animationController == null) return;

      final prevStyle = getStyle(prevWidgetState);
      final nextStyle = getStyle(nextWidgetState);

      // Compute the new animation curve, with fallback to the default curve
      // if it was set in the [style] property.
      final Curve? nextCurve = nextStyle.transitionTimingFn?.curve ??
          widget.style.transitionTimingFn?.curve;
      if (animationController.curve != nextCurve) {
        animationController.updateAnimationCurve(nextCurve);
      }

      // Compute the new animation duration, with fallback to the default
      // duration if it was set in the [style] property.
      final Duration? nextDuration =
          nextStyle.transitionDuration?.duration.value ??
              widget.style.transitionDuration?.duration.value;
      if (animationController.duration != nextDuration) {
        animationController.updateAnimationDuration(nextDuration);
      }

      animationController
        ..updateTweens(prevStyle, nextStyle)
        ..animate();
    }
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }
}

/// A widget [State] subclass with support for [MaterialStatesController] and
/// animated transitions.
abstract class TwState<T extends TwStatefulWidget> extends State<T> {
  /// The internal material states controller for this stateful widget.
  late MaterialStatesController? _statesController;
  TwWidgetState _widgetState = TwWidgetState.normal;
  TwWidgetState _prevWidgetState = TwWidgetState.normal;

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
  TwStyle getStyle(final TwWidgetState widgetState) => switch (widgetState) {
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
    final newWidgetState = getWidgetState(statesController.value);
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
      _widgetState,
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
