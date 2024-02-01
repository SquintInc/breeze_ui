import 'package:flutter/widgets.dart';
import 'package:tailwind_elements/config/options/spacing/padding.dart';

/// Wrapper for [SliverPadding] with support for Tailwind padding constants.
class TwSliverPadding extends SliverPadding {
  final TwPadding _padding;

  const TwSliverPadding({
    required final TwPadding padding,
    super.sliver,
    super.key,
  })  : _padding = padding,
        super(padding: EdgeInsets.zero);

  @override
  EdgeInsetsGeometry get padding => _padding.toEdgeInsets();
}
