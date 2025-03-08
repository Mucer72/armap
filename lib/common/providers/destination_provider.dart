import 'package:flutter/material.dart';
import '../models/destination_model.dart';

class DestinationProvider with ChangeNotifier {
  List<DestinationModel> _destinations = [];
  
  List<DestinationModel> get destinations => _destinations;

  void setDestinations(List<DestinationModel> destinations) {
    _destinations = destinations;
    notifyListeners();
  }
}
