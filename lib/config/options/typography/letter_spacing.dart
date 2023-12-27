import 'package:meta/meta.dart';
import 'package:tailwind_elements/config/options/units.dart';

@immutable
class TwLetterSpacing {
  final TwUnit value;

  const TwLetterSpacing(this.value);

  @override
  bool operator ==(final Object other) =>
      identical(this, other) ||
      other is TwLetterSpacing &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() {
    return 'TwLetterSpacing{value: $value}';
  }
}
