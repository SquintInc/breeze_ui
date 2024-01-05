import 'package:flutter/widgets.dart';
import 'package:tailwind_elements/widgets/style/style.dart';

@immutable
abstract class TwStatelessWidget extends StatelessWidget {
  /// Tailwind style properties for this widget. Since this is a stateless and static widget,
  /// we only take in a single style.
  final TwStyle style;

  const TwStatelessWidget({required this.style, super.key});
}
