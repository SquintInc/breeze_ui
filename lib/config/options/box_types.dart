/// Specifies the sides in which a value class applies to.
///
/// This is used for all CSS properties that deal with a box model, for example,
/// margin and padding.
enum BoxSideType {
  /// Containing class specifies unit values for each individual side of a box.
  /// Order is top, right, bottom, left.
  trbl,

  /// Containing class specifies unit values for the left and right sides of a
  /// box (horizontal).
  x,

  /// Containing class specifies unit values for the top and bottom sides of a
  /// box (vertical).
  y,

  /// Containing class specifies unit values for both left and right, and top
  /// and bottom sides respectively.
  xy,

  /// Containing class specifies a single unit value for all sides of a box.
  all,
}

/// Specifies the corners and sides in which a value class applies to.
///
/// This is used for border radius.
enum BoxCornerType {
  /// Containing class specifies unit values for each individual corner of a box.
  /// Order is top-left, top-right, bottom-right, bottom-left.
  tltrbrbl,

  /// Containing class specifies unit values for each individual side of a box.
  /// Order is top, right, bottom, left.
  trbl,

  /// Containing class specifies a single unit value for all corners / sides of
  /// a box.
  all,
}
