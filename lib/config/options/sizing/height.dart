import 'package:breeze_ui/config/options/units.dart';
import 'package:meta/meta.dart';

@immutable
class TwHeight {
  final CssMeasurementUnit value;

  const TwHeight(this.value);

  @override
  bool operator ==(final Object other) =>
      identical(this, other) ||
      other is TwHeight &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() {
    return 'TwHeight{value: $value}';
  }
}
