
import "package:flutter/material.dart";
import "package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart";
import "package:intl/intl.dart";

import "../../common/constants.dart";

// Thu, 9 Nov 2023 01:00:00
DateFormat format = DateFormat("E, d LLL y");

/// Widget to display a calendar heatmap of a specific goal.
class GoalsHeatMapCalendar extends StatelessWidget {
  final String goalName;

  const GoalsHeatMapCalendar({super.key, required this.goalName});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: getZebraBox(),
      builder: (context, box, widget) {
        // Render empty box when list of goals is empty.
        if (box.isEmpty) {
          return const SizedBox();
        }
        final selectedGoal = box.get(mainKey)?.goals[goalName];
        if (selectedGoal == null) {
          throw "Selected goal does not exist";
        }
        final datasets = <DateTime, int>{};
        for (var report in selectedGoal.reports) {
          datasets[format.parse(report.date)] = report.isCompleted ? 1 : 0;
        }
        final max = datasets.keys.reduce((a,b) => a.isAfter(b) ? a : b);
        return HeatMapCalendar(
          defaultColor: Colors.white,
          colorMode: ColorMode.color,
          datasets: datasets,
          initDate: max,
          size: 40,
          borderRadius: 100,
          showColorTip: false,
          margin: const EdgeInsets.symmetric(
            vertical: 5,
            horizontal: 5
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