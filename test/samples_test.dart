// ignore: library_annotations
@TestOn('vm')
import 'package:exif_reader/exif_reader.dart';
import 'package:test/test.dart';

import 'read_samples.dart';

Future<void> main() async {
  await for (final file in readSamples()) {
    test(file.name, () async {
      final exifDump = await printExifOfBytes(file.getContent());
      expect(exifDump, equals(file.dump));
    });
  }
}
