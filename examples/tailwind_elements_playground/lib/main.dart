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
  Widget build(BuildContext context) {
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
              alignment: Alignment.centerLeft,
              animationDuration: const Duration(milliseconds: 100),
              style: const TwStyle(
                backgroundColor: bg_blue_500,
                width: w_32,
                height: h_16,
                margin: TwMargin.all(m_4),
                padding: TwPadding.x(px_1),
                borderRadius: TwBorderRadius.all(rounded_full),
                border: TwBorder.all(border_2),
                borderColor: border_neutral_500,
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
                'Hello World 123!',
                style: TwTextStyle(
                  textColor: text_white,
                  fontSize: text_2xl,
                  fontWeight: font_normal,
                ),
              ),
            ),
            const TwSizedBox(
              height: h_12,
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
