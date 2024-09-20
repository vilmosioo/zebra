
import "package:file_picker/file_picker.dart";
import "package:flutter/material.dart";
import "package:fluttertoast/fluttertoast.dart";
import "package:hive_flutter/hive_flutter.dart";

import "../common/constants.dart";
import "../common/util.dart";
import "../model/hive/goal.dart";
import "../model/hive/main.dart";
import "../model/hive/report.dart";


/// Widget that display an upload button that accepts Finch backup zip file.
/// Once upload and parsing is complete, returns a list of goals.
class UploadButton extends StatelessWidget {
  const UploadButton({super.key});

  Future<void> import(Box<Main> box) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ["zip"], withData: true );
      final goals = await getAndParseFinchExport(result);
      final reports = <String, Goal>{};
      for (var key in goals.keys) {
        final goal = goals[key];
        if (goal == null) {
          continue;
        }
        if (reports[key] == null) {
          reports[key] = Goal(name: key, reports: []);
        }
        for (var g in goal) {
          reports[key]?.reports.add(Report(date: g.date, isCompleted: g.completedTime != ""));
        }
      }
      await box.delete(mainKey);
      await box.put(mainKey, Main(goals: reports));
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
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: getZebraBox(),
      builder: (context, box, widget) {
        closeDialog() => {
          Navigator.pop(context, "Cancel")
        };
        final onPressed = box.isEmpty ? (
          () => import(box)
        ) : (
          () => showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: const Text("Warning"),
              content: const Text("Uploading a new export zip file will erase any existing data. Are you sure you want to continue importing a new file?"),
              actions: <Widget>[
                TextButton(
                  onPressed: closeDialog,
                  child: const Text("Cancel"),
                ),
                TextButton(
                  onPressed: () async { 
                    await import(box);
                    closeDialog();
                  },
                  child: const Text("Import"),
                ),
              ],
            ),
          )
        );
        return FloatingActionButton(
          onPressed: onPressed,
          tooltip: "Upload",
          child: const Icon(Icons.add),
        );
      }
    );
  }
}