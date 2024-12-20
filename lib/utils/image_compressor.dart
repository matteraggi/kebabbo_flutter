import 'dart:typed_data';

import 'package:image/image.dart' as img;

class ImageUtils {
  static Future<Uint8List?> compressImage(
      Uint8List bytes, int maxSizeInBytes, int maxWidth, int maxHeight) async {
    // Decode the image
    img.Image? image = img.decodeImage(bytes);
    if (image == null) return null;

    // Resize the image if necessary while maintaining aspect ratio
    if (image.width > maxWidth || image.height > maxHeight) {
      final double aspectRatio = image.width / image.height;
      int newWidth = maxWidth;
      int newHeight = maxHeight;

      if (aspectRatio > 1) {
        // Landscape image
        newHeight = (maxWidth / aspectRatio).round();
      } else {
        // Portrait or square image
        newWidth = (maxHeight * aspectRatio).round();
      }

      image = img.copyResize(image, width: newWidth, height: newHeight);
    }

    // Compress the image with initial quality
    List<int>? encodedImage = img.encodeJpg(image, quality: 80);

    // Check if the image is still too large after resizing and compression
    if (encodedImage.length > maxSizeInBytes) {
      // Calculate new quality based on the current size and max size
      int quality = (maxSizeInBytes / encodedImage.length * 80).toInt();
      // Ensure quality doesn't go below 20
      quality = quality < 20 ? 20 : quality;

      encodedImage = img.encodeJpg(image, quality: quality);
    }

    return Uint8List.fromList(encodedImage);
  }
}