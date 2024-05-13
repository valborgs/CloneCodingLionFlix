import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/tab_page_index_provider.dart';

class SearchSearchBar extends StatefulWidget {
  const SearchSearchBar({super.key});

  @override
  State<SearchSearchBar> createState() => _SearchSearchBarState();
}

class _SearchSearchBarState extends State<SearchSearchBar> {

  @override
  Widget build(BuildContext context) {

    // Provider를 가져온다.
    var searchScreenProvider = Provider.of<TabPageIndexProvider>(context, listen: false);

    return SearchBar(
      // 좌측에 배치되는 아이콘
      leading: Icon(Icons.search),
      // 내부 여백
      padding: MaterialStatePropertyAll(EdgeInsets.fromLTRB(10, 0, 10, 0)),
      // 키보드의 submit 버튼을 눌렀을 때
      // value : 사용자가 입력한 내용이 들어온다.
      onSubmitted: (value) {
        // Provider의 set 메서드를 호출해준다.
        searchScreenProvider.setKeyword(value);
      },
    );
  }
}
