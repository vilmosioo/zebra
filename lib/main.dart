import 'dart:io';

import 'package:english_words/english_words.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_archive/flutter_archive.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import 'globals.dart' as globals;
import 'select.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Zebra',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: globals.mainColor),
        ),
        home: const MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var current = WordPair.random();
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Zebra'),
        backgroundColor: globals.mainColor,
      ),
      body: Column(
        children: [
          const GoalSelector(),
          HeatMapCalendar(
            defaultColor: Colors.white,
            flexible: true,
            colorMode: ColorMode.color,
            datasets: {
              DateTime(2024, 6, 6): 1,
              DateTime(2024, 6, 7): 1,
              DateTime(2024, 6, 8): 1,
              DateTime(2024, 6, 9): 1,
              DateTime(2024, 6, 13): 1,
            },
            size: 12,
            borderRadius: 50,
            margin: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 10
            ),
            colorsets: const {
              1: globals.mainColor,
            },
          ),
        ]
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ["zip"], );

          if (result != null) {
            File file = File(result.files.single.path!);

            final destinationDir = await Directory.systemTemp.createTemp();
            try {
              await ZipFile.extractToDirectory(zipFile: file, destinationDir: destinationDir);
              
              Fluttertoast.showToast(
                msg: destinationDir.listSync().length.toString(),
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: globals.mainColor,
                fontSize: 16.0
              );
            } catch (e) {
              Fluttertoast.showToast(
                msg: "Failed to extract zip file",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: globals.mainColor,
                fontSize: 16.0
              );
            }
          } else {
            // User canceled the picker
          }
        },
        tooltip: 'Upload',
        child: const Icon(Icons.add),
      ),
    );
  }
}