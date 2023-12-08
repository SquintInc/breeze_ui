import 'package:tailwind_elements/config/builder/tailwind_config/constants/constants_generator.dart';
import 'package:tailwind_elements/config/options/sizing/width.dart';

/// A [ConstantsGenerator] used to generate Tailwind 'width' constants
/// to the .g.dart part file.
///
/// Generates [TwWidth] constants.
class WidthBuilder extends ConstantsGenerator {
  const WidthBuilder(super.options, super.config);

  @override
  String get identifierPrefix => 'w';

  @override
  String get themeConfigKey => 'width';

  @override
  String get wrappedClassName => (TwWidth).toString();
}
