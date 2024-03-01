import 'package:breeze_ui/config/options/units.dart';
import 'package:meta/meta.dart';

@immutable
class TwMaxWidth {
  final CssMeasurementUnit value;

  const TwMaxWidth(this.value);

  @override
  bool operator ==(final Object other) =>
      identical(this, other) ||
      other is TwMaxWidth &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() {
    return 'TwMaxWidth{value: $value}';
  }
}
