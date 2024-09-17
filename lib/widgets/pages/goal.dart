
import "package:flutter/material.dart";
import "package:provider/provider.dart";

import "../../model/goals.dart";

class GoalPage extends StatelessWidget {
  final String? goalName;

  const GoalPage({super.key, required this.goalName});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GoalsModel(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Zebra"),
        ),
        body: Text(goalName ?? "No goal found."),
      )
    );
  }
}