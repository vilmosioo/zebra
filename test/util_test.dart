import 'package:file_picker/file_picker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:zebra/common/util.dart';


class MockImport extends Mock implements FilePickerResult {}

void main() {
  final mockImport = MockImport();

  group('Util functions', () {
    test('Parse null import correctly', () async {
      expect(() async => await getAndParseFinchExportForJourneys(null), throwsA("Failed to read file, zip is empty."));
    });

    test('Parse empty import correctly', () async {
      when(() => mockImport.files).thenReturn([]);
      expect(() async => await getAndParseFinchExportForJourneys(mockImport), throwsA("Failed to read file, zip is empty."));
    });
  });
}
