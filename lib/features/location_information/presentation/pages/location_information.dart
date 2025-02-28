import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_compass/flutter_compass.dart';
class InforPage extends StatefulWidget {
  const InforPage({super.key});

  @override
  State<InforPage> createState() => _InforPageState();
}

  double _getHeading(){
    double heading = 0.0;
    FlutterCompass.events?.listen((CompassEvent event) {
      heading = ((event.heading!<1?event.heading!+360:event.heading)!-1).floorToDouble();
      //Only for fine-tuning: +10 degree
      //heading = ((event.heading!-10<1?event.heading!+360:event.heading!+10)-1).floorToDouble();
    });
    if(kDebugMode){
      debugPrint("heading direction: $heading");
    }
    return heading;
  }

class _InforPageState extends State<InforPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(stream: FlutterCompass.events, 
      builder: (context, snapshot){
        return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("this is the page to display infor and other things"),
          CupertinoButton(
            child: Text("to the ar map"), 
            onPressed: (){
              Navigator.pushNamed(context, '/armap', arguments: snapshot.data?.heading);
            }
          )
        ],
      )
      })
    );
  }
}