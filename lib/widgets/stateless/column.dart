import 'package:breeze_ui/config/options/sizing/gap.dart';
import 'package:breeze_ui/config/options/sizing/height.dart';
import 'package:breeze_ui/widgets/stateless/sized_box.dart';
import 'package:flutter/widgets.dart';

/// A [Column] widget wrapper with support for Tailwind styled properties.
@immutable
class TwColumn extends StatelessWidget {
  final TwGapY? gap;
  final List<Widget> children;
  final bool scrollable;

  // Passthrough [Column] properties
  final MainAxisAlignment mainAxisAlignment;
  final MainAxisSize mainAxisSize;
  final CrossAxisAlignment crossAxisAlignment;
  final TextDirection? textDirection;
  final VerticalDirection verticalDirection;
  final TextBaseline? textBaseline;

  const TwColumn({
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
    if (gap == null || children.isEmpty) {
      return children;
    }

    final gapBox = TwSizedBox(height: TwHeight(gap.value));
    final List<Widget> gappedChildren = List.generate(
      children.length * 2 - 1,
      (final index) => (index.isOdd) ? gapBox : children[index ~/ 2],
    );
    return gappedChildren;
  }

  @override
  Widget build(final BuildContext context) {
    final column = Column(
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
            scrollDirection: Axis.vertical,
            child: column,
          )
        : column;
  }
}
