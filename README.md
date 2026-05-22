# swift_image

A Flutter image-loading package inspired by **Glide** and **Picasso** from Android.

Automatically detects the image source — network URL, asset path, SVG asset, `file://` URI, or
local file path — and renders it consistently with a single widget API.

---

## Features

| | |
|---|---|
| ✅ Network images | Cached via `cached_network_image`, shimmer while loading |
| ✅ Asset images | PNG / JPG / WebP / GIF via `Image.asset` |
| ✅ SVG assets | Rendered via `flutter_svg` |
| ✅ Local files | Absolute paths **and** `file://` URIs via `Image.file` |
| ✅ Rounded corners | `borderRadius` — applies to every source type |
| ✅ Colour tint | `color` + `colorBlendMode`, applied correctly inside the clip |
| ✅ Tap callbacks | `onTap` on every widget |
| ✅ Memory-cache hints | `maxCacheWidth` / `maxCacheHeight` for network images |
| ✅ Error fallback | Custom `errorWidget` or default broken-image icon |
| ✅ Shimmer placeholder | Customisable colours; also available standalone |
| ✅ Initials avatar | Auto-generated from `name` when image is unavailable |
| ✅ Hero / banner | `SwiftImageBanner` — aspect-ratio image with gradient overlay and caption |
| ✅ Image grid | `SwiftImageGrid` — responsive fixed-column grid |

---

## Widgets

| Widget | Glide equivalent | Description |
|---|---|---|
| `SwiftImage` | `Glide.with().load().into()` | Rectangular image — all source types |
| `SwiftImageCircle` | `.circleCrop()` | Circular avatar with initials fallback |
| `SwiftImageBanner` | — | Full-width hero image with gradient overlay & caption |
| `SwiftImageGrid` | — | Responsive multi-column image grid |
| `InitialsAvatar` | — | Standalone initials box (colour + text) |
| `ShimmerPlaceholder` | `.placeholder()` | Standalone shimmer loading box |

---

## Installation

```yaml
dependencies:
  swift_image: ^0.1.0
```

```dart
import 'package:swift_image/swift_image.dart';
```

---

## Usage

### SwiftImage — rectangular image

```dart
// Network — cached automatically, shimmer while loading
SwiftImage(
  'https://example.com/photo.jpg',
  width: double.infinity,
  height: 200,
)

// Rounded corners
SwiftImage(
  'https://example.com/photo.jpg',
  width: double.infinity,
  height: 180,
  borderRadius: BorderRadius.circular(16),
)

// Colour tint (tint is clipped inside borderRadius — no bleed)
SwiftImage(
  'https://example.com/photo.jpg',
  width: double.infinity,
  height: 160,
  borderRadius: BorderRadius.circular(12),
  color: Colors.teal.withOpacity(0.4),
  colorBlendMode: BlendMode.multiply,
)

// Tappable
SwiftImage(
  'https://example.com/photo.jpg',
  width: double.infinity,
  height: 140,
  onTap: () => Navigator.push(context, ...),
)

// Asset (PNG / JPG / WebP / GIF)
SwiftImage('assets/images/banner.png', width: double.infinity, height: 180)

// SVG asset
SwiftImage('assets/icons/logo.svg', width: 64, height: 64)

// Local file — absolute path
SwiftImage('/data/user/0/com.example.app/cache/photo.jpg', width: 100, height: 100)

// Local file — file:// URI (e.g. from image_picker on iOS)
SwiftImage('file:///var/mobile/Containers/.../picked.jpg', width: 100, height: 100)

// Custom placeholder and error widget
SwiftImage(
  url,
  placeholder: const Center(child: CircularProgressIndicator()),
  errorWidget: const Icon(Icons.warning, color: Colors.red),
)

// Memory-cache hints — reduces RAM usage for thumbnail lists
SwiftImage(
  url,
  width: 80,
  height: 80,
  maxCacheWidth: 160,
  maxCacheHeight: 160,
)

// Custom HTTP headers (auth tokens, etc.)
SwiftImage(
  url,
  httpHeaders: {'Authorization': 'Bearer $token'},
)
```

---

### SwiftImageBanner — hero / banner image

```dart
// Basic 16:9 banner
SwiftImageBanner(
  imageUrl: 'https://example.com/hero.jpg',
  aspectRatio: 16 / 9,
)

// Gradient overlay + caption + rounded corners + tap
SwiftImageBanner(
  imageUrl: 'https://example.com/hero.jpg',
  aspectRatio: 16 / 9,
  borderRadius: BorderRadius.circular(14),
  overlayGradient: const LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Colors.transparent, Colors.black54],
  ),
  caption: 'Mountain sunrise, Swiss Alps',
  captionStyle: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
  onTap: () => Navigator.push(context, ...),
)

// Solid colour overlay
SwiftImageBanner(
  imageUrl: url,
  aspectRatio: 4 / 3,
  overlayColor: Colors.black38,
  caption: 'Breaking news',
)

// Cinematic 21:9
SwiftImageBanner(imageUrl: url, aspectRatio: 21 / 9)
```

---

### SwiftImageGrid — image grid

```dart
// 3-column square grid with tap
SwiftImageGrid(
  imageUrls: [
    'https://example.com/a.jpg',
    'https://example.com/b.jpg',
    'https://example.com/c.jpg',
  ],
  crossAxisCount: 3,
  spacing: 4,
  borderRadius: BorderRadius.circular(8),
  onTap: (index) => print('tapped item $index'),
)

// 2-column landscape grid (4:3 cells)
SwiftImageGrid(
  imageUrls: urls,
  crossAxisCount: 2,
  spacing: 6,
  childAspectRatio: 4 / 3,
  borderRadius: BorderRadius.circular(10),
)

// Custom error widget per cell
SwiftImageGrid(
  imageUrls: urls,
  errorWidget: const Icon(Icons.image_not_supported),
)
```

---

### SwiftImageCircle — circular avatar

```dart
// Network image
SwiftImageCircle(
  imageUrl: 'https://example.com/avatar.jpg',
  radius: 32,
  name: 'Siddharth Rathod',
)

// Empty URL → initials fallback ("SR")
SwiftImageCircle(
  imageUrl: '',
  radius: 40,
  name: 'Siddharth Rathod',
  initialsBackgroundColor: const Color(0xFFD6E9F5),
  initialsTextColor: const Color(0xFF05678D),
)

// Broken URL → falls back to initials
SwiftImageCircle(
  imageUrl: 'https://broken.url/avatar.jpg',
  radius: 40,
  name: 'John Doe',
)

// Border + tap
SwiftImageCircle(
  imageUrl: avatarUrl,
  radius: 28,
  name: 'Ali M',
  borderWidth: 2,
  borderColor: Colors.teal,
  onTap: () => Navigator.push(context, ...),
)

// Custom error widget (overrides initials)
SwiftImageCircle(
  imageUrl: url,
  radius: 36,
  name: 'Sam Lee',
  errorWidget: const Icon(Icons.person, size: 40),
)
```

---

### Standalone widgets

```dart
// InitialsAvatar — use anywhere without an image URL
InitialsAvatar(
  name: 'John Doe',        // → "JD"
  size: 64,
  backgroundColor: Colors.blueGrey,
  textColor: Colors.white,
)

// Single-letter name → "J"
InitialsAvatar(name: 'Jane', size: 48)

// ShimmerPlaceholder — use as a skeleton loader anywhere
ShimmerPlaceholder(
  width: 300,
  height: 180,
  baseColor: const Color(0xFFE0E0E0),
  highlightColor: const Color(0xFFF5F5F5),
)
```

---

## API Reference

### `SwiftImage`

| Parameter | Type | Default | Description |
|---|---|---|---|
| `imageUrl` *(required)* | `String` | — | Network URL, `assets/` path, SVG path, `file://` URI, or absolute file path |
| `width` | `double?` | `null` | Widget width |
| `height` | `double?` | `null` | Widget height |
| `fit` | `BoxFit` | `cover` | How the image fills its box |
| `borderRadius` | `BorderRadius?` | `null` | Rounded corners — applied to all source types |
| `color` | `Color?` | `null` | Tint colour; applied inside the clip via `ColorFiltered` |
| `colorBlendMode` | `BlendMode` | `srcIn` | Blend mode used with `color` |
| `onTap` | `VoidCallback?` | `null` | Tap callback |
| `placeholder` | `Widget?` | shimmer | Shown while a network image loads |
| `errorWidget` | `Widget?` | broken-image icon | Shown when loading fails or URL is empty |
| `shimmerBaseColor` | `Color` | `#E0E0E0` | Shimmer base colour |
| `shimmerHighlightColor` | `Color` | `#F5F5F5` | Shimmer highlight colour |
| `httpHeaders` | `Map<String,String>?` | `null` | Extra HTTP headers (network only) |
| `maxCacheWidth` | `int?` | `null` | Max memory-cache pixel width (network only) |
| `maxCacheHeight` | `int?` | `null` | Max memory-cache pixel height (network only) |

### `SwiftImageBanner`

| Parameter | Type | Default | Description |
|---|---|---|---|
| `imageUrl` *(required)* | `String` | — | Image source (same rules as `SwiftImage`) |
| `aspectRatio` | `double` | `16/9` | Width ÷ height ratio |
| `overlayGradient` | `Gradient?` | `null` | Gradient painted over the image |
| `overlayColor` | `Color?` | `null` | Solid colour overlay (alternative to gradient) |
| `caption` | `String?` | `null` | Text shown at the bottom of the banner |
| `captionStyle` | `TextStyle?` | white bold w/ shadow | Text style for caption |
| `captionPadding` | `EdgeInsets` | `all(12)` | Padding around caption |
| `borderRadius` | `BorderRadius?` | `null` | Rounded corners |
| `onTap` | `VoidCallback?` | `null` | Tap callback |
| `placeholder` | `Widget?` | shimmer | Custom loading widget |
| `errorWidget` | `Widget?` | broken-image icon | Custom error widget |
| `shimmerBaseColor` | `Color` | `#E0E0E0` | Shimmer base colour |
| `shimmerHighlightColor` | `Color` | `#F5F5F5` | Shimmer highlight colour |

### `SwiftImageGrid`

| Parameter | Type | Default | Description |
|---|---|---|---|
| `imageUrls` *(required)* | `List<String>` | — | List of image sources |
| `crossAxisCount` | `int` | `3` | Number of columns |
| `spacing` | `double` | `2` | Gap between cells (horizontal & vertical) |
| `childAspectRatio` | `double` | `1` | Cell width ÷ height ratio |
| `borderRadius` | `BorderRadius?` | `null` | Rounded corners per cell |
| `fit` | `BoxFit` | `cover` | Image fit per cell |
| `onTap` | `void Function(int)?` | `null` | Tap callback — receives cell index |
| `placeholder` | `Widget?` | shimmer | Custom loading widget per cell |
| `errorWidget` | `Widget?` | broken-image icon | Custom error widget per cell |
| `shimmerBaseColor` | `Color` | `#E0E0E0` | Shimmer base colour |
| `shimmerHighlightColor` | `Color` | `#F5F5F5` | Shimmer highlight colour |

### `SwiftImageCircle`

| Parameter | Type | Default | Description |
|---|---|---|---|
| `imageUrl` *(required)* | `String` | — | Image source |
| `radius` *(required)* | `double` | — | Circle radius; diameter = `radius × 2` |
| `name` | `String` | `''` | Full name — up to 2 initials extracted automatically |
| `borderWidth` | `double` | `0` | Border stroke width |
| `borderColor` | `Color` | transparent | Border colour |
| `initialsBackgroundColor` | `Color` | `#D9D9D9` | Background colour behind initials |
| `initialsTextColor` | `Color` | `#555555` | Initials text colour |
| `onTap` | `VoidCallback?` | `null` | Tap callback |
| `errorWidget` | `Widget?` | initials | Overrides initials on load error |
| `httpHeaders` | `Map<String,String>?` | `null` | Extra HTTP headers (network only) |
| `shimmerBaseColor` | `Color` | `#E0E0E0` | Shimmer base colour |
| `shimmerHighlightColor` | `Color` | `#F5F5F5` | Shimmer highlight colour |

### `InitialsAvatar`

| Parameter | Type | Default | Description |
|---|---|---|---|
| `name` *(required)* | `String` | — | Name to extract initials from |
| `size` *(required)* | `double` | — | Width and height of the box |
| `backgroundColor` | `Color` | `#D9D9D9` | Background fill colour |
| `textColor` | `Color` | `#555555` | Initials text colour |
| `fontSize` | `double?` | `size × 0.38` | Override font size |

### `ShimmerPlaceholder`

| Parameter | Type | Default | Description |
|---|---|---|---|
| `width` | `double?` | `null` | Width of the placeholder |
| `height` | `double?` | `null` | Height of the placeholder |
| `baseColor` | `Color` | `#E0E0E0` | Shimmer base colour |
| `highlightColor` | `Color` | `#F5F5F5` | Shimmer sweep colour |

---

## Source resolution

`resolveImageSource(url)` is the shared resolver used by all widgets. Resolution order:

| Priority | Condition | Resolved as |
|---|---|---|
| 1 | Blank / whitespace-only | `unknown` → fallback widget |
| 2 | Starts with `http://` or `https://` | `network` → `CachedNetworkImage` |
| 3 | Starts with `assets/` or `asset/`, ends with `.svg` | `assetSvg` → `SvgPicture.asset` |
| 4 | Starts with `assets/` or `asset/` | `asset` → `Image.asset` |
| 5 | Starts with `file://` or is an absolute/relative path | `file` → `Image.file` |

`file://` URIs are automatically converted to a file path via `Uri.parse().toFilePath()` before
being passed to `Image.file`.

---

## Dependencies

| Package | Version | Purpose |
|---|---|---|
| `cached_network_image` | `^3.3.1` | Network image caching |
| `flutter_svg` | `^2.0.10` | SVG rendering |
| `shimmer` | `^3.0.0` | Shimmer loading animation |

---

## License

MIT
