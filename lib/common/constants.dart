import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../model/main.dart';

const zebraBox = "ZebraBox";

ValueListenable<Box<Main>> getZebraBox() {
  return Hive.box<Main>(zebraBox).listenable();
}