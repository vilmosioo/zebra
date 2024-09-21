
import "package:flutter/material.dart";
import "package:go_router/go_router.dart";

import "../../model/hive/report.dart";
import "goal_name.dart";

class Goal extends StatelessWidget {
  final String goalName;
  final List<Report> reports;

  const Goal({super.key, required this.goalName, required this.reports});

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
        child: GoalName(completion: reports.length, goalName: goalName,)
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

