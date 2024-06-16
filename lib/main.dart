
import 'package:flutter/material.dart';

import 'widgets/home.dart';

void main() {
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
