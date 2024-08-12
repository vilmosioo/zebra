

import 'package:flutter/material.dart';


class JourneysModel extends ChangeNotifier {
  String? _selectedJourneyKey;

  /// Selected goal to view.
  String? get selectedJourney => _selectedJourneyKey;

  /// Sets selected [journeyKey]. This is the only ways to modify the model from the outside.
  void setSelectedJourney(String? journeyKey) {
    _selectedJourneyKey = journeyKey;
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }
}
