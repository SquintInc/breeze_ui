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
            backgroundColor: bg_blue_200,
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
            ],
          ),
        ),
      ),
    );
  }
}
