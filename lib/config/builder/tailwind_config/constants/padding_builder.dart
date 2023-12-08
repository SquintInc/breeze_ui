import 'package:tailwind_elements/config/builder/tailwind_config/constants/constants_generator.dart';
import 'package:tailwind_elements/config/options/spacing/padding.dart';

/// A [ConstantsGenerator] used to generate Tailwind 'padding' constants
/// to the .g.dart part file.
///
/// Generates [TwPaddingSize] constants.
class PaddingBuilder extends ConstantsGenerator {
  const PaddingBuilder(super.options, super.config);

  @override
  String get identifierPrefix => 'p';

  @override
  String get themeConfigKey => 'padding';

  @override
  String get wrappedClassName => (TwPaddingSize).toString();
}
