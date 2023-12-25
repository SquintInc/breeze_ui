import 'package:flutter/animation.dart';
import 'package:meta/meta.dart';

@immutable
class TwTransitionTimingFunction {
  final Curve curve;

  const TwTransitionTimingFunction(this.curve);

  @override
  bool operator ==(final Object other) =>
      identical(this, other) ||
      other is TwTransitionTimingFunction &&
          runtimeType == other.runtimeType &&
          curve == other.curve;

  @override
  int get hashCode => curve.hashCode;

  @override
  String toString() {
    return 'TwTransitionTimingFunction{curve: $curve}';
  }
}
