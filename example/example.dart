// ignore_for_file: avoid_print

import 'dart:io';

import 'package:exif_reader/exif_reader.dart';

Future<void> main(List<String> arguments) async {
  for (final filename in arguments) {
    print('read $filename ..');

    final fileBytes = File(filename).readAsBytesSync();
    final data = await readExifFromBytes(fileBytes);

    if (data.isEmpty) {
      print('No EXIF information found');
      return;
    }

    if (data.containsKey('JPEGThumbnail')) {
      print('File has JPEG thumbnail');
      data.remove('JPEGThumbnail');
    }
    if (data.containsKey('TIFFThumbnail')) {
      print('File has TIFF thumbnail');
      data.remove('TIFFThumbnail');
    }

    for (final entry in data.entries) {
      print('${entry.key}: ${entry.value}');
    }
  }
}
