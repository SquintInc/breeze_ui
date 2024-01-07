import 'package:flutter/material.dart';

/// An [InheritedWidget] that allows a single [MaterialStatesController] to be shared by its
/// descendants.
///
/// Example widgets that use this include:
/// - [TwSwitch]
@immutable
class ParentMaterialStatesData extends InheritedWidget {
  final MaterialStatesController controller;
  final Set<MaterialState> states;
  final VoidCallback onStateChange;

  const ParentMaterialStatesData({
    required this.controller,
    required this.states,
    required this.onStateChange,
    required super.child,
    super.key,
  });

  static ParentMaterialStatesData? of(final BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<ParentMaterialStatesData>();
  }

  @override
  bool updateShouldNotify(final ParentMaterialStatesData oldWidget) {
    return !identical(controller, oldWidget.controller) ||
        states != oldWidget.states;
  }
}

/// A [StatefulWidget] that provides [ParentMaterialStatesData] to its
/// descendants.
class TwParentMaterialStates extends StatefulWidget {
  final Widget child;

  /// Optionally pass in an external [MaterialStatesController] to use instead,
  /// however this is not recommended as this widget will not automatically
  /// dispose external controllers passed in this way.
  final MaterialStatesController? statesController;

  const TwParentMaterialStates({
    required this.child,
    this.statesController,
    super.key,
  });

  @override
  State createState() => _TwParentMaterialStatesState();
}

class _TwParentMaterialStatesState extends State<TwParentMaterialStates> {
  MaterialStatesController? _internalStatesController;

  MaterialStatesController get statesController =>
      widget.statesController ?? _internalStatesController!;

  @override
  void initState() {
    super.initState();
    if (widget.statesController == null) {
      _internalStatesController = MaterialStatesController();
    }
  }

  @override
  void dispose() {
    _internalStatesController?.dispose();
    super.dispose();
  }

  /// Rather than letting the individual child widgets listen to a state change
  /// and calling setState within each state, let this parent widget know that
  /// the state has changed and it should rebuild itself including its children.
  ///
  /// Also wraps setState in a post-frame callback to ensure that all children
  /// have had a chance to update and cascade their states before rebuilding.
  void onStateChange() {
    WidgetsBinding.instance.addPostFrameCallback((final _) {
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  Widget build(final BuildContext context) {
    return ParentMaterialStatesData(
      controller: statesController,
      // states needs to be copied to prevent comparing the same underlying set object
      states: Set.unmodifiable(statesController.value),
      onStateChange: onStateChange,
      child: widget.child,
    );
  }
}
