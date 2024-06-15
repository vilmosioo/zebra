
import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';


/// Widget to display a calendar heatmap of a specific goal.
class HeatMap extends StatelessWidget {
  const HeatMap({super.key});

  @override
  Widget build(BuildContext context) {
    return HeatMapCalendar(
      defaultColor: Colors.white,
      colorMode: ColorMode.color,
      datasets: {
        DateTime(2024, 6, 6): 1,
        DateTime(2024, 6, 7): 1,
        DateTime(2024, 6, 8): 1,
        DateTime(2024, 6, 9): 1,
        DateTime(2024, 6, 13): 1,
      },
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
}