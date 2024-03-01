// ignore_for_file: prefer_const_constructors
import 'package:breeze_ui/config/builder/build_runner/rgba_color.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('RgbaColor constructor takes in individual r, g, b, a components', () {
    final color = RgbaColor(55, 110, 220, 75);
    expect(color.r, equals(55));
    expect(color.g, equals(110));
    expect(color.b, equals(220));
    expect(color.a, equals(75));
    expect(color.hexValue, equals(0x4B376EDC));
  });

  test(
      'RgbaColor.fromCssHex constructor returns proper int.parse-able hex string',
      () {
    // rgba(0, 0, 0, 1)
    final fff = RgbaColor.fromCssHex('#FFF');
    expect(fff.r, equals(255));
    expect(fff.g, equals(255));
    expect(fff.b, equals(255));
    expect(fff.a, equals(255));
    expect(fff.hexValue, equals(0xFFFFFFFF));
    expect(fff.toDartHexString(), equals('0xFFFFFFFF'));
    expect(fff.toCssHexString(), equals('#FFFFFF'));
    expect(
      fff.toCssHexString(hideAlphaWhenPossible: false),
      equals('#FFFFFFFF'),
    );

    // rgba(0, 0, 0, 1)
    final c000 = RgbaColor.fromCssHex('#000');
    expect(c000.r, equals(0));
    expect(c000.g, equals(0));
    expect(c000.b, equals(0));
    expect(c000.a, equals(255));
    expect(c000.hexValue, equals(0xFF000000));
    expect(c000.toDartHexString(), equals('0xFF000000'));
    expect(c000.toCssHexString(), equals('#000000'));
    expect(
      c000.toCssHexString(hideAlphaWhenPossible: false),
      equals('#000000FF'),
    );

    // rgba(255, 255, 255, 1)
    final ffffff = RgbaColor.fromCssHex('#FFFFFF');
    expect(ffffff.r, equals(255));
    expect(ffffff.g, equals(255));
    expect(ffffff.b, equals(255));
    expect(ffffff.a, equals(255));
    expect(ffffff.hexValue, equals(0xFFFFFFFF));
    expect(ffffff.toDartHexString(), equals('0xFFFFFFFF'));
    expect(ffffff.toCssHexString(), equals('#FFFFFF'));
    expect(
      ffffff.toCssHexString(hideAlphaWhenPossible: false),
      equals('#FFFFFFFF'),
    );

    // rgba(1, 128, 255, 0.5)
    final c0180ff80 = RgbaColor.fromCssHex('#0180FF64');
    expect(c0180ff80.r, equals(1));
    expect(c0180ff80.g, equals(128));
    expect(c0180ff80.b, equals(255));
    expect(c0180ff80.a, equals(100));
    expect(c0180ff80.hexValue, equals(0x640180FF));
    expect(c0180ff80.toDartHexString(), equals('0x640180FF'));
    expect(c0180ff80.toCssHexString(), equals('#0180FF64'));
    expect(
      c0180ff80.toCssHexString(hideAlphaWhenPossible: false),
      c0180ff80.toCssHexString(),
    );

    // Tailwind indigo-500 #6366f1
    final indigo500 = RgbaColor.fromCssHex('#6366F1');
    expect(indigo500.r, equals(99));
    expect(indigo500.g, equals(102));
    expect(indigo500.b, equals(241));
    expect(indigo500.a, equals(255));
    expect(indigo500.hexValue, equals(0xFF6366F1));
    expect(indigo500.toDartHexString(), equals('0xFF6366F1'));
    expect(indigo500.toCssHexString(), equals('#6366F1'));
    expect(
      indigo500.toCssHexString(hideAlphaWhenPossible: false),
      equals('#6366F1FF'),
    );
  });

  test('RgbaColor.rgbaOpacity constructor takes in a decimal alpha value', () {
    final color75 = RgbaColor.rgbaOpacity(55, 110, 220, 0.75);
    expect(color75.r, equals(55));
    expect(color75.g, equals(110));
    expect(color75.b, equals(220));
    expect(color75.a, equals(191));
    expect(color75.hexValue, equals(0xBF376EDC));

    final color50 = RgbaColor.rgbaOpacity(55, 110, 220, 0.5);
    expect(color50.r, equals(55));
    expect(color50.g, equals(110));
    expect(color50.b, equals(220));
    expect(color50.a, equals(128));
    expect(color50.hexValue, equals(0x80376EDC));

    final color10 = RgbaColor.rgbaOpacity(55, 110, 220, 0.1);
    expect(color10.r, equals(55));
    expect(color10.g, equals(110));
    expect(color10.b, equals(220));
    expect(color10.a, equals(26));
    expect(color10.hexValue, equals(0x1A376EDC));
  });

  test('RgbaColor.fromCssRgba constructor takes in a CSS rgba string', () {
    expect(
      RgbaColor.fromCssRgba('rgba(55, 110, 220, 0.75)'),
      equals(RgbaColor(55, 110, 220, 191)),
    );
    expect(
      RgbaColor.fromCssRgba('rgb(55 110 220 / 0.75)'),
      equals(RgbaColor(55, 110, 220, 191)),
    );
    expect(
      RgbaColor.fromCssRgba('rgba(55, 110, 220, 0.75)'),
      equals(RgbaColor.rgbaOpacity(55, 110, 220, 0.75)),
    );
    expect(
      RgbaColor.fromCssRgba('rgb(55, 110, 220)'),
      equals(RgbaColor(55, 110, 220)),
    );
  });
}
