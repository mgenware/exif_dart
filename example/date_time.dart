// ignore_for_file: avoid_print

import 'dart:io';

import 'package:exif_dart/exif.dart';

Future<void> main(List<String> arguments) async {
  for (final filename in arguments) {
    print('read $filename ..');

    final fileBytes = File(filename).readAsBytesSync();
    final data = await readExifFromBytes(fileBytes);

    if (data.isEmpty) {
      print('No EXIF information found');
      return;
    }

    final datetime = data['EXIF DateTimeOriginal']?.toString();
    if (datetime == null) {
      print('datetime information not found');
      return;
    }

    print('datetime = $datetime');
  }
}
