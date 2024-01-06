import 'package:flutter/material.dart';
import 'package:tailwind_elements/base.dart';
import 'package:tailwind_elements/widgets.dart';
import 'package:tailwind_elements/widgets/inherited/parent_constraints_data.dart';
import 'package:tailwind_elements/widgets/stateless/div.dart';
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
  bool toggled = true;
  MaterialStatesController statesController = MaterialStatesController();

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
            backgroundColor: bg_black,
          ),
          child: ParentConstraintsData(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width,
            ),
            child: TwColumn(
              gap: gap_y_4,
              scrollable: true,
              children: [
                TwRow(
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
                    TwAnimationGroup(
                      child: TwDiv(
                        enableInputDetectors: true,
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
                            backgroundColor: bg_pink_900,
                          ),
                          canRequestFocus: true,
                        ),
                      ),
                    ),
                  ],
                ),
                TextButton(
                  child: Text('Toggle: $toggled'),
                  onPressed: () {
                    setState(() {
                      toggled = !toggled;
                    });
                  },
                ),
                TwRow(
                  children: [
                    TwButton(
                      onTap: () {
                        // print current time in epoch
                        print(DateTime.now().millisecondsSinceEpoch);
                      },
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
                      child: const TwText('Button Text'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
