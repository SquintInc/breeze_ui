import 'package:flutter/material.dart';
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
                    AnimatedDiv(
                      style: TwStyle(
                        width: w_frac_1_3,
                        height: toggled ? h_64 : h_36,
                        backgroundColor: bg_slate_800,
                        transition: transition_all,
                      ),
                    ),
                    AnimatedDiv(
                      style: TwStyle(
                        width: w_frac_1_3,
                        height: toggled ? h_64 : h_36,
                        backgroundColor: bg_slate_700,
                        transition: transition_all,
                      ),
                    ),
                    AnimatedDiv(
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
                          const AnimatedDiv(
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
                          AnimatedDiv(
                            alignment: Alignment.topLeft,
                            style: TwStyle(
                              width: w_frac_1_2,
                              height: toggled ? h_64 : h_full,
                              backgroundColor: bg_blue_400,
                              transition: transition_all,
                            ),
                            child: const TwColumn(
                              children: [
                                AnimatedDiv(
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
                    AnimatedDiv(
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
                      focused: const TwStyle(
                        backgroundColor: bg_amber_700,
                      ),
                      selected: const TwStyle(
                        backgroundColor: bg_indigo_50,
                      ),
                      dragged: const TwStyle(
                        backgroundColor: bg_blue_900,
                      ),
                      child: AnimatedDiv(
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
                          backgroundColor: bg_pink_700,
                        ),
                        selected: const TwStyle(
                          backgroundColor: bg_pink_50,
                        ),
                        dragged: const TwStyle(
                          backgroundColor: bg_pink_900,
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
