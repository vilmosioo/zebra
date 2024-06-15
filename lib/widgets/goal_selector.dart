import 'package:flutter/material.dart';

const List<String> list = <String>['goal1', 'goal2', 'goal3', 'goal4', "goal5", "goal6"];

/// Widget to display a selector for a list of goals.
class GoalSelector extends StatefulWidget {
  const GoalSelector({super.key});

  @override
  State<StatefulWidget> createState() => _GoalSelectorState();
}

class _GoalSelectorState extends State<GoalSelector> {
  String dropdownValue = list.first;
  
  @override
  Widget build(BuildContext context) {
    return DropdownMenu<String>(
      dropdownMenuEntries: list.map<DropdownMenuEntry<String>>((String value) {
        return DropdownMenuEntry<String>(
          value: value,
          label: value,
        );
      }).toList(),
      // enableFilter: list.length > 5,
      // enableSearch: list.length > 5,
      initialSelection: dropdownValue,
      onSelected: (String? value) {
        setState(() {
          dropdownValue = value!;
        });
      }
    );
  }
}