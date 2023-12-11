import 'package:tailwind_elements/config/builder/builders/generators.dart';
import 'package:tailwind_elements/config/options/sizing/min_height.dart';

/// A [ConstantsGenerator] used to generate Tailwind 'min-h' constants
/// to the .g.dart part file.
class MinHeightBuilder extends ConstantsGenerator {
  const MinHeightBuilder(super.options, super.config);

  @override
  String get themeConfigKey => 'minHeight';

  @override
  Map<String, String> get variablePrefixToValueClassName => {
        'min-h': (TwMinHeight).toString(),
      };
}
