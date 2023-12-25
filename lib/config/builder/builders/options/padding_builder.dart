import 'package:tailwind_elements/config/builder/builders/generators.dart';

/// A [ConstantsGenerator] used to generate Tailwind 'p-*' padding constants
/// to the .g.dart part file.
class PaddingBuilder extends ConstantsGenerator {
  const PaddingBuilder(super.options, super.config);

  @override
  String get themeConfigKey => 'padding';

  @override
  Map<String, String> get variablePrefixToValueClassName => {
        'p': 'TwPaddingAll',
        'px': 'TwPaddingX',
        'py': 'TwPaddingY',
        'pt': 'TwPaddingTop',
        'pr': 'TwPaddingRight',
        'pb': 'TwPaddingBottom',
        'pl': 'TwPaddingLeft',
      };
}
