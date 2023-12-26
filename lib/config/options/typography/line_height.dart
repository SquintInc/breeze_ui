import 'package:meta/meta.dart';
import 'package:tailwind_elements/config/options/units.dart';

@immutable
class TwLineHeight {
  final TwUnit value;

  const TwLineHeight(this.value);

  @override
  bool operator ==(final Object other) =>
      identical(this, other) ||
      other is TwLineHeight &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() {
    return 'TwLineHeight{value: $value}';
  }
}
