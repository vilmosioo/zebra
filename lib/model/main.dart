import 'package:hive_flutter/hive_flutter.dart';

import 'report.dart';

/// This allows the `Main` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'main.g.dart';

/// This class is written to hive, so it needs a type adapter.
@HiveType(typeId: 1)
class Main {
  Main({ required this.goals });

  // @JsonKey(required: true, name: 'date')
  @HiveField(0)
  Map<String, List<Report>> goals;
}