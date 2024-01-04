import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tailwind_elements/base.dart';
import 'package:tailwind_elements/widgets/style/style.dart';

/// Sealed class representing the icon data using either an [IconData] or svg [BytesLoader].
@immutable
sealed class TwIconData {
  static IconSvgData svg(final BytesLoader svg) => IconSvgData(svg);

  static IconFontData icon(final IconData iconData) => IconFontData(iconData);
}

/// Icon data using an [IconData].
@immutable
class IconFontData implements TwIconData {
  final IconData iconData;

  const IconFontData(this.iconData);
}

/// Icon data using an svg [BytesLoader].
@immutable
class IconSvgData implements TwIconData {
  final BytesLoader svg;

  const IconSvgData(this.svg);
}

/// A widget meant to represent an [Icon] or [SvgPicture] with constrained
/// styling via Tailwind styled properties. Supports only [width], [height], and
/// [textColor] styling properties, and [width] and [height] must be
/// [CssAbsoluteUnit]s. Passing in a null or relative [width] / [height] will
/// be treated as a null value.
@immutable
class TwIcon extends StatelessWidget {
  /// The icon data to use for display
  final TwIconData icon;

  /// Tailwind styling properties, supports only [textColor], and [CssAbsoluteUnit] values for
  /// [width] and [height].
  final TwStyle style;

  const TwIcon({
    required this.icon,
    this.style = const TwStyle(),
    super.key,
  });

  @override
  Widget build(final BuildContext context) {
    final widthPx = switch (style.width?.value) {
      CssAbsoluteUnit() => (style.width!.value as CssAbsoluteUnit).pixels(),
      _ => null,
    };
    final heightPx = switch (style.height?.value) {
      CssAbsoluteUnit() => (style.height!.value as CssAbsoluteUnit).pixels(),
      _ => null,
    };
    switch (icon) {
      case IconSvgData(svg: final svg):
        return SvgPicture(
          svg,
          width: widthPx,
          height: heightPx,
          colorFilter: ColorFilter.mode(
            style.textColor?.color ?? Colors.transparent,
            BlendMode.srcIn,
          ),
        );
      case IconFontData(iconData: final iconData):
        return Icon(
          iconData,
          size: widthPx ?? heightPx,
          color: style.textColor?.color,
        );
    }
  }
}
