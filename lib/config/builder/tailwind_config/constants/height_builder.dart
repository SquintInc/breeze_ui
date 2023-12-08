import 'package:tailwind_elements/config/builder/tailwind_config/constants/constants_generator.dart';
import 'package:tailwind_elements/config/options/sizing/height.dart';

/// A [ConstantsGenerator] used to generate Tailwind 'height' constants
/// to the .g.dart part file.
///
/// Generates [TwHeight] constants.
class HeightBuilder extends ConstantsGenerator {
  const HeightBuilder(super.options, super.config);

  @override
  String get identifierPrefix => 'h';

  @override
  String get themeConfigKey => 'height';

  @override
  String get wrappedClassName => (TwHeight).toString();
}
