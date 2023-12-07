import 'package:meta/meta.dart';
import 'package:tailwind_elements/config/options/theme/units.dart';

@immutable
class TwPadding {
  final TwUnit top;
  final TwUnit right;
  final TwUnit bottom;
  final TwUnit left;

  const TwPadding.all(final TwUnit unit)
      : top = unit,
        right = unit,
        bottom = unit,
        left = unit;

  const TwPadding.vertical(final TwUnit unit)
      : top = unit,
        right = const PxUnit(0),
        bottom = unit,
        left = const PxUnit(0);

  const TwPadding.horizontal(final TwUnit unit)
      : top = const PxUnit(0),
        right = unit,
        bottom = const PxUnit(0),
        left = unit;

  const TwPadding({
    required this.top,
    required this.right,
    required this.bottom,
    required this.left,
  });
}
