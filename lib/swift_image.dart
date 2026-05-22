/// swift_image — Flutter image loading library inspired by Glide and Picasso.
///
/// Exports:
/// - [SwiftImage]        — Rectangular image widget (network / asset / SVG / file)
/// - [SwiftImageCircle]  — Circular avatar with initials fallback
/// - [SwiftImageBanner]  — Full-width aspect-ratio hero/banner image
/// - [SwiftImageGrid]    — Responsive fixed-column image grid
/// - [InitialsAvatar]    — Standalone initials box
/// - [ShimmerPlaceholder]— Standalone shimmer loading box
/// - [ImageSource]       — Enum for resolved image source type
/// - [resolveImageSource]— Helper to resolve source from a URL/path string
library swift_image;

export 'src/image_source.dart';
export 'src/initials_avatar.dart';
export 'src/shimmer_placeholder.dart';
export 'src/swift_image.dart';
export 'src/swift_image_banner.dart';
export 'src/swift_image_circle.dart';
export 'src/swift_image_grid.dart';
