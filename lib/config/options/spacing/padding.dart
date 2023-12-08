import 'package:meta/meta.dart';
import 'package:tailwind_elements/config/options/theme/units.dart';

@immutable
class TwPaddingSize {
  final TwUnit value;

  const TwPaddingSize(this.value);
}

@immutable
class TwPadding {
  final TwPaddingSize top;
  final TwPaddingSize right;
  final TwPaddingSize bottom;
  final TwPaddingSize left;

  const TwPadding.all(final TwPaddingSize marginSize)
      : top = marginSize,
        right = marginSize,
        bottom = marginSize,
        left = marginSize;

  const TwPadding.vertical(final TwPaddingSize marginSize)
      : top = marginSize,
        right = const TwPaddingSize(PxUnit(0)),
        bottom = marginSize,
        left = const TwPaddingSize(PxUnit(0));

  const TwPadding.horizontal(final TwPaddingSize marginSize)
      : top = const TwPaddingSize(PxUnit(0)),
        right = marginSize,
        bottom = const TwPaddingSize(PxUnit(0)),
        left = marginSize;

  const TwPadding({
    required this.top,
    required this.right,
    required this.bottom,
    required this.left,
  });
}
