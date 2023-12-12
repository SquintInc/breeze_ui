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
      home: const Material(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TwDiv(
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
            TwSizedBox(
              height: h_12,
            ),
            TwDiv(
              style: TwStyle(
                width: w_56,
                height: h_56,
                backgroundColor: bg_green_500,
              ),
            ),
            TwDiv(
              style: TwStyle(
                width: w_frac_1_12,
                height: h_24,
                backgroundColor: bg_pink_500,
              ),
            ),
            TwDiv(
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
