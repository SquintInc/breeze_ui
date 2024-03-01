import 'package:breeze_ui/config/builder/builders/generators.dart';
import 'package:breeze_ui/config/options/filters/backdrop_blur.dart';

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
