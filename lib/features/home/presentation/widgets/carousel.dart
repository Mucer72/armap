import 'package:flutter/material.dart';

import 'package:ar_map_project/common/utils/sizes.dart';
import 'package:ar_map_project/features/home/presentation/widgets/information_card.dart';

class Carousel extends StatefulWidget {
  const Carousel({super.key});

  @override
  State<Carousel> createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  final PageController _pageController = PageController(initialPage: 0, viewportFraction: 0.8);

  final List<Widget> _pages = [
    CarouselItem(),
    CarouselItem(),
    CarouselItem(),
    CarouselItem(),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      height: ScreenDimensions.height * 0.4, 
      child: PageView(
        controller: _pageController,
        children: _pages,
      ),
    );
  }
}