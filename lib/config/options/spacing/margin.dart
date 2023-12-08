import 'package:meta/meta.dart';
import 'package:tailwind_elements/config/options/theme/units.dart';

@immutable
class TwMarginSize {
  final TwUnit value;

  const TwMarginSize(this.value);
}

@immutable
class TwMargin {
  final TwMarginSize top;
  final TwMarginSize right;
  final TwMarginSize bottom;
  final TwMarginSize left;

  const TwMargin.all(final TwMarginSize marginSize)
      : top = marginSize,
        right = marginSize,
        bottom = marginSize,
        left = marginSize;

  const TwMargin.vertical(final TwMarginSize marginSize)
      : top = marginSize,
        right = const TwMarginSize(PxUnit(0)),
        bottom = marginSize,
        left = const TwMarginSize(PxUnit(0));

  const TwMargin.horizontal(final TwMarginSize marginSize)
      : top = const TwMarginSize(PxUnit(0)),
        right = marginSize,
        bottom = const TwMarginSize(PxUnit(0)),
        left = marginSize;

  const TwMargin({
    required this.top,
    required this.right,
    required this.bottom,
    required this.left,
  });
}
