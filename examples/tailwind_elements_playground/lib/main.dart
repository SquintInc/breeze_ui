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
      home: Material(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const TwRow(
              mainAxisAlignment: MainAxisAlignment.center,
              gap: gap_x_24,
              children: [
                TwDiv(
                  style: TwStyle(
                    backgroundColor: bg_blue_500,
                    width: w_frac_1_12,
                    height: h_24,
                  ),
                ),
                TwDiv(
                  style: TwStyle(
                    backgroundColor: bg_blue_500,
                    width: w_frac_1_12,
                    height: h_24,
                  ),
                ),
              ],
            ),
            const TwColumn(
              mainAxisAlignment: MainAxisAlignment.center,
              gap: gap_y_4,
              children: [
                TwDiv(
                  style: TwStyle(
                    backgroundColor: bg_orange_500,
                    width: w_frac_1_12,
                    height: h_24,
                  ),
                ),
                TwDiv(
                  style: TwStyle(
                    backgroundColor: bg_yellow_500,
                    width: w_frac_1_12,
                    height: h_24,
                  ),
                ),
              ],
            ),
            const TwDiv(
              style: TwStyle(
                backgroundColor: bg_yellow_500,
                width: w_24,
                height: h_24,
                margin: TwMargin.all(m_4),
                padding: TwPadding.all(p_4),
                borderRadius: TwBorderRadius.all(rounded_md),
              ),
              alignment: Alignment.center,
              child: Text('Flutter Demo'),
            ),
            TwButton(
              onPressed: () {},
              animationDuration: const Duration(milliseconds: 100),
              style: const TwStyle(
                backgroundColor: bg_blue_500,
                margin: TwMargin.all(m_4),
                border: TwBorder.all(border_2),
                borderColor: border_neutral_500,
                padding: TwPadding.all(p_4),
                borderRadius: TwBorderRadius.all(rounded_md),
              ),
              hovered: const TwStyle(
                backgroundColor: bg_red_700,
                textColor: text_white,
                borderRadius: TwBorderRadius.all(rounded_full),
                border: TwBorder.all(border_8),
                borderColor: border_neutral_500,
              ),
              pressed: const TwStyle(
                backgroundColor: bg_green_700,
                textColor: text_green_500,
                borderRadius: TwBorderRadius.all(rounded_md),
                border: TwBorder.all(border_4),
                borderColor: border_black,
              ),
              child: const TwText(
                'Hello World!',
                style: TwTextStyle(
                  textColor: text_white,
                  fontSize: text_sm,
                  fontWeight: font_normal,
                ),
              ),
            ),
            const TwSizedBox(
              height: h_12,
            ),
            const TwDiv(
              style: TwStyle(
                padding: TwPadding.all(p_4),
                backgroundColor: bg_blue_700,
              ),
              child: TwText(
                'Hello World!',
                style: TwTextStyle(
                  textColor: text_white,
                  fontSize: text_sm,
                  fontWeight: font_normal,
                ),
              ),
            ),
            const TwDiv(
              style: TwStyle(
                width: w_56,
                height: h_6,
                margin: TwMargin.all(m_4),
                backgroundColor: bg_green_500,
              ),
            ),
            const TwDiv(
              style: TwStyle(
                width: w_frac_1_12,
                height: h_24,
                backgroundColor: bg_pink_500,
              ),
            ),
            const TwDiv(
              style: TwStyle(
                width: w_full,
                height: h_24,
                backgroundColor: bg_purple_500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
