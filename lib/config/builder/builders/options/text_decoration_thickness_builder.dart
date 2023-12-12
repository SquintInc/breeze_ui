import 'package:tailwind_elements/config/builder/builders/generators.dart';
import 'package:tailwind_elements/config/options/typography/text_decoration_thickness.dart';

/// A [ConstantsGenerator] used to generate Tailwind 'decoration-*' text
/// decoration thickness constants to the .g.dart part file.
class TextDecorationThicknessBuilder extends ConstantsGenerator {
  const TextDecorationThicknessBuilder(super.options, super.config);

  @override
  String get themeConfigKey => 'textDecorationThickness';

  @override
  Map<String, String> get variablePrefixToValueClassName {
    return {
      'decoration': (TwTextDecorationThickness).toString(),
    };
  }
}
