import 'package:hive_flutter/hive_flutter.dart';

/// This allows the `Report` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'report.g.dart';

/// This class is written to hive, so it needs a type adapter.
@HiveType(typeId: 1)
class Report {
  Report({ required this.date, required this.isCompleted });

  // @JsonKey(required: true, name: 'date')
  @HiveField(0)
  String date;

  // @JsonKey(required: true, name: 'isCompleted')
  @HiveField(1)
  bool isCompleted;
}