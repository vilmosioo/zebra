
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/goals.dart';
import 'goal_selector.dart';
import 'heatmap.dart';
import 'heatmap_calendar.dart';
import 'upload_button.dart';

class ZebraHomePage extends StatelessWidget {
  const ZebraHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GoalsModel(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Zebra'),
        ),
        body: const Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GoalSelector(),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: GoalsHeatMap()
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: GoalsHeatMapCalendar()
            ),
          ]
        ),
        floatingActionButton: const UploadButton(),
      )
    );
  }
}