import 'package:meta/meta.dart';

const String _transparentHexCode = '0x00000000';
final _whitespaceRegex = RegExp(r'\s');
final _hexRgbColorRegex =
    RegExp('#*([0-9a-fA-F]{8}|[0-9a-fA-F]{6}|[0-9a-fA-F]{3})');
final _rgbaColorRegex = RegExp(r'rgba\(([0-9]+),([0-9]+),([0-9]+),([0-9.]+)\)');
final _rgbColorRegex = RegExp(r'rgb\(([0-9]+),([0-9]+),([0-9]+)\)');

@immutable
class RgbaColor {
  static const int minValue = 0;
  static const int maxValue = 255;
  static const RgbaColor transparent = RgbaColor(0, 0, 0, 0);

  /// The red component of this color.
  final int r;

  /// The green component of this color.
  final int g;

  /// The blue component of this color.
  final int b;

  /// The alpha component of this color.
  /// A value of 0 means the color is fully transparent and a value of 255 means
  /// the color is fully opaque.
  final int a;

  /// Creates an [RgbaColor] using the supplied [r], [g], [b], and [a] values.
  ///
  /// All values should be in the range [0, 255] inclusive.
  const RgbaColor(this.r, this.g, this.b, [this.a = maxValue])
      : assert(r >= minValue && r <= maxValue),
        assert(g >= minValue && g <= maxValue),
        assert(b >= minValue && b <= maxValue),
        assert(a >= minValue && a <= maxValue);

  /// Creates an [RgbaColor] from a CSS hex string. The string can be in the
  /// form of '#RGB', '#RRGGBB', or '#RRGGBBAA'.
  factory RgbaColor.fromCssHex(final String value) {
    final match = _hexRgbColorRegex.firstMatch(value);
    if (match == null) return transparent;
    final hex = match.group(1);
    if (hex == null) return transparent;

    final hexString = switch (hex.length) {
      3 =>
        '0xFF${"${hex[0]}${hex[0]}${hex[1]}${hex[1]}${hex[2]}${hex[2]}".toUpperCase()}',
      6 => '0xFF${hex.toUpperCase()}',
      8 =>
        '0x${hex.substring(hex.length - 2).toUpperCase()}${hex.substring(0, hex.length - 2).toUpperCase()}',
      _ => _transparentHexCode,
    };
    if (hexString == _transparentHexCode) return transparent;
    final hexValue = int.tryParse(hexString);
    if (hexValue == null) return transparent;

    final a = (hexValue >> 24) & 0xFF;
    final r = (hexValue >> 16) & 0xFF;
    final g = (hexValue >> 8) & 0xFF;
    final b = hexValue & 0xFF;
    return RgbaColor(r, g, b, a);
  }

  /// Creates an [RgbaColor] using the supplied [r], [g], [b], and [alpha]
  /// values, where [alpha] is the opacity as a double in the range of [0, 1]
  /// inclusive.
  RgbaColor.rgbaOpacity(
    this.r,
    this.g,
    this.b,
    final double alpha,
  )   : assert(alpha >= 0),
        assert(alpha <= 1),
        a = (alpha * maxValue).round();

  factory RgbaColor.fromCssRgba(final String rgba) {
    final String rgbaTrimmed =
        rgba.trim().replaceAllMapped(_whitespaceRegex, (final match) => '');
    final rgbMatch = _rgbColorRegex.firstMatch(rgbaTrimmed);
    final rgbaMatch = _rgbaColorRegex.firstMatch(rgbaTrimmed);
    if (rgbMatch != null) {
      final r = rgbMatch.group(1);
      final g = rgbMatch.group(2);
      final b = rgbMatch.group(3);
      if (r == null || g == null || b == null) {
        throw FormatException(
          'Invalid CSS rgb color string: $rgbaTrimmed',
        );
      }
      return RgbaColor(
        int.tryParse(r) ?? 0,
        int.tryParse(g) ?? 0,
        int.tryParse(b) ?? 0,
      );
    }
    if (rgbaMatch != null) {
      final r = rgbaMatch.group(1);
      final g = rgbaMatch.group(2);
      final b = rgbaMatch.group(3);
      final a = rgbaMatch.group(4);
      if (r == null || g == null || b == null || a == null) {
        throw FormatException(
          'Invalid CSS rgba color string: $rgbaTrimmed',
        );
      }
      return RgbaColor.rgbaOpacity(
        int.tryParse(r) ?? 0,
        int.tryParse(g) ?? 0,
        int.tryParse(b) ?? 0,
        double.tryParse(a) ?? 0,
      );
    }
    throw FormatException(
      'Invalid CSS rgba color string: $rgbaTrimmed',
    );
  }

  /// Gets the Dart hex integer representation of this color.
  int get hexValue => (a << 24) | (r << 16) | (g << 8) | b;

  /// Converts this RGBA color to a CSS hex string representation in the form of
  /// '#RRGGBBAA'.
  ///
  /// If [hideAlphaWhenPossible] is true and the alpha value is 255 for a fully
  /// opaque color, the 'AA' part of the string will be omitted.
  String toCssHexString({
    final bool hideAlphaWhenPossible = true,
    final bool includeHash = true,
  }) {
    final rHex = r.toRadixString(16).padLeft(2, '0');
    final gHex = g.toRadixString(16).padLeft(2, '0');
    final bHex = b.toRadixString(16).padLeft(2, '0');
    if (hideAlphaWhenPossible && a == maxValue) {
      return '${includeHash ? '#' : ''}$rHex$gHex$bHex'.toUpperCase();
    }
    final aHex = a.toRadixString(16).padLeft(2, '0');
    return '${includeHash ? '#' : ''}$rHex$gHex$bHex$aHex'.toUpperCase();
  }

  /// Converts this RGBA color to a Dart hex integer string representation in
  /// the form of '0xAARRGGBB'. Note that in Dart, the alpha value is the first
  /// two characters, and 0 is transparent whereas 255 is fully opaque.
  String toDartHexString() {
    return '0x${hexValue.toRadixString(16).toUpperCase()}';
  }

  @override
  bool operator ==(final Object other) =>
      identical(this, other) ||
      other is RgbaColor &&
          runtimeType == other.runtimeType &&
          r == other.r &&
          g == other.g &&
          b == other.b &&
          a == other.a;

  @override
  int get hashCode => r.hashCode ^ g.hashCode ^ b.hashCode ^ a.hashCode;
}
