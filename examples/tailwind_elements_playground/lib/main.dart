import 'package:flutter/material.dart';
import 'package:tailwind_elements/base.dart';
import 'package:tailwind_elements/widgets.dart';
import 'package:tailwind_elements_playground/tailwind_config.dart';

void main() {
  runApp(const TailwindElementsPlayground());
}

class TailwindElementsPlayground extends StatelessWidget {
  const TailwindElementsPlayground({super.key});

  @override
  Widget build(final BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: bg_blue_500.color),
        useMaterial3: true,
      ),
      home: const Material(
        child: TwDiv(
          style: TwStyle(
            height: h_96,
            backgroundColor: bg_white,
          ),
          child: TwColumn(
            gap: gap_y_4,
            children: [
              TwButton(
                style: TwStyle(
                  width: w_frac_1_3,
                  height: h_20,
                  backgroundColor: bg_green_400,
                ),
                child: TwText('Top Button'),
              ),
              TwButton(
                style: TwStyle(
                  width: w_frac_1_3,
                  height: h_9,
                  backgroundColor: bg_green_400,
                ),
                child: TwText('Bottom Button'),
              ),
              TwTextField(
                style: TwTextInputStyle(
                  border: TwBorder.all(border_8),
                  borderRadius: TwBorderRadius.all(rounded_full),
                  borderColor: border_green_400,
                  padding: TwPadding.all(p_6),
                ),
                hovered: TwTextInputStyle(
                  border: TwBorder.all(border_2),
                  borderRadius: TwBorderRadius.all(rounded_full),
                  borderColor: border_blue_400,
                  padding: TwPadding.all(p_0),
                ),
              ),
              TwDiv(
                style: TwStyle(
                  width: w_96,
                  height: h_96,
                  border: TwBorder.all(border_8),
                  borderRadius: TwBorderRadius.all(rounded_3xl),
                  borderColor: border_green_600,
                  backgroundColor: bg_green_500,
                  boxShadow: shadow_lg,
                  transition: transition_all,
                  transitionDuration: duration_150,
                  transitionTimingFn: ease_in_out,
                ),
                hovered: TwStyle(
                  width: w_96,
                  maxWidth: max_w_screen_2xl,
                  backgroundColor: bg_blue_500,
                  borderRadius: TwBorderRadius.all(rounded_full),
                  opacity: opacity_50,
                  boxShadow: shadow_2xl,
                  boxShadowColor: shadow_black,
                ),
                pressed: TwStyle(
                  backgroundColor: bg_red_500,
                  width: w_144,
                ),
                disabled: TwStyle(
                  backgroundColor: bg_gray_500,
                ),
                dragged: TwStyle(
                  backgroundColor: bg_purple_500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
