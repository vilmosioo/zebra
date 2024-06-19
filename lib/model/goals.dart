
import 'dart:collection';

import 'package:flutter/material.dart';

import 'report.dart';

class GoalsModel extends ChangeNotifier {
  /// Internal, private state of the cart.
  final Map<String, List<Report>> _goals = {};
  String? _selectedGoalKey;

  /// An unmodifiable view of the goals in the cart.
  UnmodifiableMapView<String, List<Report>> get goals => UnmodifiableMapView(_goals);

  /// Selected goal to view.
  String? get selectedGoal => _selectedGoalKey;

  /// Adds [goals] to list of goals. This clears any existing goals.
  void addAll(Map<String, List<Report>> goals) {
    _goals.clear();
    // Ignore empty goals and goals with only one entry, as they are not scheduled.
    _goals.addAll(goals..removeWhere((key, value) => value.isEmpty || value.length == 1));
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

  /// Adds [goal] to cart. This and [removeAll] are the only ways to modify the
  /// cart from the outside.
  void setSelectedGoal(String? goalKey) {
    _selectedGoalKey = goalKey;
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }
}
