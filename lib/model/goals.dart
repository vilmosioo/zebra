
import 'dart:collection';

import 'package:flutter/material.dart';

import 'goal.dart';

class GoalsModel extends ChangeNotifier {
  /// Internal, private state of the cart.
  final List<Goal> _goals = [];

  /// An unmodifiable view of the goals in the cart.
  UnmodifiableListView<Goal> get goals => UnmodifiableListView(_goals);

  /// The current total price of all goals (assuming all goals cost $42).
  int get totalPrice => _goals.length * 42;

  /// Adds [goal] to cart. This and [removeAll] are the only ways to modify the
  /// cart from the outside.
  void add(Goal goal) {
    _goals.add(goal);
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

  /// Removes all goals from the cart.
  void removeAll() {
    _goals.clear();
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }
}