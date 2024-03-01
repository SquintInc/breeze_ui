import 'package:breeze_ui/config/options/units.dart';
import 'package:meta/meta.dart';

@immutable
class TwMinHeight {
  final CssMeasurementUnit value;

  const TwMinHeight(this.value);

  @override
  bool operator ==(final Object other) =>
      identical(this, other) ||
      other is TwMinHeight &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() {
    return 'TwMinHeight{value: $value}';
  }
}
