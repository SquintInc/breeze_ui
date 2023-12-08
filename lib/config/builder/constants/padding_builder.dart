import 'package:tailwind_elements/config/builder/constants/constants_generator.dart';
import 'package:tailwind_elements/config/options/spacing/padding.dart';

/// A [ConstantsGenerator] used to generate Tailwind 'padding' constants
/// to the .g.dart part file.
///
/// Generates [TwPaddingSize] constants.
class PaddingBuilder extends ConstantsGenerator {
  const PaddingBuilder(super.options, super.config);

  @override
  String get themeConfigKey => 'padding';

  @override
  Map<String, String> get variablePrefixToValueClassName => {
        'p': (TwPaddingAll).toString(),
        'px': (TwPaddingX).toString(),
        'py': (TwPaddingY).toString(),
        'pt': (TwPaddingTop).toString(),
        'pr': (TwPaddingRight).toString(),
        'pb': (TwPaddingBottom).toString(),
        'pl': (TwPaddingLeft).toString(),
      };
}
