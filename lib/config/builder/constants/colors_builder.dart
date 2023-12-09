import 'package:tailwind_elements/config/builder/constants/constants_generator.dart';

/// A [ColorConstantsGenerator] used to generate Tailwind 'height' constants
/// to the .g.dart part file.
///
/// Generates [TwHeight] constants.
class ColorsBuilder extends ColorConstantsGenerator {
  const ColorsBuilder(super.options, super.config);

  @override
  String get themeConfigKey => 'colors';

  @override
  String get variablePrefix => '';

  /// Hard-coded string as 'TwColor' from [TwColor], since build_runner can't
  /// resolve dart:ui types when running the build.
  ///
  /// See 'package:tailwind_elements/config/options/theme/colors.dart'
  @override
  String get colorValueClassName => 'TwColor';
}
