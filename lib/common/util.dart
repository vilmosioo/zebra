import 'dart:convert';

import 'package:archive/archive.dart';
import 'package:file_picker/file_picker.dart';
import '../model/goal.dart';
import '../model/journey.dart';

/// Function that parses Finch zip export file and updates the journeys model.
Future<List<Journey>> getAndParseFinchExportForJourneys(FilePickerResult? result) async {
  final archive = await parseFinchExport(result);

  for (final file in archive) {
    // Goals are stored in Bullet.json
    if (file.isFile && file.name == "Bullet.json") {
      final goalBytes = file.content as List<int>;
      final journeyRaw = (jsonDecode(utf8.decode(goalBytes)) as Map<String, dynamic>)['data'];
      
      final journeys = <Journey>[];
      for (var journey in journeyRaw) {
        final g = Journey.fromJson(journey);
        // Journeys have type 3
        if (g.bulletType == 3) {
          journeys.add(g);
        }
      }
      return journeys;
    }
  }
  return List.empty();
}

/// Function that parses Finch zip export file and updates the goals model.
Future<Map<String, List<Goal>>> getAndParseFinchExport(FilePickerResult? result) async {
  final archive = await parseFinchExport(result);
  
  for (final file in archive) {
    // Goals are stored in Bullet.json
    if (file.isFile && file.name == "Bullet.json") {
      final goalBytes = file.content as List<int>;
      final goalsRaw = (jsonDecode(utf8.decode(goalBytes)) as Map<String, dynamic>)['data'];
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
}

/// Function that parses Finch zip export file and updates the goals model.
Future<Archive> parseFinchExport(FilePickerResult? result) async {
  if (result == null || !result.files.isNotEmpty) {
    throw "Failed to read file, zip is empty.";
  }
  final bytes = result.files.first.bytes?.toList();
  if (bytes == null) {
    throw "Failed to read bytes from zip file";
  }
  try {
    final archive = ZipDecoder().decodeBytes(bytes);
    return archive;
  } catch (e) {
    // ignore: avoid_print
    print("Failed to extract zip file$e");
    rethrow;
  }
}