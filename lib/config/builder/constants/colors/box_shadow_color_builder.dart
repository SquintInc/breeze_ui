import 'package:tailwind_elements/config/builder/constants/generators.dart';

/// A [ColorConstantsGenerator] used to generate Tailwind 'shadow-*' colors
/// to the .g.dart part file.
class BoxShadowColorBuilder extends ColorConstantsGenerator {
  const BoxShadowColorBuilder(super.options, super.config);

  @override
  String get themeConfigKey => 'boxShadowColor';

  @override
  String get variablePrefix => 'shadow';

  @override
  String get colorValueClassName => 'TwBoxShadowColor';
}
