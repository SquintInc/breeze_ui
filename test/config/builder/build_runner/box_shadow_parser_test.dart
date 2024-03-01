// ignore_for_file: prefer_const_constructors
import 'package:breeze_ui/base.dart';
import 'package:breeze_ui/config/builder/build_runner/box_shadow_parser.dart';
import 'package:breeze_ui/config/builder/build_runner/rgba_color.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('box shadow parseBoxShadow() function parses CSS box shadow string', () {
    const boxShadowCssString =
        '0 1px 3px 0 rgb(0 0 0 / 0.1), 0 1px 2px -1px rgb(0 0 0 / 0.1)';
    expect(
      BoxShadowParser.parse(boxShadowCssString).boxShadows,
      equals([
        BoxShadowValue(
          color: RgbaColor.fromCssRgba('rgba(0, 0, 0, 0.1)'),
          offsetX: PxUnit(0),
          offsetY: PxUnit(1),
          blurRadius: PxUnit(3),
          spreadRadius: PxUnit(0),
        ),
        BoxShadowValue(
          color: RgbaColor.fromCssRgba('rgba(0, 0, 0, 0.1)'),
          offsetX: PxUnit(0),
          offsetY: PxUnit(1),
          blurRadius: PxUnit(2),
          spreadRadius: PxUnit(-1),
        ),
      ]),
    );

    expect(
      BoxShadowParser.parse(boxShadowCssString).toDartConstructor(),
      equals('''[
BoxShadow(color: Color(0x1A000000), offset: Offset(0.0, 1.0), blurRadius: 3.0, spreadRadius: 0.0),
BoxShadow(color: Color(0x1A000000), offset: Offset(0.0, 1.0), blurRadius: 2.0, spreadRadius: -1.0),
]
'''),
    );

    expect(BoxShadowParser([]).toDartConstructor(), equals('<BoxShadow>[]'));
  });
}
