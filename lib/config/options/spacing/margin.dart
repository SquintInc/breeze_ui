import 'package:meta/meta.dart';
import 'package:tailwind_elements/config/options/theme/units.dart';

@immutable
class TwMargin {
  final TwUnit top;
  final TwUnit right;
  final TwUnit bottom;
  final TwUnit left;

  const TwMargin.all(final TwUnit unit)
      : top = unit,
        right = unit,
        bottom = unit,
        left = unit;

  const TwMargin.vertical(final TwUnit unit)
      : top = unit,
        right = const PxUnit(0),
        bottom = unit,
        left = const PxUnit(0);

  const TwMargin.horizontal(final TwUnit unit)
      : top = const PxUnit(0),
        right = unit,
        bottom = const PxUnit(0),
        left = unit;

  const TwMargin({
    required this.top,
    required this.right,
    required this.bottom,
    required this.left,
  });
}
