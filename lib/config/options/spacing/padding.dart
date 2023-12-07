import 'package:meta/meta.dart';
import 'package:tailwind_elements/config/options/theme/units.dart';

@immutable
class TwPadding {
  final TwUnit value;

  const TwPadding(this.value);

  factory TwPadding.px(final double px) => TwPadding(PxUnit(px));
}
