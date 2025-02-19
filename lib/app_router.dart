import 'package:flutter/material.dart';
import 'package:ar_map_project/features/home/presentation/pages/home_screen.dart';
import 'package:ar_map_project/features/login/presentation/pages/login_screen.dart';
import 'package:ar_map_project/features/armap/presentation/pages/armap_screen.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings){
    switch(settings.name){
      case '/':
        return MaterialPageRoute(builder: (_)=> const HomeScreen());
      case '/login':
        return MaterialPageRoute(builder: (_)=> const LoginScreen());
      case '/armap':
        return MaterialPageRoute(builder: (_)=> const ArmapScreen());
      default:
        return MaterialPageRoute(builder: (_)=>Scaffold(
          body: Center(child: Text("No route defined for ${settings.name}"))
        ));
    }
  }
}