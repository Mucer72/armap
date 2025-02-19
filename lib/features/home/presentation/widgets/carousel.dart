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
    const CarouselItem(imageURL: "https://picsum.photos/seed/2mikey1/500/300",name: "Loc1",description: "1",),
    const CarouselItem(imageURL: "https://picsum.photos/seed/2mikey3/500/300",name: "Loc2",description: "2",),
    const CarouselItem(imageURL: "https://picsum.photos/seed/2mikey4/500/300",name: "Loc3",description: "3",),
    const CarouselItem(imageURL: "https://picsum.photos/seed/2mikey2/500/300",name: "Loc4",description: "4",),
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
      margin: const EdgeInsets.only(top: 20),
      height: ScreenDimensions.height * 0.4, 
      child: PageView(
        controller: _pageController,
        children: _pages,
      ),
    );
  }
}