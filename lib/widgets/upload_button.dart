
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../common/constants.dart';
import '../common/hive_util.dart';
import '../common/util.dart';


/// Widget that display an upload button that accepts Finch backup zip file.
/// Once upload and parsing is complete, returns a list of goals.
class UploadButton extends StatelessWidget {
  const UploadButton({super.key});

  Future<void> import(Box box) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ["zip"], withData: true );
      final journeys = await getAndParseFinchExportForJourneys(result);
      await saveJourneys(box, journeys);
      Fluttertoast.showToast(
        msg: "Imported ${journeys.length} journeys",
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
      valueListenable: Hive.box(zebraBox).listenable(),
      builder: (context, box, widget) {
        closeDialog() => {
          Navigator.pop(context, 'Cancel')
        };
        final onPressed = box.isEmpty ? (
          () => import(box)
        ) : (
          () => showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: const Text('Warning'),
              content: const Text('Uploading a new export zip file will erase any existing data. Are you sure you want to continue importing a new file?'),
              actions: <Widget>[
                TextButton(
                  onPressed: closeDialog,
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () async { 
                    await import(box);
                    closeDialog();
                  },
                  child: const Text('Import'),
                ),
              ],
            ),
          )
        );
        return FloatingActionButton(
          onPressed: onPressed,
          tooltip: 'Upload',
          child: const Icon(Icons.add),
        );
      }
    );
  }
}