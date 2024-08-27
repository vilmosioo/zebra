import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../model/main.dart';

/// Name of the Hive box used by Zebra.
const zebraBox = "ZebraBox";
/// Key of the global main application state.
const mainKey = "main";

ValueListenable<Box<Main>> getZebraBox() {
  return Hive.box<Main>(zebraBox).listenable();
}