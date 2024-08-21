import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../model/report.dart';

const zebraBox = "ZebraBox";

ValueListenable<Box<List<Report>>> getZebraBox() {
  return Hive.box<List<Report>>(zebraBox).listenable();
}