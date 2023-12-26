import 'package:flutter/material.dart';

class TwAnimationGroup extends InheritedWidget {
  final MaterialStatesController statesController;

  const TwAnimationGroup({
    required this.statesController,
    required super.child,
    super.key,
  });

  @override
  bool updateShouldNotify(final TwAnimationGroup oldWidget) {
    return statesController != oldWidget.statesController;
  }
}
