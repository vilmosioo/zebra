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
        return DropdownMenu<String>(
          dropdownMenuEntries: model.goals.keys.map<DropdownMenuEntry<String>>((String key) {
            final goal = model.goals[key]!;
            return DropdownMenuEntry<String>(
              value: goal.name,
              label: goal.name,
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