import 'package:breeze_ui/config/builder/builders/generators.dart';
import 'package:breeze_ui/config/options/typography/line_height.dart';

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
