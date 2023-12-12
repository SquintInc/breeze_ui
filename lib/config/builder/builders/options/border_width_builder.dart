import 'package:tailwind_elements/config/builder/builders/generators.dart';
import 'package:tailwind_elements/config/options/borders/border_width.dart';

/// A [ConstantsGenerator] used to generate Tailwind 'border-*' border width
/// constants to the .g.dart part file.
class BorderWidthBuilder extends ConstantsGenerator {
  const BorderWidthBuilder(super.options, super.config);

  @override
  String get themeConfigKey => 'borderWidth';

  @override
  Map<String, String> get variablePrefixToValueClassName {
    return {
      'border': (TwBorderAll).toString(),
      'border-x': (TwBorderX).toString(),
      'border-y': (TwBorderY).toString(),
      'border-t': (TwBorderTop).toString(),
      'border-r': (TwBorderRight).toString(),
      'border-b': (TwBorderBottom).toString(),
      'border-l': (TwBorderLeft).toString(),
    };
  }
}
