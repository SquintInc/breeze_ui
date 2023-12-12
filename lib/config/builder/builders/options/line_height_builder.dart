import 'package:tailwind_elements/config/builder/builders/generators.dart';
import 'package:tailwind_elements/config/options/typography/line_height.dart';

/// A [ConstantsGenerator] used to generate Tailwind 'leading-*' line height
/// constants to the .g.dart part file.
class LineHeightBuilder extends ConstantsGenerator {
  const LineHeightBuilder(super.options, super.config);

  @override
  String get themeConfigKey => 'lineHeight';

  @override
  Map<String, String> get variablePrefixToValueClassName => {
        'leading': (TwLineHeight).toString(),
      };
}
