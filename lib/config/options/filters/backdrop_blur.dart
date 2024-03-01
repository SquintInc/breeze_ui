import 'package:breeze_ui/config/options/units/measurement_unit.dart';
import 'package:meta/meta.dart';

@immutable
class TwBackdropBlur {
  static const TwBackdropBlur zero = TwBackdropBlur(PxUnit(0.0));

  final CssAbsoluteUnit blur;

  const TwBackdropBlur(this.blur);

  @override
  String toString() {
    return 'TwBackdropBlur{blur: $blur}';
  }

  @override
  bool operator ==(final Object other) =>
      identical(this, other) ||
      other is TwBackdropBlur &&
          runtimeType == other.runtimeType &&
          blur == other.blur;

  @override
  int get hashCode => blur.hashCode;
}
