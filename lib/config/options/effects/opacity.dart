import 'package:meta/meta.dart';

@immutable
class TwOpacity {
  final double value;

  const TwOpacity(this.value);

  @override
  bool operator ==(final Object other) =>
      identical(this, other) ||
      other is TwOpacity &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => value.hashCode;
}
