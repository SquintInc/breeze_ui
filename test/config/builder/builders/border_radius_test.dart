// ignore_for_file: prefer_const_constructors
import 'package:flutter_test/flutter_test.dart';
import 'package:tailwind_elements/base.dart';
import 'package:tailwind_elements/config/options/box_types.dart';

import '../tailwind_config_example.dart';

void main() {
  group('border radius', () {
    test('can be created with all sides having the same values', () {
      final borderRadius = TwBorderRadius.all(rounded);
      expect(borderRadius.top, equals(TwBorderRadiusTop(zero)));
      expect(borderRadius.right, equals(TwBorderRadiusRight(zero)));
      expect(borderRadius.bottom, equals(TwBorderRadiusBottom(zero)));
      expect(borderRadius.left, equals(TwBorderRadiusLeft(zero)));
      expect(borderRadius.topLeft, equals(TwBorderRadiusTopLeft(zero)));
      expect(borderRadius.topRight, equals(TwBorderRadiusTopRight(zero)));
      expect(borderRadius.bottomRight, equals(TwBorderRadiusBottomRight(zero)));
      expect(borderRadius.bottomLeft, equals(TwBorderRadiusBottomLeft(zero)));
      expect(borderRadius.all, equals(rounded));
      expect(borderRadius.type, equals(BoxCornerType.all));
    });

    test(
        'can be created with side (trbl) constructor, setting each side individually',
        () {
      final borderRadius = TwBorderRadius.side(
        top: rounded_t,
        right: rounded_r_sm,
        bottom: rounded_b_md,
        left: rounded_l_lg,
      );
      expect(borderRadius.top, equals(TwBorderRadiusTop(RemUnit(0.25))));
      expect(borderRadius.right, equals(TwBorderRadiusRight(RemUnit(0.125))));
      expect(borderRadius.bottom, equals(TwBorderRadiusBottom(RemUnit(0.375))));
      expect(borderRadius.left, equals(TwBorderRadiusLeft(RemUnit(0.5))));
      expect(borderRadius.topLeft, equals(TwBorderRadiusTopLeft(zero)));
      expect(borderRadius.topRight, equals(TwBorderRadiusTopRight(zero)));
      expect(borderRadius.bottomRight, equals(TwBorderRadiusBottomRight(zero)));
      expect(borderRadius.bottomLeft, equals(TwBorderRadiusBottomLeft(zero)));
      expect(borderRadius.all, equals(TwBorderRadiusAll(zero)));
      expect(borderRadius.type, equals(BoxCornerType.trbl));
    });

    test(
        'can be created with corner (tltrbrbl) constructor, setting each corner individually',
        () {
      final borderRadius = TwBorderRadius.corner(
        topLeft: rounded_tl,
        topRight: rounded_tr_sm,
        bottomRight: rounded_br_md,
        bottomLeft: rounded_bl_lg,
      );
      expect(borderRadius.top, equals(TwBorderRadiusTop(zero)));
      expect(borderRadius.right, equals(TwBorderRadiusRight(zero)));
      expect(borderRadius.bottom, equals(TwBorderRadiusBottom(zero)));
      expect(borderRadius.left, equals(TwBorderRadiusLeft(zero)));
      expect(
        borderRadius.topLeft,
        equals(TwBorderRadiusTopLeft(RemUnit(0.25))),
      );
      expect(
        borderRadius.topRight,
        equals(TwBorderRadiusTopRight(RemUnit(0.125))),
      );
      expect(
        borderRadius.bottomRight,
        equals(TwBorderRadiusBottomRight(RemUnit(0.375))),
      );
      expect(
        borderRadius.bottomLeft,
        equals(TwBorderRadiusBottomLeft(RemUnit(0.5))),
      );
      expect(borderRadius.all, equals(TwBorderRadiusAll(zero)));
      expect(borderRadius.type, equals(BoxCornerType.tltrbrbl));
    });
  });
}
