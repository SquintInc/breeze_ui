import 'package:flutter/material.dart';

/// A simple [InheritedWidget] that provides the constraints of a parent widget to its descendants.
///
/// This is used by [TwDiv]s and passed down to the underlying [Div] to allow the children to use
/// the parent's constraints for relative (percentage-based) sizing (e.g., nesting multiple [TwDiv]s
/// where all of them use percentage-based widths and heights).
@immutable
class ParentConstraintsData extends InheritedWidget {
  final BoxConstraints constraints;

  const ParentConstraintsData({
    required this.constraints,
    required super.child,
    super.key,
  });

  const ParentConstraintsData.unbounded({required super.child, super.key})
      : constraints = const BoxConstraints();

  static ParentConstraintsData? of(final BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ParentConstraintsData>();
  }

  @override
  bool updateShouldNotify(final ParentConstraintsData oldWidget) {
    return constraints != oldWidget.constraints;
  }
}
