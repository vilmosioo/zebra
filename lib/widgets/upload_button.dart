
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../common/util.dart';
import '../model/goals.dart';


/// Widget that display an upload button that accepts Finch backup zip file.
/// Once upload and parsing is complete, returns a list of goals.
class UploadButton extends StatelessWidget {
  const UploadButton({super.key});

  @override
  Widget build(BuildContext context) {
    var goalsModel = context.watch<GoalsModel>();
    return FloatingActionButton(
        onPressed: () async {
          try {
            FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ["zip"], withData: true );
            final goals = await getAndParseFinchExport(result);
            
            for (var key in goals.keys) {
              goalsModel.add(goals[key]!);
            }
            print(goals.keys);
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
              timeInSecForIosWeb: 1,
              fontSize: 16.0
            );
          }
        },
        tooltip: 'Upload',
        child: const Icon(Icons.add),
      );
  }
}