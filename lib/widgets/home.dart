
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/goals.dart';
import 'card.dart' as card_widget;
import 'insights/heatmap.dart';
import 'insights/heatmap_calendar.dart';
import 'selector/goal_selector.dart';
import 'selector/journey_selector.dart';
import 'selector/native_goal_selector.dart';
import 'upload_button.dart';

class ZebraHomePage extends StatelessWidget {
  const ZebraHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final platform = Theme.of(context).platform;
    bool isMobile = platform == TargetPlatform.iOS || platform == TargetPlatform.android;
    return ChangeNotifierProvider(
      create: (context) => GoalsModel(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Zebra'),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            isMobile ? const NativeGoalSelector() : const JourneySelector(),
            const card_widget.Card(
              child: GoalsHeatMap()
            ),
            const card_widget.Card(
              child: GoalsHeatMapCalendar()
            ),
          ]
        ),
        floatingActionButton: const UploadButton(),
      )
    );
  }
}