import 'package:flutter/material.dart';

class DramaTopAppBar extends StatefulWidget implements PreferredSizeWidget {
  const DramaTopAppBar({super.key});

  @override
  State<DramaTopAppBar> createState() => _DramaTopAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _DramaTopAppBarState extends State<DramaTopAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        children: [
          Image.asset(
            'lib/assets/images/youtube_logo.png',
            fit: BoxFit.contain,
            height: 25,
          ),
          const Padding(padding: EdgeInsets.only(right: 10)),
          const Text('LionFlix'),
        ],
      ),
    );
  }
}
