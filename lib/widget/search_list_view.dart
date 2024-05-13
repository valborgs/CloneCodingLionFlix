import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../dao/movie_dao.dart';
import '../provider/tab_page_index_provider.dart';
import '../screen/detail_screen.dart';

class SearchListView extends StatefulWidget {
  const SearchListView({super.key});

  @override
  State<SearchListView> createState() => _SearchListViewState();
}

class _SearchListViewState extends State<SearchListView> {

  // 검색 결과 데이터를 담을 리스트
  List<Map<String, dynamic>> searchResult = [];
  // 검색 결과 영화 포스터를 담을 리스트
  List<Image> posterData = [];

  @override
  Widget build(BuildContext context) {

    // Provider를 가져온다.
    var searchScreenProvider = Provider.of<TabPageIndexProvider>(context, listen: false);

    // 리스너를 연결해준다.
    searchScreenProvider.addListener(() async {
      // print("SearchListView : ${searchScreenProvider.searchKeyword}");
      // 검색 결과를 가져온다.
      List<Map<String, dynamic>> tempSearchResult = await getSearchResult(searchScreenProvider.searchKeyword);
      // 검색 결과 포스터를 가져온다.
      posterData = await getSearchPoster(tempSearchResult);
      // 상태를 설정해준다.
      setState(() {
        searchResult = tempSearchResult;
      });
    });

    return ListView.builder(
      itemCount: searchResult.length,
      itemBuilder: (context, index) => makeListItem(context, searchResult, posterData, index),
      // itemBuilder: (context, index) => makeListItem2(),
    );
  }
}

// 리스트뷰의 항목 하나를 구성하는 함수
// 리스트뷰의 항목은 ListTitle을 사용해도 된다 대신 아이콘 사이즈 조절 불가
Widget makeListItem(BuildContext context, List<Map<String, dynamic>> searchResult, List<Image> posterData, int index){
  return Container(
    padding: const EdgeInsets.only(top: 10),
    child: InkWell(
      onTap: () {
        Navigator.of(context).push(
            MaterialPageRoute(
                builder: (context) => DetailScreen(),
                fullscreenDialog: true
            )
        );
      },
      child: Row(
        children: [
          posterData[index],
          const Padding(padding: EdgeInsets.only(right: 10)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  searchResult[index]['movie_title'],
                  style: TextStyle(fontSize: 15),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  '출연진 : ${searchResult[index]['movie_actor']}',
                  style: TextStyle(fontSize: 12),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  '제작진 : ${searchResult[index]['movie_director']}',
                  style: TextStyle(fontSize: 12),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

// ListTitle 사용 예
//
Widget makeListItem2(){
  return ListTile(
    leading: Image.asset('lib/assets/images/movie6.jpg'),
    title: Text('영화 제목'),
    subtitle: Text('출연진 : 배우1, 배우2, 배우3\n제작진 : 제작1, 제작2, 제작3',),
    isThreeLine: true,
    onTap: () {},
  );
}

// 전체 영화 데이터에서 검색어에 해당하는 것만 모아 반환한다.
Future<List<Map<String, dynamic>>> getSearchResult(String keyword) async {
  // 검색 결과를 담을 리스트
  List<Map<String, dynamic>> tempSearchResult = [];
  // 모든 영화 정보를 가져온다.
  List<Map<String, dynamic>> movieData = await getMovieData();

  // 가져온 전체 영화의 수 만큼 반복한다.
  for(var map in movieData){
    // 현재 영화의 제목이 검색어를 포함하고 있다면 결과 리스트에 담아준다.
    if(map['movie_title'].toString().contains(keyword)){
      // 결과 리스트에 담아준다.
      tempSearchResult.add(map);
    }
  }

  return tempSearchResult;
}

// 검색된 영화의 포스터를 만들어 반환한다.
Future<List<Image>> getSearchPoster(List<Map<String, dynamic>> searchResult) async {

  // 포스터를 담을 리스트
  List<Image> searchPoster = [];

  // 검색된 영화의 수 만큼 반복한다.
  for(var map in searchResult){
    // 이미지를 생성한다.
    var tempImage = await getImageData(map['movie_poster']);
    // 가로가 100사이즈의 이미지로 다시 생성해준다.
    var tempImage2 = Image(image: tempImage.image, width: 100);
    // 리스트에 담는다.
    searchPoster.add(tempImage2);
  }

  return searchPoster;
}