
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/goals.dart';
import 'card.dart' as card_widget;
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
            card_widget.Card(
              child: GoalsHeatMap()
            ),
            card_widget.Card(
              child: GoalsHeatMapCalendar()
            ),
          ]
        ),
        floatingActionButton: const UploadButton(),
      )
    );
  }
}