
import 'package:flutter/material.dart';

import 'goal_selector.dart';
import 'heatmap.dart';
import 'upload_button.dart';

class ZebraHomePage extends StatelessWidget {
  const ZebraHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Zebra'),
      ),
      body: const Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          GoalSelector(),
          HeatMap(),
        ]
      ),
      floatingActionButton: const UploadButton(),
    );
  }
}