import 'package:flutter/material.dart';
import 'package:tailwind_elements/base.dart';
import 'package:tailwind_elements/widgets.dart';
import 'package:tailwind_elements_playground/tailwind_config.dart';

void main() {
  runApp(const TailwindElementsPlayground());
}

class TailwindElementsPlayground extends StatefulWidget {
  const TailwindElementsPlayground({super.key});

  @override
  State createState() {
    return _TailwindElementsPlaygroundState();
  }
}

class _TailwindElementsPlaygroundState
    extends State<TailwindElementsPlayground> {
  TwTransitionProperty properties = transition_all;
  String text = 'Hello world!';
  final statesController = MaterialStatesController();
  final textStatesController = MaterialStatesController();

  @override
  Widget build(final BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: bg_blue_500.color),
        useMaterial3: true,
      ),
      home: Material(
        child: TwDiv(
          style: const TwStyle(
            height: h_96,
            backgroundColor: bg_white,
          ),
          child: TwColumn(
            gap: gap_y_4,
            scrollable: true,
            children: [
              TwButton(
                style: const TwStyle(
                  width: w_96,
                  height: h_20,
                  backgroundColor: bg_green_400,
                  transition: transition_all,
                  transitionDuration: duration_150,
                  borderRadius: TwBorderRadius.all(rounded_full),
                ),
                hovered: const TwStyle(
                  backgroundColor: bg_blue_400,
                  borderRadius: TwBorderRadius.all(rounded_lg),
                ),
                pressed: const TwStyle(
                  backgroundColor: bg_red_400,
                  // borderRadius: TwBorderRadius.all(rounded_full),
                ),
                child: const TwText(
                  'Top Button',
                  style: TwStyle(
                    fontSize: text_2xl,
                    fontWeight: font_bold,
                    textColor: text_white,
                  ),
                ),
                onPressed: () {
                  setState(() {
                    properties = transition_colors;
                    text = 'Test 123';
                  });
                },
              ),
              const TwDiv(
                style: TwStyle(
                  width: w_96,
                  height: h_20,
                  backgroundColor: bg_white,
                  transition: transition_colors,
                  transitionDuration: duration_150,
                ),
                hovered: TwStyle(
                  backgroundColor: bg_blue_400,
                ),
                child: TwText(
                  'Top Button',
                  style: TwStyle(
                    fontSize: text_2xl,
                    fontWeight: font_bold,
                    textColor: text_white,
                  ),
                ),
              ),
              TwButton(
                style: const TwStyle(
                  width: w_14,
                  height: h_9,
                  backgroundColor: bg_green_400,
                ),
                child: const TwText('Bottom Button'),
                onPressed: () {},
              ),
              const TwTextField(
                style: TwStyle(
                  border: TwBorder.all(border_8),
                  borderRadius: TwBorderRadius.all(rounded_full),
                  borderColor: border_green_400,
                  padding: TwPadding.all(p_6),
                ),
                hovered: TwStyle(
                  border: TwBorder.all(border_2),
                  borderRadius: TwBorderRadius.all(rounded_full),
                  borderColor: border_blue_400,
                  padding: TwPadding.all(p_0),
                ),
              ),
              TwAnimationGroup(
                statesController: statesController,
                child: TwDiv(
                  alignment: Alignment.center,
                  selected: const TwStyle(
                    backgroundColor: bg_cyan_700,
                  ),
                  style: const TwStyle(
                    width: w_96,
                    height: h_96,
                    border: TwBorder.all(border_8),
                    borderRadius: TwBorderRadius.all(rounded_3xl),
                    borderColor: border_green_600,
                    backgroundColor: bg_white,
                    boxShadow: shadow_lg,
                    boxShadowColor: shadow_gray_500,
                    transition: transition_all,
                    transitionDuration: duration_300,
                    transitionTimingFn: ease_in_out,
                  ),
                  hovered: const TwStyle(
                    width: w_144,
                    maxWidth: max_w_screen_2xl,
                    backgroundColor: bg_black,
                    borderRadius: TwBorderRadius.all(rounded_full),
                    borderColor: border_blue_600,
                    // opacity: opacity_50,
                    boxShadow: shadow_2xl,
                    boxShadowColor: shadow_black,
                  ),
                  pressed: const TwStyle(
                    backgroundColor: bg_red_500,
                    border: TwBorder.all(border_2),
                    // borderRadius: TwBorderRadius.all(rounded_full),
                    // width: w_frac_3_4,
                  ),
                  disabled: const TwStyle(
                    backgroundColor: bg_gray_500,
                  ),
                  dragged: const TwStyle(
                    backgroundColor: bg_purple_500,
                  ),
                  child: TwAnimatedText(
                    text,
                    style: const TwStyle(
                      fontSize: text_2xl,
                      fontWeight: font_bold,
                      textColor: text_white,
                      transition: transition_all,
                      transitionDuration: duration_1000,
                    ),
                    hovered: const TwStyle(
                      // fontSize: text_4xl,
                      textColor: text_gray_500,
                    ),
                    pressed: const TwStyle(
                      // fontSize: text_4xl,
                      textColor: text_yellow_500,
                    ),
                  ),
                ),
              ),
              TwAnimationGroup(
                statesController: textStatesController,
                child: const TwAnimatedText.rich(
                  TwTextSpan(
                    children: [
                      TwTextSpan(
                        text: 'Hello ',
                      ),
                      WidgetSpan(
                        child: TwAnimatedText(
                          'world!',
                          style: TwStyle(
                            fontSize: text_2xl,
                            fontWeight: font_bold,
                            textColor: text_black,
                            transition: transition_all,
                            transitionDuration: duration_300,
                            transitionDelay: delay_1000,
                          ),
                          hovered: TwStyle(
                            // fontSize: text_4xl,
                            textColor: text_gray_500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  style: TwStyle(
                    fontSize: text_2xl,
                    fontWeight: font_bold,
                    textColor: text_indigo_700,
                    transition: transition_all,
                    transitionDuration: duration_1000,
                    transitionDelay: delay_300,
                  ),
                  hovered: TwStyle(
                    // fontSize: text_4xl,
                    textColor: text_gray_500,
                  ),
                  pressed: TwStyle(
                    // fontSize: text_4xl,
                    textColor: text_yellow_500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
