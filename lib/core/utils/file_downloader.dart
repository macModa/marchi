import 'package:open_file/open_file.dart';
import 'dart:typed_data';

// Using conditional export/import or a simple check if possible.
// For simplicity in a single file, we'll use the kIsWeb check.
// Note: dart:html cannot be imported on mobile directly.
// We will use the 'anchor' trick for web if we can safely import it.

import 'file_download_web.dart' if (dart.library.io) 'file_download_mobile.dart';

Future<void> saveAndOpenFile(Uint8List bytes, String fileName) async {
  await downloadFile(bytes, fileName);
}
