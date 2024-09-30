
import "package:flutter/material.dart";

import "../card.dart" as card_widget;
import "../common/smart_goal_name.dart";
import "../insights/heatmap.dart";
import "../insights/heatmap_calendar.dart";

class GoalPage extends StatelessWidget {
  final String? id;

  const GoalPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Zebra"),
      ),
      body: id != null ? Column(
        children: [
          SmartGoalName(id: id!),
          card_widget.Card(
            child: GoalsHeatMapCalendar(id: id!,)
          ),
          card_widget.Card(
            child: GoalsHeatMap(id: id!,)
          ),
        ]
      ) : const Text("No goal found."),
    );
  }
}