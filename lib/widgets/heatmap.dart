
import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../common/constants.dart';
import '../model/goals.dart';
import '../model/report.dart';

// Thu, 9 Nov 2023 01:00:00
DateFormat format = DateFormat("E, d LLL y");

/// Widget to display a calendar heatmap of a specific goal.
class HeatMap extends StatelessWidget {
  const HeatMap({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<GoalsModel>(
      builder: (context, model, child) {
        return ValueListenableBuilder(
          valueListenable: Hive.box<List<Report>>(zebraBox).listenable(),
          builder: (context, box, widget) {
            // Render empty box when list of goals is empty.
            if (box.isEmpty) {
              return const SizedBox();
            }
            // Render empty box when no goal is selected.
            if (model.selectedGoal == null) {
              return const SizedBox();
            }
            final selectedGoal = box.get(model.selectedGoal);
            if (selectedGoal == null) {
              throw "Selected goal does not exist";
            }
            final datasets = <DateTime, int>{};
            for (var report in selectedGoal) {
              datasets[format.parse(report.date)] = report.isCompleted ? 1 : 0;
            }
            final max = datasets.keys.reduce((a,b) => a.isAfter(b) ? a : b);
            return HeatMapCalendar(
              defaultColor: Colors.white,
              colorMode: ColorMode.color,
              datasets: datasets,
              initDate: max,
              size: 50,
              borderRadius: 100,
              showColorTip: false,
              margin: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 10
              ),
              colorsets: const {
                0: Color.fromARGB(50, 255, 0, 0),
                1: Color.fromARGB(100, 65, 180, 255),
              },
            );
          }
        );
      }
    );
  }
}