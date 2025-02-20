import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CarouselItem extends StatelessWidget {
  final String imageURL;
  final String name;
  final String description;
  const CarouselItem({super.key, required this.imageURL, required this.name, required this.description});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(right: 24),
      color: Colors.grey,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 5,
            child: ClipRRect(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
              child: ShaderMask(
      shaderCallback: (bounds) {
        return LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.white, Colors.transparent],
          stops: [1.0 - (25 / bounds.height), 1.0],
        ).createShader(bounds);
      },
      blendMode: BlendMode.dstIn, 
      child: Image.network(
        imageURL,
        fit: BoxFit.cover,
        height: double.infinity,
        width: double.infinity, 
      ),
    )
            )
          ),
          Expanded(
            flex: 1,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
              name,
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            )
          ),
          Expanded(
            flex: 2,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
              description,
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 16
              )
            ),
            )
          ),
          Expanded(
            flex: 2,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  flex: 4,
                  child: Container(
                  margin: EdgeInsets.only(right: 10),  
                  child: CupertinoButton(
                  onPressed: (){},
                  color: CupertinoColors.quaternaryLabel,
                  borderRadius: BorderRadius.circular(15),
                  child: Text("Add to your tour",
                  style: TextStyle(
                    color: CupertinoColors.label
                  ),
                  ),
                ),
                  ),),
                Expanded(
                  flex: 1,
                  child: CupertinoButton(
                  onPressed: (){
                    Navigator.pushNamed(context, '/inforPage');
                  },
                  padding: EdgeInsets.zero,
                  color: CupertinoColors.quaternaryLabel,
                  borderRadius: BorderRadius.circular(30),
                  minSize: 30,
                  child: SizedBox(
                    height: 55,
                    child: Center(
                      child: Icon(CupertinoIcons.right_chevron, color: CupertinoColors.label,),
                    ),
                  )
                  ))
              ],
            ),
            )
          ),
        ],
      ),
    );
  }
}