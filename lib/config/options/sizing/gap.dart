import 'package:meta/meta.dart';
import 'package:tailwind_elements/config/options/units.dart';

@immutable
class TwGapX {
  final TwUnit value;

  const TwGapX(this.value);

  @override
  bool operator ==(final Object other) =>
      identical(this, other) ||
      other is TwGapX &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => value.hashCode;
}

@immutable
class TwGapY {
  final TwUnit value;

  const TwGapY(this.value);

  @override
  bool operator ==(final Object other) =>
      identical(this, other) ||
      other is TwGapY &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => value.hashCode;
}
