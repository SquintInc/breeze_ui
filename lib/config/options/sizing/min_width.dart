import 'package:breeze_ui/config/options/units.dart';
import 'package:meta/meta.dart';

@immutable
class TwMinWidth {
  final CssMeasurementUnit value;

  const TwMinWidth(this.value);

  @override
  bool operator ==(final Object other) =>
      identical(this, other) ||
      other is TwMinWidth &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() {
    return 'TwMinWidth{value: $value}';
  }
}
