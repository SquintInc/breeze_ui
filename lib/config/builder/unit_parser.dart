import 'package:tailwind_elements/config/options/theme/units.dart';

const String _transparentHexCode = '0x00000000';
final _hexRgbColorRegex =
    RegExp('#*([0-9a-fA-F]{8}|[0-9a-fA-F]{6}|[0-9a-fA-F]{3})');

/// Parses a CSS unit value from a string representation into one of the many
/// possible sealed [TwUnit] representations.
///
/// See also:
///   - [PxUnit]
///   - [PercentUnit]
///   - [EmUnit]
///   - [RemUnit]
///   - [ViewportUnit]
///   - [SmallViewportUnit]
///   - [DynamicViewportUnit]
///   - [LargeViewportUnit]
///   - [IgnoreUnit]
TwUnit parseUnit(final String value) {
  if (value.endsWith('px')) {
    return PxUnit(double.parse(value.substring(0, value.length - 2)));
  } else if (value.endsWith('rem')) {
    return RemUnit(double.parse(value.substring(0, value.length - 3)));
  } else if (value.endsWith('%')) {
    return PercentUnit(double.parse(value.substring(0, value.length - 1)));
  } else if (value.endsWith('svh') || value.endsWith('svw')) {
    return SmallViewportUnit(
      double.parse(value.substring(0, value.length - 3)),
    );
  } else if (value.endsWith('dvh') || value.endsWith('dvw')) {
    return DynamicViewportUnit(
      double.parse(value.substring(0, value.length - 3)),
    );
  } else if (value.endsWith('lvh') || value.endsWith('lvw')) {
    return LargeViewportUnit(
      double.parse(value.substring(0, value.length - 3)),
    );
  } else if (value.endsWith('vh') || value.endsWith('vw')) {
    return ViewportUnit(double.parse(value.substring(0, value.length - 2)));
  }
  return IgnoreUnit(value);
}

/// Parses a CSS color value from a string representation into a hex number.
/// Currently the only supported string formats for parsing is:
///   - '#RGB'
///   - '#RRGGBB'
///   - '#RRGGBBAA'
/// The hex integer string is in the format '0xAARRGGBB'. 'AA' is the alpha
/// value, with 0 being transparent and 255 being fully opaque.
String parseColor(final String value) {
  final match = _hexRgbColorRegex.firstMatch(value);
  if (match == null) {
    return _transparentHexCode;
  }

  final hex = match.group(1);
  if (hex == null) {
    return _transparentHexCode;
  }

  return switch (hex.length) {
    3 =>
      '0xFF${"${hex[0]}${hex[0]}${hex[1]}${hex[1]}${hex[2]}${hex[2]}".toUpperCase()}',
    6 => '0xFF${hex.toUpperCase()}',
    8 =>
      '0x${hex.substring(hex.length - 2).toUpperCase()}${hex.substring(0, hex.length - 2).toUpperCase()}',
    _ => _transparentHexCode,
  };
}
