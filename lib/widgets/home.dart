
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/goals.dart';
import 'goal_selector.dart';
import 'heatmap.dart';
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
            GoalsHeatMap(),
          ]
        ),
        floatingActionButton: const UploadButton(),
      )
    );
  }
}