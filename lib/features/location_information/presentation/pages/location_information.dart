import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
class InforPage extends StatefulWidget {
  const InforPage({super.key});

  @override
  State<InforPage> createState() => _InforPageState();
}

class _InforPageState extends State<InforPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("this is the page to display infor and other things"),
          CupertinoButton(
            child: Text("to the ar map"), 
            onPressed: (){
              Navigator.pushNamed(context, '/armap');
            }
          )
        ],
      )
    );
  }
}