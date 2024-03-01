import 'package:breeze_ui/config/builder/builders/generators.dart';

/// A [ColorConstantsGenerator] used to generate Tailwind 'text-*' colors
/// to the .g.dart part file.
class TextColorBuilder extends ColorConstantsGenerator {
  const TextColorBuilder(super.options, super.config);

  @override
  String get themeConfigKey => 'textColor';

  @override
  String get variablePrefix => 'text';

  @override
  String get colorValueClassName => 'TwTextColor';
}
