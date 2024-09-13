// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import "package:flutter/material.dart";
import "package:flutter_test/flutter_test.dart";
import "package:hive_flutter/hive_flutter.dart";
import "package:hive_test/hive_test.dart";
import "package:zebra/common/constants.dart";
import "package:zebra/main.dart";
import "package:zebra/model/hive/main.dart";
import "package:zebra/model/hive/report.dart";

void main() {
  Box? box;

  setUp(() async {
    await setUpTestHive();
    box = await Hive.openBox<Main>(zebraBox);
    // todo add some testing data
    // have to put the call inside a `runAsync()`
    // await tester.runAsync(() => box.put('key', 'hello world'));
    await box?.clear();
  });

  tearDown(() async {
    await box?.deleteFromDisk();
    await tearDownTestHive();
  });

  testWidgets("Basic scaffolding", (WidgetTester tester) async {
    await tester.pumpWidget(const ZebraApp());

    expect(find.text("Zebra"), findsOneWidget);
    expect(find.byIcon(Icons.add), findsOneWidget);
  });

  group("Goals", () {
    testWidgets("Display basic goals", (WidgetTester tester) async {
      box?.put(mainKey, Main(goals: {"My awesome goal": [Report(date: "Thu, 9 Nov 2023 01:00:00", isCompleted: false)]}));

      await tester.pumpWidget(const ZebraApp());

      expect(find.text("My awesome goal (1)"), findsOneWidget);
    }, timeout: const Timeout(Duration(seconds: 10)));
  });
}
