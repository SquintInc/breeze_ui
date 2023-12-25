import 'package:tailwind_elements/config/builder/builders/generators.dart';
import 'package:tailwind_elements/config/options/effects/opacity.dart';

/// A [ConstantsGenerator] used to generate Tailwind 'opacity-*' constants to
/// the .g.dart part file.
class OpacityBuilder extends ConstantsGenerator {
  const OpacityBuilder(
    super.options,
    super.config, {
    super.generatorType = GeneratorType.rawValues,
  });

  @override
  String get themeConfigKey => 'opacity';

  @override
  Map<String, String> get variablePrefixToValueClassName => {
        'opacity': (TwOpacity).toString(),
      };
}
