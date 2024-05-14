import 'package:flutter/material.dart';
import 'package:flutter03_lionflix/dao/movie_dao.dart';

import '../screen/detail_screen.dart';

class HomeCircleSlider extends StatefulWidget {

  // 영화 데이터를 담을 상태 변수
  List<Map<String, dynamic>> movieData = [];
  // 영화 포스터를 담을 상태 변수
  List<Image> posterData = [];

  HomeCircleSlider(this.movieData, this.posterData, {super.key});

  @override
  State<HomeCircleSlider> createState() => _HomeCircleSliderState();
}

class _HomeCircleSliderState extends State<HomeCircleSlider> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("미리보기"),
          SizedBox(
            // 리스트 뷰의 크기를 컨테이너를 통해 설정한다.
            height: 120,
            // 다수의 항목을 보여주는 리스트 뷰는 builder를 통해 구성한다.
            child: ListView.builder(
              // 스크롤 방향은 가로 방향으로 설정한다.
              scrollDirection: Axis.horizontal,
              // 전체 항목의 개수
              itemCount: 10,
              // 항목 하나를 구성하기 위해 호출하는 함수
              // 여기서 반환하는 위젯이 항목 하나가 된다.
              itemBuilder: (context, index) {
                return makeListItem(
                    context,
                    widget.movieData,
                    widget.posterData,
                    index
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ListView의 항목 하나를 구성하여 반환하는 함수
Widget makeListItem(
    BuildContext context,
    List<Map<String, dynamic>> movieData,
    List<Image> posterData,
    int index
    ){
  // InkWell : 사용자 이벤트를 처리할 수 있는 컨테이너
  // 화면 요소에 사용자 이벤트에 관련된 리스너가 없을 경우 사용한다.
  return InkWell(
    // 눌렀을 때의 리스너
    onTap: () {
      // DetailScreen을 띄운다.
      Navigator.of(context).push(
          MaterialPageRoute(
              builder: (context) => DetailScreen(movieData[index], posterData[index]),
              fullscreenDialog: true
          )
      );
    },
    child: Container(
      padding: const EdgeInsets.only(right: 10),
      // 동그라미 형태로 보여주는 컨테이너
      child: CircleAvatar(
        // 배경 이미지
        backgroundImage: posterData[index].image,
        // 크기
        radius: 48,
      ),
    ),
  );
}