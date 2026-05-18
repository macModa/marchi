import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

/// Service for uploading images to Cloudinary
class CloudinaryService {
  static const String _cloudName = "dzty8ac5x";
  static const String _uploadPreset = "marchi_unsigned";

  /// Uploads an image file to Cloudinary and returns the secure URL
  ///
  /// [imageFile] - The image file (File object or path string)
  /// Returns the secure URL of the uploaded image, or null if upload fails
  static Future<String?> uploadImage(dynamic imageFile) async {
    final url = Uri.parse(
      "https://api.cloudinary.com/v1_1/$_cloudName/image/upload",
    );

    debugPrint('[Cloudinary] Uploading image to $_cloudName...');
    debugPrint('[Cloudinary] Upload preset: $_uploadPreset');

    try {
      final request = http.MultipartRequest("POST", url)
        ..fields['upload_preset'] = _uploadPreset;

      // Handle both File and path strings
      if (imageFile is String) {
        debugPrint('[Cloudinary] Uploading from path string: $imageFile');
        request.files.add(await http.MultipartFile.fromPath('file', imageFile));
      } else if (imageFile is File) {
        debugPrint('[Cloudinary] Uploading from File: ${imageFile.path}');
        debugPrint('[Cloudinary] File exists: ${await imageFile.exists()}');
        debugPrint('[Cloudinary] File size: ${await imageFile.length()} bytes');
        request.files.add(
          await http.MultipartFile.fromPath('file', imageFile.path),
        );
      } else {
        debugPrint('[Cloudinary] Uploading from dynamic with path: ${imageFile.path}');
        request.files.add(
          await http.MultipartFile.fromPath('file', imageFile.path),
        );
      }

      debugPrint('[Cloudinary] Sending request...');
      final streamedResponse = await request.send().timeout(
        const Duration(seconds: 60),
      );
      final response = await http.Response.fromStream(streamedResponse);

      debugPrint('[Cloudinary] Response status: ${response.statusCode}');

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final secureUrl = jsonData['secure_url'] as String?;
        debugPrint('[Cloudinary] Upload success! URL: $secureUrl');
        return secureUrl;
      } else {
        debugPrint('[Cloudinary] Upload failed: ${response.statusCode}');
        debugPrint('[Cloudinary] Response body: ${response.body}');
        return null;
      }
    } catch (e) {
      debugPrint('[Cloudinary] Exception during upload: $e');
      return null;
    }
  }

  /// Uploads image bytes to Cloudinary (for web support)
  ///
  /// [bytes] - The image bytes
  /// [fileName] - The original file name
  /// Returns the secure URL of the uploaded image, or null if upload fails
  static Future<String?> uploadImageBytes(
    Uint8List bytes,
    String fileName,
  ) async {
    final url = Uri.parse(
      "https://api.cloudinary.com/v1_1/$_cloudName/image/upload",
    );

    debugPrint('[Cloudinary] Uploading bytes to $_cloudName...');
    debugPrint('[Cloudinary] File name: $fileName, bytes: ${bytes.length}');

    try {
      final request = http.MultipartRequest("POST", url)
        ..fields['upload_preset'] = _uploadPreset
        ..files.add(
          http.MultipartFile.fromBytes('file', bytes, filename: fileName),
        );

      debugPrint('[Cloudinary] Sending request...');
      final streamedResponse = await request.send().timeout(
        const Duration(seconds: 60),
      );
      final response = await http.Response.fromStream(streamedResponse);

      debugPrint('[Cloudinary] Response status: ${response.statusCode}');

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final secureUrl = jsonData['secure_url'] as String?;
        debugPrint('[Cloudinary] Upload success! URL: $secureUrl');
        return secureUrl;
      } else {
        debugPrint('[Cloudinary] Upload failed: ${response.statusCode}');
        debugPrint('[Cloudinary] Response body: ${response.body}');
        return null;
      }
    } catch (e) {
      debugPrint('[Cloudinary] Exception during upload: $e');
      return null;
    }
  }
}
