<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->

TODO: Put a short description of the package here that helps potential users
know whether this package might be useful for them.

## Features

### List of supported TailwindCSS options

The following tables lists all the TailwindCSS options (from the sidebar
on https://tailwindcss.com/docs/configuration) and whether they have an equivalent representation in
Flutter via `tailwind_elements`.

<details open>
<summary>Layout</summary>

| Option                      | Supported | Notes |
|-----------------------------|:---------:|-------|
| Aspect Ratio                |           |       |
| Container                   |           |       |
| Columns                     |           |       |
| Break After                 |           |       |
| Break Before                |           |       |
| Break Inside                |           |       |
| Box Decoration Break        |           |       |
| Box Sizing                  |           |       |
| Display                     |           |       |
| Floats                      |           |       |
| Clear                       |           |       |
| Isolation                   |           |       |
| Object Fit                  |           |       |
| Object Position             |           |       |
| Overflow                    |           |       |
| Overscroll Behavior         |           |       |
| Position                    |           |       |
| Top / Right / Bottom / Left |           |       |
| Visibility                  |           |       |
| Z-Index                     |           |       |

</details>

<details open>
<summary>Flexbox & Grid</summary>

| Option                  | Supported | Notes |
|-------------------------|:---------:|-------|
| Flex Basis              |           |       |
| Flex Direction          |           |       |
| Flex Wrap               |           |       |
| Flex                    |           |       |
| Flex Grow               |           |       |
| Flex Shrink             |           |       |
| Order                   |           |       |
| Grid Template Columns   |           |       |
| Grid Column Start / End |           |       |
| Grid Template Rows      |           |       |
| Grid Row Start / End    |           |       |
| Grid Auto Flow          |           |       |
| Grid Auto Columns       |           |       |
| Grid Auto Rows          |           |       |
| Gap                     |           |       |
| Justify Content         |           |       |
| Justify Items           |           |       |
| Justify Self            |           |       |
| Align Content           |           |       |
| Align Items             |           |       |
| Align Self              |           |       |
| Place Content           |           |       |
| Place Items             |           |       |
| Place Self              |           |       |

</details>

<details open>
<summary>Spacing</summary>

| Option        |     Supported      | Notes |
|---------------|:------------------:|-------|
| Padding       | :white_check_mark: |       |
| Margin        | :white_check_mark: |       |
| Space Between |                    |       |

</details>

<details open>
<summary>Sizing</summary>

| Option     |     Supported      | Notes                                                         |
|------------|:------------------:|---------------------------------------------------------------|
| Width      | :white_check_mark: | `min-content`, `max-content`, and `fit-content` not supported |
| Min-Width  | :white_check_mark: | `min-content`, `max-content`, and `fit-content` not supported |
| Max-Width  | :white_check_mark: | `min-content`, `max-content`, and `fit-content` not supported |
| Height     | :white_check_mark: | `min-content`, `max-content`, and `fit-content` not supported |
| Min-Height | :white_check_mark: | `min-content`, `max-content`, and `fit-content` not supported |
| Max-Height | :white_check_mark: | `min-content`, `max-content`, and `fit-content` not supported |

</details>

<details open>
<summary>Typography</summary>

| Option                    |     Supported      | Notes |
|---------------------------|:------------------:|-------|
| Font Family               |                    |       |
| Font Size                 |                    |       |
| Font Smoothing            |                    |       |
| Font Style                |                    |       |
| Font Weight               |                    |       |
| Font Variant Numeric      |                    |       |
| Letter Spacing            |                    |       |
| Line Clamp                |                    |       |
| Line Height               |                    |       |
| List Style Image          |                    |       |
| List Style Position       |                    |       |
| List Style Type           |                    |       |
| Text Align                |                    |       |
| Text Color                | :white_check_mark: |       |
| Text Decoration           |                    |       |
| Text Decoration Color     |                    |       |
| Text Decoration Style     |                    |       |
| Text Decoration Thickness |                    |       |
| Text Underline Offset     |                    |       |
| Text Transform            |                    |       |
| Text Overflow             |                    |       |
| Text Indent               |                    |       |
| Vertical Align            |                    |       |
| Whitespace                |                    |       |
| Word Break                |                    |       |
| Hyphens                   |                    |       |
| Content                   |                    |       |

</details>

<details open>
<summary>Backgrounds</summary>

| Option                |     Supported      | Notes |
|-----------------------|:------------------:|-------|
| Background Attachment |                    |       |
| Background Clip       |                    |       |
| Background Color      | :white_check_mark: |       |
| Background Origin     |                    |       |
| Background Position   |                    |       |
| Background Repeat     |                    |       |
| Background Size       |                    |       |
| Background Image      |                    |       |
| Gradient Color Stops  |                    |       |

</details>

<details open>
<summary>Borders</summary>

| Option            |     Supported      | Notes                                                                                 |
|-------------------|:------------------:|---------------------------------------------------------------------------------------|
| Border Radius     | :white_check_mark: | does not support `border-start-*` and `border-end-*` logical properties               |
| Border Width      | :white_check_mark: | does not support `border-inline-start-*` and `border-inline-end-*` logical properties |
| Border Color      | :white_check_mark: |                                                                                       |
| Border Style      |        :x:         |                                                                                       |
| Divide Width      |                    |                                                                                       |
| Divide Color      |                    |                                                                                       |
| Divide Style      |                    |                                                                                       |
| Outline Width     |                    |                                                                                       |
| Outline Color     |                    |                                                                                       |
| Outline Style     |                    |                                                                                       |
| Outline Offset    |                    |                                                                                       |
| Ring Width        |                    |                                                                                       |
| Ring Color        |                    |                                                                                       |
| Ring Offset Width |                    |                                                                                       |
| Ring Offset Color |                    |                                                                                       |

</details>

<details open>
<summary>Effects</summary>

| Option                |     Supported      | Notes                                                                               |
|-----------------------|:------------------:|-------------------------------------------------------------------------------------|
| Box Shadow            | :white_check_mark: | inner / `inset` box shadows are not supported and will be parsed as a `none` shadow |
| Box Shadow Color      | :white_check_mark: |                                                                                     |
| Opacity               |                    |                                                                                     |
| Mix Blend Mode        |                    |                                                                                     |
| Background Blend Mode |                    |                                                                                     |

</details>

<details open>
<summary>Filters</summary>

| Option              | Supported | Notes |
|---------------------|:---------:|-------|
| Blur                |           |       |
| Brightness          |           |       |
| Contrast            |           |       |
| Drop Shadow         |           |       |
| Grayscale           |           |       |
| Hue Rotate          |           |       |
| Invert              |           |       |
| Saturate            |           |       |
| Sepia               |           |       |
| Backdrop Blur       |           |       |
| Backdrop Brightness |           |       |
| Backdrop Contrast   |           |       |
| Backdrop Grayscale  |           |       |
| Backdrop Hue Rotate |           |       |
| Backdrop Invert     |           |       |
| Backdrop Opacity    |           |       |
| Backdrop Saturate   |           |       |
| Backdrop Sepia      |           |       |

</details>

<details open>
<summary>Tables</summary>

| Option          | Supported | Notes |
|-----------------|:---------:|-------|
| Border Collapse |           |       |
| Border Spacing  |           |       |
| Table Layout    |           |       |
| Caption Side    |           |       |

</details>

<details open>
<summary>Transitions & Animation</summary>

| Option                     | Supported | Notes |
|----------------------------|:---------:|-------|
| Transition Property        |           |       |
| Transition Duration        |           |       |
| Transition Timing Function |           |       |
| Transition Delay           |           |       |
| Animation                  |           |       |

</details>

<details open>
<summary>Transforms</summary>

| Option           | Supported | Notes |
|------------------|:---------:|-------|
| Scale            |           |       |
| Rotate           |           |       |
| Translate        |           |       |
| Skew             |           |       |
| Transform Origin |           |       |

</details>

<details open>
<summary>Interactivity</summary>

| Option            | Supported | Notes |
|-------------------|:---------:|-------|
| Accent Color      |           |       |
| Appearance        |           |       |
| Cursor            |           |       |
| Caret Color       |           |       |
| Pointer Events    |           |       |
| Resize            |           |       |
| Scroll Behavior   |           |       |
| Scroll Margin     |           |       |
| Scroll Padding    |           |       |
| Scroll Snap Align |           |       |
| Scroll Snap Stop  |           |       |
| Scroll Snap Type  |           |       |
| Touch Action      |           |       |
| User Select       |           |       |
| Will Change       |           |       |

</details>

<details open>
<summary>SVG</summary>

| Option       | Supported | Notes |
|--------------|:---------:|-------|
| Fill         |           |       |
| Stroke       |           |       |
| Stroke Width |           |       |

</details>

<details open>
<summary>Accessibility</summary>

| Option         | Supported | Notes |
|----------------|:---------:|-------|
| Screen Readers |           |       |

</details>

## Getting started

TODO: List prerequisites and provide or point to information on how to
start using the package.

## Usage

TODO: Include short and useful examples for package users. Add longer examples
to `/example` folder.

```dart

const like = 'sample';
```

## Additional information

TODO: Tell users more about the package: where to find more information, how to
contribute to the package, how to file issues, what response they can expect
from the package authors, and more.
