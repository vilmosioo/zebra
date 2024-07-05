import 'package:flutter/material.dart';
import 'package:flutter_native_select/flutter_native_select.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:zebra/model/goals.dart';

import '../common/constants.dart';

/// Widget to display a selector for a list of goals.
class GoalSelector extends StatelessWidget {
  const GoalSelector({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Consumer<GoalsModel>(
      builder: (context, model, child) {
        return ValueListenableBuilder(
          valueListenable: Hive.box(zebraBox).listenable(),
          builder: (context, box, widget) {
            // todo remove cast
            final goals = box.toMap();
            return _GoalSelectorInternal(goals, model.selectedGoal, model.setSelectedGoal);
          }
        );
      }
    );
  }
}
class _GoalSelectorInternal extends StatelessWidget {
  final Map<dynamic, dynamic> goals;
  final String? selectedGoal;
  final void Function(String?) onSelected;

  const _GoalSelectorInternal(this.goals, this.selectedGoal, this.onSelected);

  @override
  Widget build(BuildContext context) {
      if (goals.isEmpty) {
        // Render empty box when list of goals is empty.
        return const SizedBox();
      }
      final List<String> keys = List.from(goals.keys);
      // Sort keys by number of reports.
      keys.sort((a, b) {
        final aGoal = goals[a]!;
        final bGoal = goals[b]!;
        return bGoal.length - aGoal.length;
      });
      return ElevatedButton.icon(
        onPressed: () async {
          final s = await _showGoalSelect(keys);
          onSelected(s);
        },
        style: ElevatedButton.styleFrom(
          minimumSize: const Size.fromHeight(40), // fromHeight use double.infinity as width and 40 is the height
        ),
        icon: const Icon(Icons.expand_more_outlined),
        iconAlignment: IconAlignment.end,
        label: Text(selectedGoal?.replaceAll("#", "") ?? "Please select a goal"),
      );
  }
}

Future<String?> _showGoalSelect(List<String> goals) async {
  final selectedItem = await FlutterNativeSelect.openSelect(
    items: goals.map<NativeSelectItem>((String goal) {
      final String labelText = goal.replaceAll("#", "");
      return NativeSelectItem(value: goal, label: labelText);
    }).toList(),
  );
  
  return selectedItem;
}