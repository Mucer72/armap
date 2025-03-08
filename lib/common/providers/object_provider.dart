import 'package:flutter/material.dart';
import '../models/object_model.dart';

class ObjectProvider with ChangeNotifier {
  List<ObjectModel> _objects = [];
  
  List<ObjectModel> get objects => _objects;

  void setObjects(List<ObjectModel> objects) {
    _objects = objects;
    notifyListeners();
  }
}
