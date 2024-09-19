
import "package:flutter/material.dart";

import "../card.dart" as card_widget;
import "../insights/heatmap.dart";

class GoalPage extends StatelessWidget {
  final String? goalName;

  const GoalPage({super.key, required this.goalName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Zebra"),
      ),
      body: goalName != null ? card_widget.Card(
        child: GoalsHeatMap(goalName: goalName!,)
      ) : const Text("No goal found."),
    );
  }
}