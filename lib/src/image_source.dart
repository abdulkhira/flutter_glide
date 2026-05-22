/// Image source type resolved from a URL/path string.
enum ImageSource { network, assetSvg, asset, file, unknown }

/// Resolves the [ImageSource] from a URL or path string.
///
/// Resolution order (mirrors Glide's source detection):
/// 1. Empty / blank  → [ImageSource.unknown]
/// 2. `http://` / `https://` → [ImageSource.network]
/// 3. `assets/` / `asset/` + `.svg` → [ImageSource.assetSvg]
/// 4. `assets/` / `asset/` → [ImageSource.asset]
/// 5. `file://` URI scheme → [ImageSource.file]
/// 6. Anything else (absolute/relative path) → [ImageSource.file]
ImageSource resolveImageSource(String url) {
  final trimmed = url.trim();
  if (trimmed.isEmpty) return ImageSource.unknown;
  if (trimmed.startsWith('http://') || trimmed.startsWith('https://')) {
    return ImageSource.network;
  }
  if (trimmed.startsWith('assets/') || trimmed.startsWith('asset/')) {
    return trimmed.toLowerCase().endsWith('.svg')
        ? ImageSource.assetSvg
        : ImageSource.asset;
  }
  return ImageSource.file;
}
