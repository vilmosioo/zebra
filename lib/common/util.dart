import "dart:convert";

import "package:archive/archive.dart";
import "package:file_picker/file_picker.dart";
import "../model/json/goal.dart";

/// Function that parses Finch zip export file and updates the goals model.
Future<Map<String, List<Goal>>> getAndParseFinchExport(FilePickerResult? result) async {
  if (result == null || !result.files.isNotEmpty) {
    return {};
  }
  final bytes = result.files.first.bytes?.toList();
  if (bytes == null) {
    return {};
  }
  try {
    final archive = ZipDecoder().decodeBytes(bytes);
    
    for (final file in archive) {
      // Goals are stored in Bullet.json
      if (file.isFile && file.name == "Bullet.json") {
        final goalBytes = file.content as List<int>;
        final goalsRaw = (jsonDecode(utf8.decode(goalBytes)) as Map<String, dynamic>)["data"];
        final goals = <String, List<Goal>>{};
        for (var goal in goalsRaw) {
          final g = Goal.fromJson(goal);
          // Only save repeating goals
          if (g.cadence?.periodFrequency != null) {
            if (goals[g.name] == null) {
              goals[g.name] = [];
            }
            goals[g.name]?.add(g);
          }
        }
        return goals;
      }
    }
    return {};
  } catch (e) {
    // ignore: avoid_print
    print("Failed to extract zip file$e");
    rethrow;
  }
}