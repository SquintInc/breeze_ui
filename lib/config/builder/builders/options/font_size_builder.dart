import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'package:tailwind_elements/config/builder/builders/generators.dart';
import 'package:tailwind_elements/config/options/typography/font_size.dart';
import 'package:tailwind_elements/config/options/units.dart';

/// A [ConstantsGenerator] used to generate Tailwind 'text-*' font size
/// constants to the .g.dart part file.
class FontSizeBuilder extends ConstantsGenerator {
  const FontSizeBuilder(super.options, super.config);

  @override
  String get themeConfigKey => 'fontSize';

  @override
  Map<String, String> get variablePrefixToValueClassName => {
        'text': (TwFontSize).toString(),
      };

  @override
  Future<String> generate(
    final LibraryReader library,
    final BuildStep buildStep,
  ) async {
    final Map<String, dynamic> themeValues =
        config.getRawValues(themeConfigKey);
    final allDeclarations = variablePrefixToValueClassName.entries.map((
      final prefix,
    ) {
      final prefixDeclarations = themeValues.entries.map((final themeValue) {
        final String varName = CodeWriter.variableName(
          prefix.key,
          themeValue.key == 'DEFAULT' ? '' : themeValue.key.toSnakeCase(),
        );
        final List<dynamic> values = themeValue.value;
        final String fontSizeString = values[0];
        final Map<String, dynamic> additionalProps = values[1];
        final TwUnit fontSizeValue = TwUnit.parse(fontSizeString);
        final String lineHeightString = additionalProps['lineHeight'] ?? '1';
        final TwUnit lineHeightValue = TwUnit.parse(lineHeightString);

        final String lineDeclaration = CodeWriter.dartLineDeclaration(
          variableName: varName,
          valueConstructor:
              '${prefix.value}(${fontSizeValue.toDartConstructor()}, TwLineHeight(${lineHeightValue.toDartConstructor()}))',
        );
        return lineDeclaration;
      });
      return prefixDeclarations.join('\n');
    });
    return allDeclarations.join('\n');
  }
}