import 'package:meta/meta.dart';
import 'package:tailwind_elements/config/options/units/measurement_unit.dart';

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
