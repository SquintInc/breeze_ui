import 'package:breeze_ui/config/builder/builders/generators.dart';
import 'package:breeze_ui/config/options/sizing/min_height.dart';

/// A [ConstantsGenerator] used to generate Tailwind 'min-h-*' min height
/// constants to the .g.dart part file.
class MinHeightBuilder extends ConstantsGenerator {
  const MinHeightBuilder(super.options, super.config);

  @override
  String get themeConfigKey => 'minHeight';

  @override
  Map<String, String> get variablePrefixToValueClassName => {
        'min-h': (TwMinHeight).toString(),
      };
}
