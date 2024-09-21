
import "package:flutter/material.dart";
import "package:go_router/go_router.dart";

import "../../model/hive/goal.dart"  as model;
import "goal_name.dart";

class Goal extends StatelessWidget {
  final model.Goal goal;

  const Goal({super.key, required this.goal});

  @override
  Widget build(BuildContext context) {
    // final navigator = Navigator.of(context);
    return Container(
      // We need to wrap button in container because we can't set margins.
      margin: const EdgeInsets.only(bottom: 3),
      child: ElevatedButton(
        onPressed: () {
          GoRouter.of(context).goNamed("goal", pathParameters: {"id": goal.id});
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).primaryColor,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(2)),
          ),
        ),
        child: GoalName(completion: goal.reports.length, goalName: goal.name,)
      )
    );
    // return Container(
    //   height: 50,
    //   margin: const EdgeInsets.only(bottom: 3),
    //   color: Theme.of(context).primaryColor,
    //   child: Center(child: GoalName(completion: reports.length, goalName: goalName,)),
    // );
  }
}

