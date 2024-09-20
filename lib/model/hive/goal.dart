import "package:hive_flutter/hive_flutter.dart";

import "report.dart";

/// This allows the `Goal` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part "goal.g.dart";

/// This class is written to hive, so it needs a type adapter.
@HiveType(typeId: 3)
class Goal {
  Goal({ required this.name, required this.reports });

  @HiveField(0)
  String name;

  @HiveField(1)
  List<Report> reports;
}