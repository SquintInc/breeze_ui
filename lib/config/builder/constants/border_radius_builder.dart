import 'package:tailwind_elements/config/builder/constants/generators.dart';
import 'package:tailwind_elements/config/options/borders/border_radius.dart';

/// A [ConstantsGenerator] used to generate Tailwind 'rounded' constants
/// to the .g.dart part file.
class BorderRadiusBuilder extends ConstantsGenerator {
  const BorderRadiusBuilder(super.options, super.config);

  @override
  String get themeConfigKey => 'borderRadius';

  @override
  Map<String, String> get variablePrefixToValueClassName {
    return {
      'rounded': (TwBorderRadiusAll).toString(),
      'rounded-t': (TwBorderRadiusTop).toString(),
      'rounded-r': (TwBorderRadiusRight).toString(),
      'rounded-b': (TwBorderRadiusBottom).toString(),
      'rounded-l': (TwBorderRadiusLeft).toString(),
      'rounded-tl': (TwBorderRadiusTopLeft).toString(),
      'rounded-tr': (TwBorderRadiusTopRight).toString(),
      'rounded-br': (TwBorderRadiusBottomRight).toString(),
      'rounded-bl': (TwBorderRadiusBottomLeft).toString(),
    };
  }
}
