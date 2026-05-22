/// flutter_glide — Flutter image loading library inspired by Glide and Picasso.
///
/// Exports:
/// - [GlideImage]        — Rectangular image widget (network / asset / SVG / file)
/// - [GlideCircle]       — Circular avatar with initials fallback
/// - [GlideBanner]       — Full-width aspect-ratio hero/banner image
/// - [GlideGrid]         — Responsive fixed-column image grid
/// - [InitialsAvatar]    — Standalone initials box
/// - [ShimmerPlaceholder]— Standalone shimmer loading box
/// - [ImageSource]       — Enum for resolved image source type
/// - [resolveImageSource]— Helper to resolve source from a URL/path string
library flutter_glide;

export 'src/image_source.dart';
export 'src/initials_avatar.dart';
export 'src/shimmer_placeholder.dart';
export 'src/glide_image.dart';
export 'src/glide_banner.dart';
export 'src/glide_circle.dart';
export 'src/glide_grid.dart';
