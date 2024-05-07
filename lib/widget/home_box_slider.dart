import 'package:flutter/material.dart';

import '../screen/detail_screen.dart';

class HomeBoxSlider extends StatefulWidget {
  const HomeBoxSlider({super.key});

  @override
  State<HomeBoxSlider> createState() => _HomeBoxSliderState();
}

class _HomeBoxSliderState extends State<HomeBoxSlider> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("지금 뜨는 콘텐츠"),
          Container(
            height: 120,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 10,
              itemBuilder: (context, index) {
                return makeListItem(context);
              },
            ),
          )
        ],
      ),
    );
  }
}

// 리스트뷰의 항목 하나를 구성하는 함수
Widget makeListItem(BuildContext context){
  return InkWell(
    // 눌렀을 때의 리스너
    onTap: () {
      // DetailScreen을 띄운다.
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => DetailScreen(),
          fullscreenDialog: true
        )
      );
    },
    child: Container(
      padding: EdgeInsets.only(right: 10),
      child: Image.asset('lib/assets/images/movie2.jpg'),
    ),
  );
}