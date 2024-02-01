import 'package:flutter/material.dart';
import 'package:tailwind_elements/base.dart';
import 'package:tailwind_elements/widgets.dart';
import 'package:tailwind_elements_playground/tailwind_config.dart';
import 'package:vector_graphics/vector_graphics.dart';

// ignore_for_file: avoid_print
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
  bool toggled = true;
  bool hideSwitch = false;
  final MaterialStatesController statesController = MaterialStatesController();

  @override
  Widget build(final BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: bg_blue_500.color),
        useMaterial3: true,
      ),
      home: Material(
        child: Div(
          style: const TwStyle(
            height: h_96,
            backgroundColor: bg_slate_50,
            backgroundImage: DecorationImage(
              image: NetworkImage(
                'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg',
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: ParentConstraintsData(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width,
            ),
            child: TwColumn(
              gap: gap_y_4,
              scrollable: true,
              children: [
                Row(
                  children: [
                    TwCheckbox(
                      value: toggled,
                      isTristate: true,
                      checkedIcon: const IconDataSvg(
                        AssetBytesLoader('assets/checkmark.svg.vec'),
                      ),
                      style: const TwStyle(
                        backgroundColor: bg_indigo_200,
                        transition: transition_all,
                        width: w_4,
                        height: h_4,
                        textColor: text_indigo_800,
                      ),
                      selected: const TwStyle(
                        backgroundColor: bg_indigo_300,
                      ),
                      hovered: const TwStyle(
                        backgroundColor: bg_indigo_400,
                      ),
                      onToggled: (final bool? value) {},
                    ),
                    TwCheckbox(
                      value: null,
                      isTristate: true,
                      checkedIcon: const IconDataSvg(
                        AssetBytesLoader('assets/checkmark.svg.vec'),
                      ),
                      style: const TwStyle(
                        backgroundColor: bg_indigo_200,
                        transition: transition_all,
                        width: w_4,
                        height: h_4,
                        textColor: text_indigo_800,
                      ),
                      selected: const TwStyle(
                        backgroundColor: bg_indigo_300,
                      ),
                      hovered: const TwStyle(
                        backgroundColor: bg_indigo_400,
                      ),
                      onToggled: (final bool? value) {},
                    ),
                    TwCheckbox(
                      value: toggled,
                      isToggleable: false,
                      checkedIcon: const IconDataSvg(
                        AssetBytesLoader('assets/checkmark.svg.vec'),
                      ),
                      style: const TwStyle(
                        backgroundColor: bg_indigo_200,
                        transition: transition_all,
                        width: w_4,
                        height: h_4,
                        textColor: text_indigo_800,
                      ),
                      selected: const TwStyle(
                        backgroundColor: bg_indigo_300,
                      ),
                      hovered: const TwStyle(
                        backgroundColor: bg_indigo_400,
                      ),
                      onToggled: (final bool? value) {},
                    ),
                    TwMaterialStatesGroup(
                      child: TwSwitch(
                        value: toggled,
                        style: const TwStyle(
                          backgroundColor: bg_gray_200,
                          transition: transition_all,
                          width: w_12,
                          height: h_6,
                          padding: TwPadding.xy(px_0_5, py_0_5),
                          borderRadius: TwBorderRadius.all(rounded_full),
                        ),
                        pressed: const TwStyle(
                          backgroundColor: bg_indigo_400,
                        ),
                        selected: const TwStyle(
                          backgroundColor: bg_indigo_500,
                        ),
                        onToggled: (final bool? value) {
                          print('switch toggled: $value');
                        },
                        thumb: const TwDiv(
                          style: TwStyle(
                            backgroundColor: bg_white,
                            transition: transition_all,
                            width: w_5,
                            height: h_5,
                            borderRadius: TwBorderRadius.all(rounded_full),
                          ),
                          hovered: TwStyle(
                            backgroundColor: bg_blue_400,
                          ),
                          selected: TwStyle(
                            backgroundColor: bg_red_500,
                          ),
                        ),
                      ),
                    ),
                    TwSwitch(
                      value: toggled,
                      style: const TwStyle(
                        backgroundColor: bg_gray_200,
                        transition: transition_all,
                        width: w_12,
                        height: h_6,
                        padding: TwPadding.xy(px_0_5, py_0_5),
                        borderRadius: TwBorderRadius.all(rounded_full),
                      ),
                      pressed: const TwStyle(
                        backgroundColor: bg_indigo_400,
                      ),
                      selected: const TwStyle(
                        backgroundColor: bg_indigo_500,
                      ),
                      onToggled: (final bool? value) {
                        print('switch toggled: $value');
                      },
                      thumb: const Div(
                        style: TwStyle(
                          backgroundColor: bg_white,
                          width: w_5,
                          height: h_5,
                          borderRadius: TwBorderRadius.all(rounded_full),
                        ),
                      ),
                    ),
                  ],
                ),
                TwRow(
                  scrollable: true,
                  children: [
                    TwDiv(
                      style: TwStyle(
                        width: w_frac_1_3,
                        height: toggled ? h_64 : h_36,
                        backgroundColor: bg_slate_800,
                        transition: transition_all,
                      ),
                    ),
                    TwDiv(
                      style: TwStyle(
                        width: w_frac_1_3,
                        height: toggled ? h_64 : h_36,
                        backgroundColor: bg_slate_700,
                        transition: transition_all,
                      ),
                    ),
                    TwDiv(
                      style: TwStyle(
                        width: w_frac_1_3,
                        height: toggled ? h_64 : h_36,
                        backgroundColor: bg_slate_600,
                        transition: transition_all,
                      ),
                      hovered: const TwStyle(
                        backgroundColor: bg_slate_500,
                      ),
                      child: TwRow(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const TwDiv(
                            style: TwStyle(
                              width: w_frac_1_2,
                              height: h_frac_1_2,
                              backgroundColor: bg_red_500,
                              transition: transition_all,
                            ),
                            hovered: TwStyle(
                              backgroundColor: bg_red_400,
                            ),
                          ),
                          TwDiv(
                            alignment: Alignment.topLeft,
                            style: TwStyle(
                              width: w_frac_1_2,
                              height: toggled ? h_64 : h_full,
                              backgroundColor: bg_blue_400,
                              transition: transition_all,
                            ),
                            child: const TwColumn(
                              children: [
                                TwDiv(
                                  style: TwStyle(
                                    width: w_frac_1_2,
                                    height: h_frac_1_3,
                                    backgroundColor: bg_green_500,
                                    transition: transition_all,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                TwRow(
                  children: [
                    TwMaterialStatesGroup(
                      child: TwDiv(
                        enableInputDetectors: true,
                        isDraggable: true,
                        style: TwStyle(
                          width: w_frac_1_3,
                          height: toggled ? h_64 : h_36,
                          backgroundColor: bg_amber_500,
                          transition: transition_all,
                        ),
                        pressed: const TwStyle(
                          backgroundColor: bg_red_600,
                          width: w_64,
                        ),
                        hovered: const TwStyle(
                          backgroundColor: bg_amber_400,
                          width: w_frac_2_3,
                        ),
                        selected: const TwStyle(
                          backgroundColor: bg_indigo_50,
                        ),
                        dragged: const TwStyle(
                          backgroundColor: bg_blue_900,
                        ),
                        child: TwDiv(
                          style: TwStyle(
                            width: toggled ? w_frac_1_2 : w_64,
                            height: toggled ? h_4 : h_frac_1_3,
                            backgroundColor: bg_pink_500,
                            transition: transition_all,
                          ),
                          pressed: const TwStyle(
                            backgroundColor: bg_pink_600,
                            width: w_64,
                          ),
                          hovered: const TwStyle(
                            backgroundColor: bg_pink_400,
                            width: w_frac_2_3,
                          ),
                          focused: const TwStyle(
                            backgroundColor: bg_pink_50,
                            transitionDuration: duration_0,
                          ),
                          selected: const TwStyle(
                            backgroundColor: bg_pink_50,
                          ),
                          dragged: const TwStyle(
                            backgroundColor: bg_green_900,
                          ),
                          onDragged: (final bool value) {
                            print('div dragged: $value');
                          },
                          canRequestFocus: true,
                          isDraggable: true,
                        ),
                      ),
                    ),
                  ],
                ),
                TwRow(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TwButton(
                      onPressed: () {
                        setState(() {
                          toggled = !toggled;
                        });
                      },
                      style: TwStyle(
                        borderColor: border_transparent,
                        borderRadius: const TwBorderRadius.all(rounded_full),
                        padding: const TwPadding.xy(px_2_5, py_1),
                        backgroundColor: TwBackgroundColor.fromColor(
                          bg_indigo_600.color.withOpacity(0.2),
                        ),
                        fontSize: text_xs,
                        textColor: text_white,
                        boxShadow: shadow_sm,
                        fontWeight: font_bold,
                        transition: transition_all,
                        backdropBlur: backdrop_blur,
                      ),
                      hovered: TwStyle(
                        backgroundColor: TwBackgroundColor.fromColor(
                          bg_indigo_600.color.withOpacity(0.2),
                        ),
                        backdropBlur: backdrop_blur_sm,
                      ),
                      focused: const TwStyle(
                        backgroundColor: bg_indigo_400,
                        borderColor: border_blue_400,
                      ),
                      disabled: const TwStyle(
                        backgroundColor: bg_indigo_200,
                      ),
                      child: Text('Toggle: $toggled'),
                    ),
                  ],
                ),
                TwRow(
                  gap: gap_x_4,
                  children: [
                    TwButton(
                      onPressed: () {
                        // print current time in epoch
                        print(
                          'Button pressed! Current epoch: ${DateTime.now().millisecondsSinceEpoch}',
                        );
                      },
                      isDisabled: !toggled,
                      style: const TwStyle(
                        borderColor: border_transparent,
                        borderRadius: TwBorderRadius.all(rounded_full),
                        padding: TwPadding.xy(px_2_5, py_1),
                        backgroundColor: bg_indigo_600,
                        fontSize: text_xs,
                        textColor: text_white,
                        boxShadow: shadow_sm,
                        fontWeight: font_bold,
                        transition: transition_all,
                      ),
                      hovered: const TwStyle(
                        backgroundColor: bg_indigo_500,
                      ),
                      focused: const TwStyle(
                        backgroundColor: bg_indigo_400,
                        borderColor: border_blue_400,
                      ),
                      disabled: const TwStyle(
                        backgroundColor: bg_indigo_200,
                      ),
                      child: const TwText('Button Text'),
                    ),
                    const TwIcon(
                      icon: IconDataFont(Icons.check),
                    ),
                    const TwIcon(
                      icon: IconDataSvg(
                        AssetBytesLoader('assets/checkmark.svg.vec'),
                      ),
                    ),
                  ],
                ),
                const Div(
                  style: TwStyle(
                    width: w_screen,
                    height: h_screen,
                    backgroundColor: bg_red_500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
