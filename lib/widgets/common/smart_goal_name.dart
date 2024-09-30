
import "package:flutter/material.dart";

import "../../common/constants.dart";
import "goal_name.dart";

class SmartGoalName extends StatelessWidget {
  final String id;

  const SmartGoalName({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: getZebraBox(),
      builder: (context, box, widget) {
        // Render empty box when list of goals is empty.
        if (box.isEmpty) {
          return const SizedBox();
        }
        final selectedGoal = box.get(mainKey)?.goals[id];
        if (selectedGoal == null) {
          throw "Selected goal does not exist";
        }
        return GoalName(goalName: selectedGoal.name,);
    });
  }
}

