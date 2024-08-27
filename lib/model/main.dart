import 'package:hive_flutter/hive_flutter.dart';

import 'report.dart';

/// This allows the `Main` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'main.g.dart';

/// This is the main data storage object for th3e entire application.
/// It is stored this way for better type safety.
/// Ideally, using a box for a list of goals is preferable, but that couldn't be achieved with type safety, as it requires casting.
/// Update once a better type friendly way is discovered.

/// This class is written to hive, so it needs a type adapter.
@HiveType(typeId: 2)
class Main {
  Main({ required this.goals });

  @HiveField(0)
  Map<String, List<Report>> goals;
}