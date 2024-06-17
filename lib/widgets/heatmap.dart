
import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../model/goals.dart';

// Thu, 9 Nov 2023 01:00:00
DateFormat format = DateFormat("E, d LLL y H:m:s");

/// Widget to display a calendar heatmap of a specific goal.
class HeatMap extends StatelessWidget {
  const HeatMap({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<GoalsModel>(
      builder: (context, model, child) {
        final selectedGoal = model.goals[model.selectedGoal];
        if (selectedGoal == null) {
          // Render empty box when list of goals is empty.
          return const SizedBox();
        }
        final datasets = <DateTime, int>{};
        for (var report in selectedGoal) {
          datasets[format.parse(report.date)] = report.isCompleted ? 1 : 0;
        }
        return HeatMapCalendar(
          defaultColor: Colors.white,
          colorMode: ColorMode.color,
          datasets: datasets,
          size: 50,
          borderRadius: 100,
          showColorTip: false,
          margin: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 10
          ),
          colorsets: const {
            1: Color.fromARGB(100, 65, 180, 255),
          },
        );
      }
    );
  }
}