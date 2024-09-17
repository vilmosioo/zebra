// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.
import "package:file_picker/file_picker.dart";
import "package:flutter_test/flutter_test.dart";
import "package:mocktail/mocktail.dart";
import "package:zebra/common/util.dart";

class MockImport extends Mock implements FilePickerResult {}

void main() {
  final mockImport = MockImport();

  group("Util functions", () {
    test("Parse null import correctly", () async {
      expect(await getAndParseFinchExport(null), {});
    });

    test("Parse empty import correctly", () async {
      when(() => mockImport.files).thenReturn([]);
      expect(await getAndParseFinchExport(mockImport), {});
    });
  });
}
