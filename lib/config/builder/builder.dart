import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'package:tailwind_elements/config/builder/builders/colors/background_color_builder.dart';
import 'package:tailwind_elements/config/builder/builders/colors/border_color_builder.dart';
import 'package:tailwind_elements/config/builder/builders/colors/box_shadow_color_builder.dart';
import 'package:tailwind_elements/config/builder/builders/colors/text_color_builder.dart';
import 'package:tailwind_elements/config/builder/builders/colors/text_decoration_color_builder.dart';
import 'package:tailwind_elements/config/builder/builders/options/border_radius_builder.dart';
import 'package:tailwind_elements/config/builder/builders/options/border_width_builder.dart';
import 'package:tailwind_elements/config/builder/builders/options/box_shadow_builder.dart';
import 'package:tailwind_elements/config/builder/builders/options/font_size_builder.dart';
import 'package:tailwind_elements/config/builder/builders/options/font_weight_builder.dart';
import 'package:tailwind_elements/config/builder/builders/options/gap_builder.dart';
import 'package:tailwind_elements/config/builder/builders/options/height_builder.dart';
import 'package:tailwind_elements/config/builder/builders/options/letter_spacing_builder.dart';
import 'package:tailwind_elements/config/builder/builders/options/line_height_builder.dart';
import 'package:tailwind_elements/config/builder/builders/options/margin_builder.dart';
import 'package:tailwind_elements/config/builder/builders/options/max_height_builder.dart';
import 'package:tailwind_elements/config/builder/builders/options/max_width_builder.dart';
import 'package:tailwind_elements/config/builder/builders/options/min_height_builder.dart';
import 'package:tailwind_elements/config/builder/builders/options/min_width_builder.dart';
import 'package:tailwind_elements/config/builder/builders/options/padding_builder.dart';
import 'package:tailwind_elements/config/builder/builders/options/text_decoration_thickness_builder.dart';
import 'package:tailwind_elements/config/builder/builders/options/transition_delay_builder.dart';
import 'package:tailwind_elements/config/builder/builders/options/transition_duration_builder.dart';
import 'package:tailwind_elements/config/builder/builders/options/transition_property_builder.dart';
import 'package:tailwind_elements/config/builder/builders/options/transition_timing_function_builder.dart';
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
      // Generate border constants
      BorderWidthBuilder(options, config),
      BorderRadiusBuilder(options, config),
      // Generate effect constants
      BoxShadowBuilder(options, config),
      // Generate sizing constants
      GapBuilder(options, config),
      WidthBuilder(options, config),
      MinWidthBuilder(options, config),
      MaxWidthBuilder(options, config),
      HeightBuilder(options, config),
      MinHeightBuilder(options, config),
      MaxHeightBuilder(options, config),
      // Generate spacing constants
      MarginBuilder(options, config),
      PaddingBuilder(options, config),
      // Generate transition constants
      TransitionPropertyBuilder(options, config),
      TransitionDurationBuilder(options, config),
      TransitionDelayBuilder(options, config),
      TransitionTimingFunctionBuilder(options, config),
      // Generate typography constants
      FontSizeBuilder(options, config),
      FontWeightBuilder(options, config),
      LineHeightBuilder(options, config),
      TextDecorationThicknessBuilder(options, config),
      LetterSpacingBuilder(options, config),
      // Generate colors
      BackgroundColorBuilder(options, config),
      BoxShadowColorBuilder(options, config),
      TextColorBuilder(options, config),
      BorderColorBuilder(options, config),
      TextDecorationColorBuilder(options, config),
    ],
    'tailwind_config',
  );
}
