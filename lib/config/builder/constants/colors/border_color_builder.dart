import 'package:tailwind_elements/config/builder/constants/generators.dart';

/// A [ColorConstantsGenerator] used to generate Tailwind 'border-*' colors
/// to the .g.dart part file.
class BorderColorBuilder extends ColorConstantsGenerator {
  const BorderColorBuilder(super.options, super.config);

  @override
  String get themeConfigKey => 'borderColors';

  @override
  String get variablePrefix => 'border';

  @override
  String get colorValueClassName => 'TwBorderColor';
}
