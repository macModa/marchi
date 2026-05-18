import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'cloudinary_service.dart';

class StorageService {
  final ImagePicker _picker = ImagePicker();

  /// Picks an image from the gallery and uploads it to Cloudinary
  /// Returns the download URL or null if failed/cancelled
  Future<String?> uploadProductImage() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 70, // Optimize image quality
      );

      if (image == null) return null;

      // Upload to Cloudinary instead of Firebase
      final String? downloadUrl = await CloudinaryService.uploadImage(File(image.path));
      
      return downloadUrl;
    } catch (e) {
      debugPrint('Upload failed: $e');
      return null;
    }
  }

  /// Uploads a file to Cloudinary and returns the download URL
  Future<String?> uploadFile(File file, String path) async {
    try {
      // Path is ignored in Cloudinary simple upload, or used as folder if needed
      return await CloudinaryService.uploadImage(file);
    } catch (e) {
      debugPrint('Upload failed: $e');
      return null;
    }
  }
}

final storageServiceProvider = Provider<StorageService>((ref) {
  return StorageService();
});

