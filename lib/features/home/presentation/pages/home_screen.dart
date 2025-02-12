import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(children: [
        FloatingActionButton(onPressed: ()=>Navigator.pushNamed(context, '/login'), child: Text("login"),),
        FloatingActionButton(onPressed: ()=>Navigator.pushNamed(context, '/armap'), child: Text("map"),),
      ],),
    );
  }
}