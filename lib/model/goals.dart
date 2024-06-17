
import 'dart:collection';

import 'package:flutter/material.dart';

import 'goal.dart';

class GoalsModel extends ChangeNotifier {
  /// Internal, private state of the cart.
  final Map<String, Goal> _goals = {};
  String? _selectedGoalKey;

  /// An unmodifiable view of the goals in the cart.
  UnmodifiableMapView<String, Goal> get goals => UnmodifiableMapView(_goals);

  /// Selected goal to view.
  String? get selectedGoal => _selectedGoalKey;

  /// Adds [goals] to list of goals. This clears any existing goals.
  void addAll(Map<String, Goal> goals) {
    _goals.clear();
    _goals.addAll(goals);
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