

import "package:flutter/material.dart";


class GoalsModel extends ChangeNotifier {
  String? _selectedGoalKey;

  /// Selected goal to view.
  String? get selectedGoal => _selectedGoalKey;

  /// Adds [goal] to cart. This and [removeAll] are the only ways to modify the
  /// cart from the outside.
  void setSelectedGoal(String? goalKey) {
    _selectedGoalKey = goalKey;
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }
}
