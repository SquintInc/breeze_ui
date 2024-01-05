import 'package:flutter/material.dart';
import 'package:tailwind_elements/base.dart';
import 'package:tailwind_elements/widgets.dart';
import 'package:tailwind_elements/widgets/inherited/parent_constraints_data.dart';
import 'package:tailwind_elements/widgets/stateless/animated_div.dart';
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
  bool toggled = false;

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
                    Div(
                      style: TwStyle(
                        width: w_frac_1_3,
                        height: toggled ? h_64 : h_36,
                        backgroundColor: bg_slate_800,
                      ),
                    ),
                    Div(
                      style: TwStyle(
                        width: w_frac_1_3,
                        height: toggled ? h_64 : h_36,
                        backgroundColor: bg_slate_700,
                      ),
                    ),
                    Div(
                      style: TwStyle(
                        width: w_frac_1_3,
                        height: toggled ? h_64 : h_36,
                        backgroundColor: bg_slate_600,
                      ),
                      child: TwRow(
                        children: [
                          Div(
                            style: TwStyle(
                              width: w_frac_1_2,
                              height: toggled ? h_64 : h_36,
                              backgroundColor: bg_red_500,
                            ),
                          ),
                          Div(
                            style: TwStyle(
                              width: w_frac_1_2,
                              height: toggled ? h_64 : h_36,
                              backgroundColor: bg_blue_400,
                            ),
                            child: const TwColumn(
                              children: [
                                Div(
                                  style: TwStyle(
                                    width: w_frac_1_2,
                                    height: h_frac_1_3,
                                    backgroundColor: bg_green_500,
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
                      useInputDetectors: true,
                      style: TwStyle(
                        width: w_frac_1_3,
                        height: toggled ? h_64 : h_36,
                        backgroundColor: bg_amber_500,
                      ),
                      pressed: TwStyle(
                        backgroundColor: bg_red_600,
                      ),
                      hovered: TwStyle(
                        backgroundColor: bg_amber_400,
                      ),
                      focused: TwStyle(
                        backgroundColor: bg_amber_700,
                      ),
                      selected: TwStyle(
                        backgroundColor: bg_amber_800,
                      ),
                      dragged: TwStyle(
                        backgroundColor: bg_blue_900,
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
