import 'package:meta/meta.dart';
import 'package:tailwind_elements/config/builder/build_runner/rgba_color.dart';
import 'package:tailwind_elements/config/options/units.dart';

const String numValuePattern = '[0-9]+(?:[a-zA-Z%]{0,4})';
const String boxShadowPattern =
    '($numValuePattern)\\s+($numValuePattern)\\s+($numValuePattern)\\s+($numValuePattern)\\s+(.*)';
final RegExp boxShadowRegExp = RegExp(boxShadowPattern);

/// Intermediary representation of a CSS box shadow value used by the
/// build_runner build step only.
@immutable
class BoxShadowValue {
  final RgbaColor color;
  final CssMeasurementUnit offsetX;
  final CssMeasurementUnit offsetY;
  final CssMeasurementUnit blurRadius;
  final CssMeasurementUnit spreadRadius;

  const BoxShadowValue({
    required this.color,
    required this.offsetX,
    required this.offsetY,
    required this.blurRadius,
    required this.spreadRadius,
  });

  String toDartConstructor() {
    return 'BoxShadow('
        'color: Color(${color.toDartHexString()}), '
        'offset: Offset(${offsetX.logicalPixels}, ${offsetY.logicalPixels}), '
        'blurRadius: ${blurRadius.logicalPixels}, '
        'spreadRadius: ${spreadRadius.logicalPixels}'
        '),';
  }

  @override
  bool operator ==(final Object other) =>
      identical(this, other) ||
      other is BoxShadowValue &&
          runtimeType == other.runtimeType &&
          color == other.color &&
          offsetX == other.offsetX &&
          offsetY == other.offsetY &&
          blurRadius == other.blurRadius &&
          spreadRadius == other.spreadRadius;

  @override
  int get hashCode =>
      color.hashCode ^
      offsetX.hashCode ^
      offsetY.hashCode ^
      blurRadius.hashCode ^
      spreadRadius.hashCode;
}

class BoxShadowParser {
  final List<BoxShadowValue> boxShadows;

  const BoxShadowParser(this.boxShadows);

  static BoxShadowValue _parseSingleBoxShadow(final String boxShadow) {
    final parts = boxShadow.split(' ');
    final offsetX = CssMeasurementUnit.parse(parts[0]);
    final offsetY = CssMeasurementUnit.parse(parts[1]);
    final blurRadius = CssMeasurementUnit.parse(parts[2]);
    final spreadRadius = CssMeasurementUnit.parse(parts[3]);
    final color = RgbaColor.fromCssRgba(parts.sublist(4).join(' '));

    return BoxShadowValue(
      color: color,
      offsetX: offsetX,
      offsetY: offsetY,
      blurRadius: blurRadius,
      spreadRadius: spreadRadius,
    );
  }

  factory BoxShadowParser.parse(final String value) {
    if (value == 'none') {
      return const BoxShadowParser(<BoxShadowValue>[]);
    }

    return BoxShadowParser(
      value
          .split(',')
          .where((final part) => !part.trim().startsWith('inset'))
          .map((final part) => _parseSingleBoxShadow(part.trim()))
          .toList(),
    );
  }

  String toDartConstructor({final String? wrapperClassName}) {
    if (boxShadows.isEmpty) {
      return '${wrapperClassName != null ? "$wrapperClassName(" : ""}<BoxShadow>[]${wrapperClassName != null ? ")" : ""}';
    }
    final StringBuffer buffer = StringBuffer()
      ..writeln('${wrapperClassName != null ? "$wrapperClassName(" : ""}[')
      ..writeln(
        boxShadows
            .map((final boxShadow) => boxShadow.toDartConstructor())
            .join('\n'),
      )
      ..writeln(']${wrapperClassName != null ? ")" : ""}');
    return buffer.toString();
  }
}
