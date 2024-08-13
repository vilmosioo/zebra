
import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../common/constants.dart';
import '../../common/hive_util.dart';
import '../../model/journeys.dart';

// Thu, 9 Nov 2023 01:00:00
DateFormat format = DateFormat("E, d LLL y");

/// Widget to display a calendar heatmap of a specific journey.
class JourneyHeatMap extends StatelessWidget {
  const JourneyHeatMap({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<JourneysModel>(
      builder: (context, model, child) {
        return ValueListenableBuilder(
          valueListenable: Hive.box(zebraBox).listenable(),
          builder: (context, box, widget) {
            // Render empty box when list of goals is empty.
            if (box.isEmpty) {
              return const SizedBox();
            }
            // Render empty box when no goal is selected.
            if (model.selectedJourney == null) {
              return const SizedBox();
            }
            final selectedJourney = getSelectedJourney(box, model.selectedJourney);
            if (selectedJourney == null) {
              throw "Selected goal does not exist";
            }
            final datasets = <DateTime, int>{};
            // todo get datasets from selected journey
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
    );
  }
}