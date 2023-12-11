import 'package:tailwind_elements/config/builder/constants/generators.dart';
import 'package:tailwind_elements/config/options/sizing/max_width.dart';

/// A [ConstantsGenerator] used to generate Tailwind 'max-h' constants
/// to the .g.dart part file.
class MaxWidthBuilder extends ConstantsGenerator {
  const MaxWidthBuilder(super.options, super.config);

  @override
  String get themeConfigKey => 'maxWidth';

  @override
  Map<String, String> get variablePrefixToValueClassName => {
        'max-w': (TwMaxWidth).toString(),
      };
}
