import 'package:tailwind_elements/config/builder/builders/generators.dart';
import 'package:tailwind_elements/config/options/spacing/padding.dart';

/// A [ConstantsGenerator] used to generate Tailwind 'p-*' padding constants
/// to the .g.dart part file.
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
