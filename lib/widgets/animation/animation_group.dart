import 'package:flutter/material.dart';

/// An [InheritedWidget] that provides a [MaterialStatesController] to its
/// descendants. Prefer using [TwAnimationGroup] to create a new instance of
/// this widget as it can manage the lifecycle of the controller.
class AnimationGroupData extends InheritedWidget {
  final MaterialStatesController statesController;

  const AnimationGroupData({
    required this.statesController,
    required super.child,
    super.key,
  });

  static AnimationGroupData? of(final BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AnimationGroupData>();
  }

  @override
  bool updateShouldNotify(final AnimationGroupData oldWidget) {
    return statesController != oldWidget.statesController;
  }
}

/// A [StatefulWidget] that wraps an [AnimationGroupData] to provide a
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
  MaterialStatesController? internalStatesController;

  MaterialStatesController get statesController =>
      widget.statesController ?? internalStatesController!;

  @override
  void initState() {
    super.initState();
    if (widget.statesController == null) {
      internalStatesController = MaterialStatesController();
    }
  }

  @override
  void dispose() {
    internalStatesController?.dispose();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) {
    return AnimationGroupData(
      statesController: MaterialStatesController(),
      child: widget.child,
    );
  }
}
