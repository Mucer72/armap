import 'package:flutter/material.dart';

class ScreenDeimensions{
  static late double height;
  static late double width;

  static void initialize(BuildContext context){
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
  }
}