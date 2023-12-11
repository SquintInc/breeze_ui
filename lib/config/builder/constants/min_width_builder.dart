import 'package:tailwind_elements/config/builder/constants/generators.dart';
import 'package:tailwind_elements/config/options/sizing/min_width.dart';

/// A [ConstantsGenerator] used to generate Tailwind 'min-w' constants
/// to the .g.dart part file.
class MinWidthBuilder extends ConstantsGenerator {
  const MinWidthBuilder(super.options, super.config);

  @override
  String get themeConfigKey => 'minWidth';

  @override
  Map<String, String> get variablePrefixToValueClassName => {
        'min-w': (TwMinWidth).toString(),
      };
}
