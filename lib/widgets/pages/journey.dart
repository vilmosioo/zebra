
import "package:flutter/material.dart";
import "package:multi_select_flutter/multi_select_flutter.dart";

import "../../common/constants.dart";

class JourneyPage extends StatelessWidget {
  const JourneyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: getZebraBox(),
      builder: (context, box, widget) {
        final goals = box.get(mainKey)?.goals;
        if (goals == null || goals.isEmpty) {
          // Render empty box when list of goals is empty.
          return const SizedBox();
        }
        final List<String> goalNames = List.from(goals.keys);
        // Sort keys by number of reports.
        goalNames.sort((a, b) {
          final aGoal = goals[a]!;
          final bGoal = goals[b]!;
          return bGoal.reports.length - aGoal.reports.length;
        });
        return Scaffold(
          appBar: AppBar(
            title: const Text("Journey"),
          ),
          body: Column(
            children: [
              MultiSelectDialogField(
                items: goalNames.map((e) => MultiSelectItem(e, goals[e]?.name ?? "Unknown goal")).toList(),
                listType: MultiSelectListType.CHIP,
                onConfirm: (values) {
                  // _selectedAnimals = values;
                },
              ),
            ]
          ),
        );
      }
    );
  }
}

