import 'package:flutter/material.dart';

import 'package:ar_map_project/features/home/presentation/widgets/search_bar.dart' as SearchBar;
import 'package:ar_map_project/features/home/presentation/widgets/name_banner.dart';
import 'package:ar_map_project/features/home/presentation/widgets/carousel.dart';
import 'package:ar_map_project/common/widgets/minimap.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: NameBanner(name: "AR MAP APP"),
        ),
       Align(
          alignment: Alignment.center,
          child: SearchBar.SearchBar(),
       ),
        Expanded(
          child: Carousel()
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Minimap(),
        )
      ],
    ),
    resizeToAvoidBottomInset: false,
    );
  }
}