
import 'package:flutter/material.dart';

import '../../model/report.dart';
import 'goal_name.dart';

class Goal extends StatelessWidget {
  final String goalName;
  final List<Report> reports;

  const Goal({super.key, required this.goalName, required this.reports});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      margin: const EdgeInsets.only(bottom: 3),
      color: Theme.of(context).primaryColor,
      child: Center(child: GoalName(completion: reports.length, goalName: goalName,)),
    );
  }
}

