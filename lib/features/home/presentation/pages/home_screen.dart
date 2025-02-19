import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:ar_map_project/features/home/presentation/widgets/search_bar.dart' as SearchBar;
import 'package:ar_map_project/features/home/presentation/widgets/name_banner.dart';
import 'package:ar_map_project/features/home/presentation/widgets/carousel.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      
      children: [
        NameBanner(),
        Align(
          alignment: Alignment.center,
          child: SearchBar.SearchBar(),
        ),
        Align(
          alignment: Alignment.topLeft, 
          child: Carousel()
        ),
      ],
    );
  }
}