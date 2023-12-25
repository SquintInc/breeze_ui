import 'package:tailwind_elements/config/builder/builders/generators.dart';

/// A [ConstantsGenerator] used to generate Tailwind 'rounded-*' border radius
/// constants to the .g.dart part file.
class BorderRadiusBuilder extends ConstantsGenerator {
  const BorderRadiusBuilder(super.options, super.config);

  @override
  String get themeConfigKey => 'borderRadius';

  @override
  Map<String, String> get variablePrefixToValueClassName {
    return {
      'rounded': 'TwBorderRadiusAll',
      'rounded-t': 'TwBorderRadiusTop',
      'rounded-r': 'TwBorderRadiusRight',
      'rounded-b': 'TwBorderRadiusBottom',
      'rounded-l': 'TwBorderRadiusLeft',
      'rounded-tl': 'TwBorderRadiusTopLeft',
      'rounded-tr': 'TwBorderRadiusTopRight',
      'rounded-br': 'TwBorderRadiusBottomRight',
      'rounded-bl': 'TwBorderRadiusBottomLeft',
    };
  }
}
