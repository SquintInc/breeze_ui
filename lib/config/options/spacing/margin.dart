import 'package:meta/meta.dart';
import 'package:tailwind_elements/config/options/theme/units.dart';

@immutable
class TwMargin {
  final TwUnit value;

  const TwMargin(this.value);

  factory TwMargin.px(final double px) => TwMargin(PxUnit(px));
}
