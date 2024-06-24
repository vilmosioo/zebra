
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../common/constants.dart';
import '../common/util.dart';
import '../model/report.dart';


/// Widget that display an upload button that accepts Finch backup zip file.
/// Once upload and parsing is complete, returns a list of goals.
class UploadButton extends StatelessWidget {
  const UploadButton({super.key});

  @override
  Widget build(BuildContext context) {
    final box = Hive.box<List<Report>>(zebraBox);
    return FloatingActionButton(
      onPressed: () async {
        try {
          FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ["zip"], withData: true );
          final goals = await getAndParseFinchExport(result);
          final reports = <String, List<Report>>{};
          for (var key in goals.keys) {
            final goal = goals[key];
            if (goal == null) {
              continue;
            }
            if (reports[key] == null) {
              reports[key] = [];
            }
            for (var g in goal) {
              reports[key]?.add(Report(g.date, g.completedTime != ""));
            }
          }
          await box.clear();
          await box.putAll(reports);
          Fluttertoast.showToast(
            msg: "Imported",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            fontSize: 16.0,
          );
        } catch (e) {
          Fluttertoast.showToast(
            msg: "Failed to extract zip file$e",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 10,
            fontSize: 16.0
          );
        }
      },
      tooltip: 'Upload',
      child: const Icon(Icons.add),
    );
  }
}