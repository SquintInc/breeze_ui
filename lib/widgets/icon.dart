import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tailwind_elements/base.dart';
import 'package:tailwind_elements/widgets/style/style.dart';

/// A widget meant to represent an [Icon] or [SvgPicture] with constrained
/// styling via Tailwind styled properties. Supports only [width], [height], and
/// [textColor] styling properties, and [width] and [height] must be
/// [CssAbsoluteUnit]s. Passing in a null or relative [width] / [height] will
/// be treated as a null value.
@immutable
class TwIcon extends StatelessWidget {
  final IconData? icon;
  final SvgAssetLoader? svg;
  final TwStyle style;

  const TwIcon.icon({
    required this.icon,
    this.style = const TwStyle(),
    super.key,
  }) : svg = null;

  const TwIcon.svg({
    required this.svg,
    this.style = const TwStyle(),
    super.key,
  }) : icon = null;

  @override
  Widget build(final BuildContext context) {
    assert(icon != null || svg != null, 'Either icon or svg must be provided');
    final widthPx = switch (style.width?.value) {
      CssAbsoluteUnit() => (style.width!.value as CssAbsoluteUnit).pixels(),
      _ => null,
    };
    final heightPx = switch (style.height?.value) {
      CssAbsoluteUnit() => (style.height!.value as CssAbsoluteUnit).pixels(),
      _ => null,
    };
    if (icon != null) {
      return Icon(
        icon,
        size: widthPx ?? heightPx,
        color: style.textColor?.color,
      );
    }
    return SvgPicture(
      svg!,
      width: widthPx,
      height: heightPx,
      colorFilter: ColorFilter.mode(
        style.textColor?.color ?? Colors.transparent,
        BlendMode.srcIn,
      ),
    );
  }
}
