import 'package:breeze_ui/config/builder/builders/generators.dart';
import 'package:breeze_ui/config/options/sizing/max_height.dart';

/// A [ConstantsGenerator] used to generate Tailwind 'max-h-*' max height
/// constants to the .g.dart part file.
class MaxHeightBuilder extends ConstantsGenerator {
  const MaxHeightBuilder(super.options, super.config);

  @override
  String get themeConfigKey => 'maxHeight';

  @override
  Map<String, String> get variablePrefixToValueClassName => {
        'max-h': (TwMaxHeight).toString(),
      };
}
