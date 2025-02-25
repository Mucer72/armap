import 'package:flutter/cupertino.dart';


class SearchBar extends StatefulWidget {

const SearchBar({super.key});

@override
State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
final TextEditingController _controller = TextEditingController();

@override
Widget build(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 15),
    child: CupertinoSearchTextField(
      controller: _controller,
      onTap: () {},
    ),
  );
}
}
