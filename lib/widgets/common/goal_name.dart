
import 'package:flutter/material.dart';

class GoalName extends StatelessWidget {
  final String goalName;
  final int completion;

  const GoalName({super.key, required this.goalName, required this.completion});

  @override
  Widget build(BuildContext context) {
    final String labelText = "${goalName.replaceAll("#", "")} ($completion)";
    return Text(labelText);
  }
}

