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
        return LayoutBuilder(builder: (context, constraints) {
          return DropdownMenu<String>(
            width: constraints.maxWidth - 20, // <-- This is necessary to force the menu items to the dropdown width.
            expandedInsets: const EdgeInsets.all(10), // <-- This is necessary to make the dropdown menu full with with some margin.
            dropdownMenuEntries: keys.map<DropdownMenuEntry<String>>((String key) {
              final String labelText = "${key.replaceAll("#", "")} (${model.goals[key]?.length})";
              return DropdownMenuEntry<String>(
                value: key,
                label: labelText,
                labelWidget: Text(
                    labelText,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
              );
            }).toList(),
            initialSelection: dropdownValue,
            onSelected: (String? value) {
              model.setSelectedGoal(value);
            }
          );
        });
      }
    );
  }
}