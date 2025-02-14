import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CarouselItem extends StatelessWidget {
  const CarouselItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(right: 24),
      color: Colors.grey,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10)
      ),
      child: Column(
        children: [
          Expanded(
            flex: 5,
            child: Text("Image")
          ),
          Expanded(
            flex: 1,
            child: Text(
              "Name",
              textAlign: TextAlign.right,
            )
          ),
          Expanded(
            flex: 2,
            child: Text(
              "description",
              textAlign: TextAlign.start,
            )
          ),
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CupertinoButton(
                  child: Text("test 1"), 
                  onPressed: (){},
                  borderRadius: BorderRadius.circular(30),
                  sizeStyle: CupertinoButtonSize.large,
                ),
                CupertinoButton(
                  child: Text("test 1"), 
                  onPressed: (){},
                  borderRadius: BorderRadius.circular(50),
                  sizeStyle: CupertinoButtonSize.small,
                ),
              ],
            )
          ),
        ],
      ),
    );
  }
}