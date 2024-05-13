import 'package:flutter/material.dart';
import 'package:flutter03_lionflix/widget/search_list_view.dart';
import 'package:flutter03_lionflix/widget/search_search_bar.dart';
import 'package:flutter03_lionflix/widget/search_top_app_bar.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: const SearchTopAppBar(),
      body: Container(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
        child: const Column(
          children: [
            // 검색바
            SearchSearchBar(),
            Padding(padding: EdgeInsets.only(top: 10)),
            // 검색 결과가 나올 ListView
            // Column이나 Row 등 사이즈를 정하지 못하는 컨테이너에
            // 리스트뷰를 배치할 때는 Expanded 컨테이너를 사용해야 한다.
            // Expanded는 컨테이너의 크기가 나중에(항목이 구성된 후)에 다시 조정되는 컨테이너이다.
            Expanded(child: SearchListView()),
          ],
        ),
      ),
    );
  }
}
