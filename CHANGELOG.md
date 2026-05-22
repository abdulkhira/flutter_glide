## 0.1.1

- **Docs** README fully updated to `flutter_glide` branding — all widget names corrected to `GlideImage`, `GlideCircle`, `GlideBanner`, `GlideGrid`.
- **Docs** Installation snippet updated to `flutter_glide: ^0.1.1`.

## 0.1.0

- **New** `SwiftImageBanner` — full-width hero/banner image with aspect ratio, gradient/solid overlay, caption, `borderRadius`, and `onTap`.
- **New** `SwiftImageGrid` — responsive fixed-column image grid with `crossAxisCount`, `spacing`, `childAspectRatio`, `borderRadius`, and `onTap(index)`.
- **New** `SwiftImage.borderRadius` — rounded corners applied to all source types.
- **New** `SwiftImage.color` + `colorBlendMode` — colour tint via `ColorFiltered`, correctly inside the clip boundary.
- **New** `SwiftImage.onTap` and `SwiftImageCircle.onTap` — tap callbacks on all image widgets.
- **New** `SwiftImage.maxCacheWidth` / `maxCacheHeight` — memory-cache hints forwarded to `CachedNetworkImage`.
- **New** `file://` URI support — automatically stripped to a file path before passing to `Image.file`.
- **Fix** `SwiftImageCircle` border clipping — `ClipOval` now sized to `diameter` only; border container wraps around it so image size is always correct.
- **Fix** `imageUrl == 'null'` string guard replaced with `imageUrl.trim().isEmpty`.
- **Refactor** Shared `resolveImageSource()` extracted to `image_source.dart` — eliminates duplicated resolver in each file.
- `exports` updated — `ImageSource` enum and `resolveImageSource` are now public.

## 0.0.1

- Initial release.
- `SwiftImage` — rectangular image widget with network cache, shimmer placeholder, asset, SVG, file, and error fallback support.
- `SwiftImageCircle` — circular avatar widget with all of the above plus automatic initials fallback.
- `InitialsAvatar` — standalone initials widget.
- `ShimmerPlaceholder` — standalone shimmer widget.
