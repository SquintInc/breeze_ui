import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

// Explicitly import template files to help invalidate asset graph for build_runner
// ignore: unused_import
import 'package:tailwind_elements/config/builder/config_functions.template.dart';
import 'package:tailwind_elements/config/builder/constants/colors/background_color_builder.dart';
import 'package:tailwind_elements/config/builder/constants/colors/border_color_builder.dart';
import 'package:tailwind_elements/config/builder/constants/colors/box_shadow_color_builder.dart';
import 'package:tailwind_elements/config/builder/constants/colors/text_color_builder.dart';
import 'package:tailwind_elements/config/builder/constants/height_builder.dart';
import 'package:tailwind_elements/config/builder/constants/margin_builder.dart';
import 'package:tailwind_elements/config/builder/constants/max_height_builder.dart';
import 'package:tailwind_elements/config/builder/constants/max_width_builder.dart';
import 'package:tailwind_elements/config/builder/constants/min_height_builder.dart';
import 'package:tailwind_elements/config/builder/constants/min_width_builder.dart';
import 'package:tailwind_elements/config/builder/constants/padding_builder.dart';
import 'package:tailwind_elements/config/builder/constants/width_builder.dart';
import 'package:tailwind_elements/config/builder/tailwind_config.dart';
import 'package:tailwind_elements/config/builder/tailwind_config_builder.dart';

Builder tailwindConfigBuilder(final BuilderOptions options) {
  final config = TailwindConfig.empty();
  // All shared part builders must run sequentially
  // TailwindConfigBuilder needs to run first to generate the config in-memory
  return SharedPartBuilder(
    [
      // Generate main config in-memory first
      TailwindConfigBuilder(options, config),
      // Generate constants
      WidthBuilder(options, config),
      MinWidthBuilder(options, config),
      MaxWidthBuilder(options, config),
      HeightBuilder(options, config),
      MinHeightBuilder(options, config),
      MaxHeightBuilder(options, config),
      MarginBuilder(options, config),
      PaddingBuilder(options, config),
      // Generate colors
      BackgroundColorBuilder(options, config),
      BoxShadowColorBuilder(options, config),
      TextColorBuilder(options, config),
      BorderColorBuilder(options, config),
    ],
    'tailwind_config',
  );
}
