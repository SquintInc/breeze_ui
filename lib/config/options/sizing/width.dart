import 'package:breeze_ui/config/options/units.dart';
import 'package:meta/meta.dart';

@immutable
class TwWidth {
  final CssMeasurementUnit value;

  const TwWidth(this.value);

  @override
  bool operator ==(final Object other) =>
      identical(this, other) ||
      other is TwWidth &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() {
    return 'TwWidth{value: $value}';
  }
}
