import 'package:tailwind_elements/config/builder/builders/generators.dart';
import 'package:tailwind_elements/config/options/typography/letter_spacing.dart';

/// A [ConstantsGenerator] used to generate Tailwind 'tracking-*' letter spacing
/// constants to the .g.dart part file.
class LetterSpacingBuilder extends ConstantsGenerator {
  const LetterSpacingBuilder(super.options, super.config);

  @override
  String get themeConfigKey => 'letterSpacing';

  @override
  Map<String, String> get variablePrefixToValueClassName => {
        'tracking': (TwLetterSpacing).toString(),
      };
}
