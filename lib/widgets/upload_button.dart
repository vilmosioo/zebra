import 'dart:convert';

import 'package:archive/archive.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:zebra/model/goal.dart';


/// Widget that display an upload button that accepts Finch backup zip file.
/// Once upload and parsing is complete, returns a list of goals.
class UploadButton extends StatelessWidget {
  const UploadButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
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
                    final goals = <String, Goal>{};
                    for (var goal in goalsRaw) {
                      final g = Goal.fromJson(goal);
                      goals[g.name] = g;
                    }
                    Fluttertoast.showToast(
                      msg: goals.keys.toString(),
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
      );
  }
}