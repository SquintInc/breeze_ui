import 'package:breeze_ui/config/options/units.dart';
import 'package:meta/meta.dart';

@immutable
class TwGapX {
  final CssMeasurementUnit value;

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
  final CssMeasurementUnit value;

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
