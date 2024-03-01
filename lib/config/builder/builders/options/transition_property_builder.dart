import 'package:breeze_ui/config/builder/builders/generators.dart';
import 'package:breeze_ui/config/options/transitions/transition_property.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

/// A [ConstantsGenerator] used to generate Tailwind 'transition-*' constants to
/// the .g.dart part file.
class TransitionPropertyBuilder extends ConstantsGenerator {
  const TransitionPropertyBuilder(
    super.options,
    super.config, {
    super.generatorType = GeneratorType.rawValues,
  });

  @override
  String get themeConfigKey => 'transitionProperty';

  @override
  Map<String, String> get variablePrefixToValueClassName => {
        'transition': (TwTransitionProperty).toString(),
      };

  @override
  Future<String> generate(
    final LibraryReader library,
    final BuildStep buildStep,
  ) async {
    final Map<String, String> themeValues = getThemeValues()
        .map((final key, final value) => MapEntry(key, value.toString()));
    final allDeclarations = variablePrefixToValueClassName.entries.map((
      final prefix,
    ) {
      final prefixDeclarations = themeValues.entries.map((final themeValue) {
        final String varName = CodeWriter.variableName(
          prefix.key,
          themeValue.key == 'DEFAULT' ? '' : themeValue.key.toSnakeCase(),
        );

        // Process transition property string value
        final transitionProperties = themeValue.value
            .split(',')
            .map((final tp) => tp.trim())
            .map((final tp) => TransitionProperty.fromCss(tp))
            .toSet()
            .map((final tp) => '${tp.runtimeType}.${tp.name}')
            .join(', ');

        final String lineDeclaration = CodeWriter.dartLineDeclaration(
          variableName: varName,
          valueConstructor: '${prefix.value}({$transitionProperties})',
        );
        return lineDeclaration;
      });
      return prefixDeclarations.join('\n');
    });
    return allDeclarations.join('\n');
  }
}
