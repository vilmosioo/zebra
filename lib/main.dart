
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'common/constants.dart';
import 'model/report.dart';
import 'widgets/home.dart';

void main() async {
  Hive.registerAdapter(ReportAdapter()); 
  await Hive.initFlutter();
  await Hive.openBox(zebraBox);
  runApp(const ZebraApp());
}

class ZebraApp extends StatelessWidget {
  const ZebraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Zebra',
      theme: ThemeData(
        primaryColor: const Color.fromARGB(100, 65, 180, 255),
      ),
      home: const ZebraHomePage(),
    );
  }
}
