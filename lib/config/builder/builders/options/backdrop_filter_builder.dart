import 'package:tailwind_elements/config/builder/builders/generators.dart';
import 'package:tailwind_elements/config/options/filters/backdrop_blur.dart';

/// A [ConstantsGenerator] used to generate Tailwind 'backdrop-blur-*' constants to the
/// .g.dart part file.
class BackdropBlurBuilder extends ConstantsGenerator {
  const BackdropBlurBuilder(super.options, super.config);

  @override
  String get themeConfigKey => 'backdropBlur';

  @override
  Map<String, String> get variablePrefixToValueClassName => {
        'backdrop-blur': (TwBackdropBlur).toString(),
      };
}
