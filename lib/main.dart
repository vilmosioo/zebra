import 'dart:convert';

import 'package:archive/archive.dart';
import 'package:english_words/english_words.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_archive/flutter_archive.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:zebra/model/goal.dart';

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
          primaryColor: const Color.fromARGB(100, 65, 180, 255),
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
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const GoalSelector(),
          HeatMapCalendar(
            defaultColor: Colors.white,
            colorMode: ColorMode.color,
            datasets: {
              DateTime(2024, 6, 6): 1,
              DateTime(2024, 6, 7): 1,
              DateTime(2024, 6, 8): 1,
              DateTime(2024, 6, 9): 1,
              DateTime(2024, 6, 13): 1,
            },
            size: 50,
            borderRadius: 100,
            showColorTip: false,
            margin: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 10
            ),
            colorsets: const {
              1: Color.fromARGB(100, 65, 180, 255),
            },
          ),
        ]
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ["zip"], withData: true );

          if (result != null && result.files.isNotEmpty) {
            final bytes = result.files.first.bytes?.toList();
            if (bytes != null) {
              try {
                final archive = ZipDecoder().decodeBytes(bytes);
                
                for (final file in archive) {
                  if (file.isFile && file.name == "Bullet.json") {
                    final goalBytes = file.content as List<int>;
                    final goalRaw = utf8.decode(goalBytes);
                    final goalsRaw = (jsonDecode(goalRaw) as Map<String, dynamic>)['data'];
                    final goals = [];
                    for (var goal in goalsRaw) {
                      goals.add(Goal.fromJson(goal));
                    }
                    Fluttertoast.showToast(
                      msg: goals.length.toString(),
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      fontSize: 16.0,
                    );
                  }
                }
              } catch (e) {
                Fluttertoast.showToast(
                  msg: "Failed to extract zip file$e",
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  fontSize: 16.0
                );
              }
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