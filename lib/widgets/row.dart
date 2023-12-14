import 'package:flutter/widgets.dart';
import 'package:tailwind_elements/config/options/sizing/gap.dart';
import 'package:tailwind_elements/config/options/sizing/width.dart';
import 'package:tailwind_elements/widgets.dart';

@immutable
class TwRow extends StatelessWidget {
  final TwGapX? gap;
  final List<Widget> children;

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
    super.key,
  });

  List<Widget> gappedChildren() {
    final gap = this.gap;
    if (gap == null) {
      return children;
    }

    final gapBox = TwSizedBox(width: TwWidth(gap.value));
    return zip(
      children,
      List.filled(children.length - 1, gapBox),
    ).toList();
  }

  @override
  Widget build(final BuildContext context) {
    return Row(
      key: key,
      mainAxisAlignment: mainAxisAlignment,
      mainAxisSize: mainAxisSize,
      crossAxisAlignment: crossAxisAlignment,
      textDirection: textDirection,
      verticalDirection: verticalDirection,
      textBaseline: textBaseline,
      children: gappedChildren(),
    );
  }
}
