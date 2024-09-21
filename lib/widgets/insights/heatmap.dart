
import "package:flutter/material.dart";
import "package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart";
import "package:intl/intl.dart";

import "../../common/constants.dart";

// Thu, 9 Nov 2023 01:00:00
DateFormat format = DateFormat("E, d LLL y");

/// Widget to display a calendar heatmap of a specific goal.
class GoalsHeatMap extends StatelessWidget {
  final String id;

  const GoalsHeatMap({super.key, required this.id});

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
        final datasets = <DateTime, int>{};
        for (var report in selectedGoal.reports) {
          datasets[format.parse(report.date)] = report.isCompleted ? 1 : 0;
        }
        return HeatMap(
          defaultColor: Colors.white,
          colorMode: ColorMode.color,
          datasets: datasets,
          size: 40,
          borderRadius: 0,
          showColorTip: false,
          margin: const EdgeInsets.symmetric(
            vertical: 1,
            horizontal: 1
          ),
          colorsets: const {
            0: Color.fromARGB(50, 255, 0, 0),
            1: Color.fromARGB(100, 65, 180, 255),
          },
        );
      }
    );
  }
}