import 'package:tailwind_elements/config/builder/constants/generators.dart';
import 'package:tailwind_elements/config/options/sizing/width.dart';

/// A [ConstantsGenerator] used to generate Tailwind 'width' constants
/// to the .g.dart part file.
///
/// Generates [TwWidth] constants.
class WidthBuilder extends ConstantsGenerator {
  const WidthBuilder(super.options, super.config);

  @override
  String get themeConfigKey => 'width';

  @override
  Map<String, String> get variablePrefixToValueClassName => {
        'w': (TwWidth).toString(),
      };
}
