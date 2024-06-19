import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zebra/model/goals.dart';

/// Widget to display a selector for a list of goals.
class GoalSelector extends StatefulWidget {
  const GoalSelector({super.key});

  @override
  State<StatefulWidget> createState() => _GoalSelectorState();
}

class _GoalSelectorState extends State<GoalSelector> {
  String? dropdownValue;
  
  @override
  Widget build(BuildContext context) {
    return Consumer<GoalsModel>(
      builder: (context, model, child) {
        if (model.goals.isEmpty) {
          // Render empty box when list of goals is empty.
          return const SizedBox();
        }
        final List<String> keys = List.from(model.goals.keys);
        // Sort keys by number of reports.
        keys.sort((a, b) {
          final aGoal = model.goals[a]!;
          final bGoal = model.goals[b]!;
          return bGoal.length - aGoal.length;
        });
        return DropdownMenu<String>(
          dropdownMenuEntries: keys.map<DropdownMenuEntry<String>>((String key) {
            return DropdownMenuEntry<String>(
              value: key,
              label: "${key.replaceAll("#", "")} (${model.goals[key]?.length})",
            );
          }).toList(),
          initialSelection: dropdownValue,
          onSelected: (String? value) {
            model.setSelectedGoal(value);
          }
        );
      }
    );
  }
}