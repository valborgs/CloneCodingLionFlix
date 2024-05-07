import 'package:flutter/material.dart';

import '../screen/detail_screen.dart';

class SearchListView extends StatefulWidget {
  const SearchListView({super.key});

  @override
  State<SearchListView> createState() => _SearchListViewState();
}

class _SearchListViewState extends State<SearchListView> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) => makeListItem(context),
      // itemBuilder: (context, index) => makeListItem2(),
    );
  }
}

// 리스트뷰의 항목 하나를 구성하는 함수
// 리스트뷰의 항목은 ListTitle을 사용해도 된다 대신 아이콘 사이즈 조절 불가
Widget makeListItem(BuildContext context){
  return Container(
    padding: EdgeInsets.only(top: 10),
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
          Image.asset(
            'lib/assets/images/movie4.jpg',
            width: 100,
          ),
          Padding(padding: EdgeInsets.only(right: 10)),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  '영화제목',
                  style: TextStyle(fontSize: 15)
              ),
              Text(
                  '출연진 : 배우1, 배우2, 배우3',
                  style: TextStyle(fontSize: 12)
              ),
              Text(
                  '제작진 : 제작1, 제작2, 제작3',
                  style: TextStyle(fontSize: 12)
              ),
            ],
          )
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
    subtitle: Text('출연진 : 배우1, 배우2, 배우3\n제작진 : 제작1, 제작2, 제작3'),
    isThreeLine: true,
    onTap: () {},
  );
}