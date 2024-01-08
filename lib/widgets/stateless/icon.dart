import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tailwind_elements/base.dart';
import 'package:tailwind_elements/widgets/inherited/parent_constraints_data.dart';
import 'package:tailwind_elements/widgets/stateless/constraints.dart';
import 'package:tailwind_elements/widgets/stateless/div.dart';
import 'package:tailwind_elements/widgets/stateless/stateless_widget.dart';
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

/// A widget representing an [Icon] or [SvgPicture] with support for Tailwind styled properties.
/// The icon is rendered as a child of a [Div] widget for full styling support (meaning relative
/// percent based sizing constraints will work).
///
/// If a [style] is not provided, the [defaultIconStyle] will be used: a black icon with width and
/// height of 24.0 pixels.
@immutable
class TwIcon extends TwStatelessWidget {
  static const double defaultWidthPx = 24.0;
  static const double defaultHeightPx = 24.0;
  static const Color defaultIconColor = Colors.black;
  static const TwStyle defaultIconStyle = TwStyle(
    width: TwWidth(PxUnit(defaultWidthPx)),
    height: TwHeight(PxUnit(defaultHeightPx)),
    textColor: TwTextColor(defaultIconColor),
  );
  static const BoxConstraints defaultConstraints =
      BoxConstraints.tightForFinite(
    width: defaultWidthPx,
    height: defaultHeightPx,
  );

  /// The icon data to use for display. Can be either an [IconData] or svg [BytesLoader].
  final TwIconData icon;

  /// The alignment of the icon within the [Div] widget. Defaults to [Alignment.center].
  final Alignment? alignment;

  /// Whether the icon should expand to fill the available space. This is accomplished by wrapping
  /// the icon in a [ConstrainedBox].
  /// Defaults to true.
  final bool expand;

  const TwIcon({
    required this.icon,
    this.alignment,
    this.expand = true,
    super.style = defaultIconStyle,
    super.staticConstraints,
    super.key,
  });

  Widget buildIcon(
    final BuildContext context,
    final BoxConstraints? constraints,
    final BoxConstraints? staticBoxConstraints,
  ) {
    final Widget iconWidget = switch (icon) {
      IconSvgData(svg: final svg) => FittedBox(
          fit: BoxFit.contain,
          child: SvgPicture(
            svg,
            colorFilter: ColorFilter.mode(
              style.textColor?.color ?? defaultIconColor,
              BlendMode.srcIn,
            ),
          ),
        ),
      IconFontData(iconData: final iconData) => FittedBox(
          fit: BoxFit.contain,
          child: Icon(
            iconData,
            color: style.textColor?.color ?? defaultIconColor,
          ),
        ),
    };

    return Div(
      style: style,
      staticConstraints: staticConstraints,
      parentControlsOpacity: true,
      alignment: alignment ?? Alignment.center,
      child: expand
          ? ConstrainedBox(
              constraints: constraints ?? defaultConstraints,
              child: iconWidget,
            )
          : iconWidget,
    );
  }

  @override
  Widget build(final BuildContext context) {
    final ParentConstraintsData? parentConstraintsData =
        ParentConstraintsData.of(context);

    final styleConstraints = staticConstraints ?? style.toConstraints();
    if (parentConstraintsData != null) {
      final constraints = computeRelativeConstraints(
        parentConstraintsData.constraints,
        styleConstraints,
      );
      final staticBoxConstraints = staticConstraints != null
          ? computeRelativeConstraints(
              parentConstraintsData.constraints,
              staticConstraints!,
            )
          : null;
      return buildIcon(context, constraints, staticBoxConstraints);
    }

    final simpleConstraints =
        tightenAbsoluteConstraints(style.toConstraints(), style.fontSizePx);
    final staticBoxConstraints = staticConstraints != null
        ? tightenAbsoluteConstraints(staticConstraints!, style.fontSizePx)
        : null;
    return buildIcon(
      context,
      simpleConstraints,
      staticBoxConstraints,
    );
  }
}
