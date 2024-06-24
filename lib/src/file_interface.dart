import 'dart:async';

import 'file_interface_generic.dart'
    if (dart.library.html) 'package:exif_dart/src/file_interface_html.dart'
    if (dart.library.io) 'package:exif_dart/src/file_interface_io.dart';

abstract class FileReader {
  static Future<FileReader> fromFile(dynamic file) async {
    return createFileReaderFromFile(file);
  }

  factory FileReader.fromBytes(List<int> bytes) {
    return _BytesReader(bytes);
  }

  int readByteSync();

  List<int> readSync(int bytes);

  int positionSync();

  void setPositionSync(int position);
}

class _BytesReader implements FileReader {
  List<int> bytes;
  int readPos = 0;

  _BytesReader(this.bytes);

  @override
  int positionSync() {
    return readPos;
  }

  @override
  int readByteSync() {
    return bytes[readPos++];
  }

  @override
  List<int> readSync(int n) {
    final start = readPos;
    if (start >= bytes.length) {
      return [];
    }

    var end = readPos + n;
    if (end > bytes.length) {
      end = bytes.length;
    }
    final r = bytes.sublist(start, end);
    readPos += end - start;
    return r;
  }

  @override
  void setPositionSync(int position) {
    readPos = position;
  }
}
