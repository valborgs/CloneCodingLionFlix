import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SearchSearchBar extends StatefulWidget {
  const SearchSearchBar({super.key});

  @override
  State<SearchSearchBar> createState() => _SearchSearchBarState();
}

class _SearchSearchBarState extends State<SearchSearchBar> {
  @override
  Widget build(BuildContext context) {
    return SearchBar(
      // 좌측에 배치되는 아이콘
      leading: Icon(Icons.search),
      // 내부 여백
      padding: MaterialStatePropertyAll(EdgeInsets.fromLTRB(10, 0, 10, 0)),
    );
  }
}
