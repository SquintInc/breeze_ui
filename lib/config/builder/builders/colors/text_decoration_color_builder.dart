import 'package:tailwind_elements/config/builder/builders/generators.dart';

/// A [ColorConstantsGenerator] used to generate Tailwind 'decoration-*' colors
/// to the .g.dart part file.
class TextDecorationColorBuilder extends ColorConstantsGenerator {
  const TextDecorationColorBuilder(super.options, super.config);

  @override
  String get themeConfigKey => 'textDecorationColor';

  @override
  String get variablePrefix => 'decoration';

  @override
  String get colorValueClassName => 'TwTextDecorationColor';
}
