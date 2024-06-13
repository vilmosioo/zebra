import 'package:flutter/material.dart';

const List<String> list = <String>['vioo1', 'vioo2', 'vioo3', 'vioo4', "vioo5", "vioo6"];

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
      enableFilter: list.length > 5,
      enableSearch: list.length > 5,
      initialSelection: dropdownValue,
      onSelected: (String? value) {
        setState(() {
          dropdownValue = value!;
        });
      }
    );
  }
}