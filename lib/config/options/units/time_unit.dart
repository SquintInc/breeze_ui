import 'package:meta/meta.dart';

/// Represents a CSS time unit type.
enum TimeType {
  ms,
  s,
}

/// Represents a CSS time unit using a sealed class.
@immutable
sealed class CssTimeUnit {
  TimeType get type;

  Duration get value;
}

@immutable
class MillisecondsTimeUnit implements CssTimeUnit {
  @override
  final Duration value;

  const MillisecondsTimeUnit(this.value);

  @override
  TimeType get type => TimeType.ms;

  @override
  String toString() => '$value${type.name}';

  @override
  bool operator ==(final Object other) =>
      identical(this, other) ||
      other is MillisecondsTimeUnit &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => value.hashCode;
}

@immutable
class SecondsTimeUnit implements CssTimeUnit {
  @override
  final Duration value;

  const SecondsTimeUnit(this.value);

  @override
  TimeType get type => TimeType.s;

  @override
  String toString() => '$value${type.name}';

  @override
  bool operator ==(final Object other) =>
      identical(this, other) ||
      other is SecondsTimeUnit &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => value.hashCode;
}
