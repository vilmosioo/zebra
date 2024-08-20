
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../common/constants.dart';

class GoalsPage extends StatelessWidget {
  const GoalsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Hive.box(zebraBox).listenable(),
      builder: (context, box, widget) {
        final goals = box.toMap();
        if (goals.isEmpty) {
          // Render empty box when list of goals is empty.
          return const SizedBox();
        }
        final List<String> keys = List.from(goals.keys);
        // Sort keys by number of reports.
        keys.sort((a, b) {
          final aGoal = goals[a]!;
          final bGoal = goals[b]!;
          return bGoal.length - aGoal.length;
        });
        return ListView(
          padding: const EdgeInsets.all(8),
          children: keys.map<Widget>((String key) {
            final String labelText = "${key.replaceAll("#", "")} (${goals[key]?.length})";
            return Text(labelText);
          }).toList(),
        );
      }
    );
  }
}

