import 'package:flutter/material.dart';
import 'package:flutter_native_select/flutter_native_select.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import '../../common/constants.dart';
import '../../model/journeys.dart';

/// Widget to display a native selector for a list of goals.
class NativeJourneySelector extends StatelessWidget {
  const NativeJourneySelector({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Consumer<JourneysModel>(
      builder: (context, model, child) {
        return ValueListenableBuilder(
          valueListenable: Hive.box(zebraBox).listenable(),
          builder: (context, box, widget) {
            final goals = box.get(journeysKey);
            return _JourneySelectorInternal(goals, model.selectedJourney, model.setSelectedJourney);
          }
        );
      }
    );
  }
}
class _JourneySelectorInternal extends StatelessWidget {
  final Map<dynamic, dynamic> journeys;
  final String? selectedJourney;
  final void Function(String?) onSelected;

  const _JourneySelectorInternal(this.journeys, this.selectedJourney, this.onSelected);

  @override
  Widget build(BuildContext context) {
      if (journeys.isEmpty) {
        // Render empty box when list of goals is empty.
        return const SizedBox();
      }
      final List<String> keys = List.from(journeys.keys);
      // Sort keys by number of reports.
      keys.sort((a, b) {
        final aGoal = journeys[a]!;
        final bGoal = journeys[b]!;
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
        label: Text(selectedJourney?.replaceAll("#", "") ?? "Please select a goal"),
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