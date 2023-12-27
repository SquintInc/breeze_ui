import 'package:flutter/widgets.dart';
import 'package:tailwind_elements/config/options/sizing/gap.dart';
import 'package:tailwind_elements/config/options/sizing/width.dart';
import 'package:tailwind_elements/widgets.dart';

/// A [Row] widget wrapper with support for Tailwind styled properties.
@immutable
class TwRow extends StatelessWidget {
  final TwGapX? gap;
  final List<Widget> children;
  final bool scrollable;

  // Passthrough [Row] properties
  final MainAxisAlignment mainAxisAlignment;
  final MainAxisSize mainAxisSize;
  final CrossAxisAlignment crossAxisAlignment;
  final TextDirection? textDirection;
  final VerticalDirection verticalDirection;
  final TextBaseline? textBaseline;

  const TwRow({
    required this.children,
    this.gap,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.mainAxisSize = MainAxisSize.max,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.textDirection,
    this.verticalDirection = VerticalDirection.down,
    this.textBaseline,
    this.scrollable = false,
    super.key,
  });

  List<Widget> gappedChildren() {
    final gap = this.gap;
    if (gap == null) {
      return children;
    }

    final gapBox = TwSizedBox(width: TwWidth(gap.value));
    final List<Widget> gappedChildren = List.generate(
      children.length * 2 - 1,
      (final index) => (index.isOdd) ? gapBox : children[index ~/ 2],
    );
    return gappedChildren;
  }

  @override
  Widget build(final BuildContext context) {
    final row = Row(
      key: key,
      mainAxisAlignment: mainAxisAlignment,
      mainAxisSize: mainAxisSize,
      crossAxisAlignment: crossAxisAlignment,
      textDirection: textDirection,
      verticalDirection: verticalDirection,
      textBaseline: textBaseline,
      children: gappedChildren(),
    );

    return scrollable
        ? SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: row,
          )
        : row;
  }
}
