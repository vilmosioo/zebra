
import "package:flutter/material.dart";

import "../card.dart" as card_widget;
import "../insights/heatmap.dart";
import "../insights/heatmap_calendar.dart";

class GoalPage extends StatelessWidget {
  final String? goalName;

  const GoalPage({super.key, required this.goalName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Zebra"),
      ),
      body: goalName != null ? Column(
        children: [
          card_widget.Card(
            child: GoalsHeatMapCalendar(goalName: goalName!,)
          ),
          card_widget.Card(
            child: GoalsHeatMap(goalName: goalName!,)
          ),
        ]
      ) : const Text("No goal found."),
    );
  }
}