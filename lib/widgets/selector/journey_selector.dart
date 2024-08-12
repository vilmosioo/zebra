import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import '../../common/constants.dart';
import '../../common/hive_util.dart';
import '../../model/journeys.dart';

/// Widget to display a selector for a list of goals.
class JourneySelector extends StatefulWidget {
  const JourneySelector({super.key});

  @override
  State<StatefulWidget> createState() => _JourneySelectorState();
}

class _JourneySelectorState extends State<JourneySelector> {
  String? dropdownValue;
  
  @override
  Widget build(BuildContext context) {
    return Consumer<JourneysModel>(
      builder: (context, model, child) {
        return ValueListenableBuilder(
          valueListenable: Hive.box(zebraBox).listenable(),
          builder: (context, box, widget) {
            final data = getJourneys(box);
            if (data == null || data.isEmpty) {
              // Render empty box when list of journeys is empty.
              return const SizedBox();
            }
            final List<String> keys = data.keys.toList();
            return LayoutBuilder(builder: (context, constraints) {
              return DropdownMenu<String>(
                width: constraints.maxWidth - 20, // <-- This is necessary to force the menu items to the dropdown width.
                expandedInsets: const EdgeInsets.all(10), // <-- This is necessary to make the dropdown menu full with with some margin.
                dropdownMenuEntries: keys.map<DropdownMenuEntry<String>>((String key) {
                  final String labelText = key.replaceAll("#", "");
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
                  model.setSelectedJourney(value);
                }
              );
            });
          }
        );
      }
    );
  }
}