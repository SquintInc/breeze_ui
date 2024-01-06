import 'package:flutter/widgets.dart';
import 'package:tailwind_elements/widgets/style/style.dart';

@immutable
abstract class TwStatelessWidget extends StatelessWidget {
  /// Tailwind style properties for this widget. Since this is a stateless and static widget,
  /// we only take in a single style.
  final TwStyle style;

  /// Static constraints that this widget should use. This may sometimes be passed in from a parent
  /// animated widget, which would be used for tweening calculations when computing the relative
  /// width and height.
  final TwConstraints? staticConstraints;

  const TwStatelessWidget({
    required this.style,
    this.staticConstraints,
    super.key,
  });
}
