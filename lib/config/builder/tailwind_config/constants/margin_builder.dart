import 'package:tailwind_elements/config/builder/tailwind_config/constants/constants_generator.dart';
import 'package:tailwind_elements/config/options/spacing/margin.dart';

/// A [ConstantsGenerator] used to generate Tailwind 'margin' constants
/// to the .g.dart part file.
///
/// Generates [TwMarginSize] constants.
class MarginBuilder extends ConstantsGenerator {
  const MarginBuilder(super.options, super.config);

  @override
  String get identifierPrefix => 'm';

  @override
  String get themeConfigKey => 'margin';

  @override
  String get wrappedClassName => (TwMarginSize).toString();
}
