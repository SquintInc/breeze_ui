import 'package:tailwind_elements/config/builder/builders/generators.dart';

/// A [ColorConstantsGenerator] used to generate Tailwind 'bg-*' colors
/// to the .g.dart part file
class BackgroundColorBuilder extends ColorConstantsGenerator {
  const BackgroundColorBuilder(super.options, super.config);

  @override
  String get themeConfigKey => 'backgroundColor';

  @override
  String get variablePrefix => 'bg';

  @override
  String get colorValueClassName => 'TwBackgroundColor';
}
