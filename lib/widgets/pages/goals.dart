
import 'package:flutter/material.dart';

import '../../common/constants.dart';
import '../common/goal.dart';

class GoalsPage extends StatelessWidget {
  const GoalsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: getZebraBox(),
      builder: (context, box, widget) {
        final goals = box.get(mainKey)?.goals;
        if (goals == null || goals.isEmpty) {
          // Render empty box when list of goals is empty.
          return const SizedBox();
        }
        final List<String> goalNames = List.from(goals.keys);
        // Sort keys by number of reports.
        goalNames.sort((a, b) {
          final aGoal = goals[a]!;
          final bGoal = goals[b]!;
          return bGoal.length - aGoal.length;
        });
        return ListView.builder(
          itemCount: goalNames.length,
          itemBuilder: (BuildContext context, int index) {
            return Goal(goalName: goalNames[index], reports: goals[goalNames[index]] ?? List.empty());
          }
        );
      }
    );
  }
}

