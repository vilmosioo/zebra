
import "package:flutter/material.dart";

class GoalPage extends StatelessWidget {
  final String? goalName;

  const GoalPage({super.key, required this.goalName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Zebra"),
      ),
      body: Text(goalName ?? "No goal found."),
    );
  }
}