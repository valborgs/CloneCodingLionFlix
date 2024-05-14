import 'package:flutter/material.dart';

class SearchTopAppBar extends StatefulWidget implements PreferredSizeWidget {
  const SearchTopAppBar({super.key});

  @override
  State<SearchTopAppBar> createState() => _SearchTopAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _SearchTopAppBarState extends State<SearchTopAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      scrolledUnderElevation: 0,
      title: Row(
        children: [
          Image.asset(
            'lib/assets/images/youtube_logo.png',
            fit: BoxFit.contain,
            height: 25,
          ),
          const Padding(padding: EdgeInsets.only(right: 10)),
          const Text("LionFlix"),
        ],
      ),
    );
  }
}
