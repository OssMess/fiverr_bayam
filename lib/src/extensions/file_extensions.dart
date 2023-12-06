import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

extension FileExtensions on File {
  Future<String> toBase64String() async {
    Uint8List bytes = await readAsBytes();
    return base64Encode(bytes);
  }
}
