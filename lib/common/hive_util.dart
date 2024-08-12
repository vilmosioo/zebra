
import 'package:hive_flutter/hive_flutter.dart';

import '../model/journey.dart';
import 'constants.dart';

Map<String, Journey>? getJourneys(Box box) {
  final journeys = box.get(journeysKey) as Map<String, Journey>?;
  return journeys;
}

Future<void> saveJourneys(Box box, List<Journey> journeys) async {
  await box.delete(journeysKey);
  await box.put(journeysKey, { for (var v in journeys) v.name : v });
}
      