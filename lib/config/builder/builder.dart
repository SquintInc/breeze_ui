import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'package:tailwind_elements/config/builder/builders/colors/background_color_builder.dart';
import 'package:tailwind_elements/config/builder/builders/colors/border_color_builder.dart';
import 'package:tailwind_elements/config/builder/builders/colors/box_shadow_color_builder.dart';
import 'package:tailwind_elements/config/builder/builders/colors/text_color_builder.dart';
import 'package:tailwind_elements/config/builder/builders/options/border_radius_builder.dart';
import 'package:tailwind_elements/config/builder/builders/options/border_width_builder.dart';
import 'package:tailwind_elements/config/builder/builders/options/box_shadow_builder.dart';
import 'package:tailwind_elements/config/builder/builders/options/font_size_builder.dart';
import 'package:tailwind_elements/config/builder/builders/options/font_weight_builder.dart';
import 'package:tailwind_elements/config/builder/builders/options/height_builder.dart';
import 'package:tailwind_elements/config/builder/builders/options/line_height_builder.dart';
import 'package:tailwind_elements/config/builder/builders/options/margin_builder.dart';
import 'package:tailwind_elements/config/builder/builders/options/max_height_builder.dart';
import 'package:tailwind_elements/config/builder/builders/options/max_width_builder.dart';
import 'package:tailwind_elements/config/builder/builders/options/min_height_builder.dart';
import 'package:tailwind_elements/config/builder/builders/options/min_width_builder.dart';
import 'package:tailwind_elements/config/builder/builders/options/padding_builder.dart';
import 'package:tailwind_elements/config/builder/builders/options/width_builder.dart'; // Explicitly import template files to help invalidate asset graph for build_runner
// ignore: unused_import
import 'package:tailwind_elements/config/builder/config_functions.template.dart';
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
      BorderWidthBuilder(options, config),
      BorderRadiusBuilder(options, config),
      BoxShadowBuilder(options, config),
      FontSizeBuilder(options, config),
      FontWeightBuilder(options, config),
      LineHeightBuilder(options, config),
      // Generate colors
      BackgroundColorBuilder(options, config),
      BoxShadowColorBuilder(options, config),
      TextColorBuilder(options, config),
      BorderColorBuilder(options, config),
    ],
    'tailwind_config',
  );
}
