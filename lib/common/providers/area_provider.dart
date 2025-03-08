import 'package:flutter/material.dart';
import '../models/area_model.dart';

class AreaProvider with ChangeNotifier {
  AreaModel? _area;
  
  AreaModel? get area => _area;

  void setArea(AreaModel area) {
    _area = area;
    notifyListeners();
  }
}
