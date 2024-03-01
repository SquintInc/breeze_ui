import 'package:breeze_ui/config/builder/builders/generators.dart';

/// A [ColorConstantsGenerator] used to generate Tailwind 'border-*' colors
/// to the .g.dart part file.
class BorderColorBuilder extends ColorConstantsGenerator {
  const BorderColorBuilder(super.options, super.config);

  @override
  String get themeConfigKey => 'borderColor';

  @override
  String get variablePrefix => 'border';

  @override
  String get colorValueClassName => 'TwBorderColor';
}
