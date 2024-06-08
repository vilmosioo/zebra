import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import 'globals.dart' as globals;

void main() {
  runApp(MyApp());
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
        home: MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var current = WordPair.random();
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Zebra'),
        backgroundColor: globals.mainColor,
      ),
      body: Center(
        child: HeatMapCalendar(
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
          margin: EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 10
          ),
          colorsets: const {
            1: globals.mainColor,
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ["zip"], );

          if (result != null) {
            PlatformFile file = result.files.first;

            Fluttertoast.showToast(
              msg: file.name,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: globals.mainColor,
              fontSize: 16.0
            );
          } else {
            // User canceled the picker
          }
        },
        tooltip: 'Upload',
        child: Icon(Icons.add),
      ),
    );
  }
}