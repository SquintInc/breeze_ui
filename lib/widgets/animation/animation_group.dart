import 'package:flutter/material.dart';

/// An [InheritedWidget] that provides a [MaterialStatesController] to its
/// descendants. Prefer using [TwAnimationGroup] to create a new instance of
/// this widget as it can manage the lifecycle of the controller.
class MaterialStatesGroup extends InheritedWidget {
  final MaterialStatesController statesController;

  const MaterialStatesGroup({
    required this.statesController,
    required super.child,
    super.key,
  });

  static MaterialStatesGroup? of(final BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<MaterialStatesGroup>();
  }

  @override
  bool updateShouldNotify(final MaterialStatesGroup oldWidget) {
    return !identical(statesController, oldWidget.statesController);
  }
}

/// A [StatefulWidget] that wraps an [MaterialStatesGroup] to provide a
/// [MaterialStatesController] to its descendants.
class TwAnimationGroup extends StatefulWidget {
  final Widget child;

  /// Optionally pass in an external [MaterialStatesController] to use instead,
  /// however this is not recommended as this widget will not automatically
  /// dispose external controllers passed in this way.
  final MaterialStatesController? statesController;

  const TwAnimationGroup({
    required this.child,
    this.statesController,
    super.key,
  });

  @override
  State createState() => _TwAnimationGroupState();
}

class _TwAnimationGroupState extends State<TwAnimationGroup> {
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

  @override
  Widget build(final BuildContext context) {
    return MaterialStatesGroup(
      statesController: statesController,
      child: widget.child,
    );
  }
}
