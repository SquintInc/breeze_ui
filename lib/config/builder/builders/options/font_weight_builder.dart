import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'package:tailwind_elements/config/builder/builders/generators.dart';

/// A [ConstantsGenerator] used to generate Tailwind 'font-*' font weight
/// constants to the .g.dart part file.
class FontWeightBuilder extends ConstantsGenerator {
  const FontWeightBuilder(
    super.options,
    super.config, {
    super.generatorType = GeneratorType.rawValues,
  });

  @override
  String get themeConfigKey => 'fontWeight';

  @override
  Map<String, String> get variablePrefixToValueClassName => {
        'font': 'TwFontWeight',
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
        final String lineDeclaration = CodeWriter.dartLineDeclaration(
          variableName: varName,
          valueConstructor: '${prefix.value}(${themeValue.value})',
        );
        return lineDeclaration;
      });
      return prefixDeclarations.join('\n');
    });
    return allDeclarations.join('\n');
  }
}
