import 'package:flutter/material.dart';
import '../models/spot_model.dart';

class SpotProvider with ChangeNotifier {
  List<SpotModel> _spots = [];
  
  List<SpotModel> get spots => _spots;

  void setSpots(List<SpotModel> spots) {
    _spots = spots;
    notifyListeners();
  }
}
