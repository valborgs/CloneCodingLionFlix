import 'package:flutter/material.dart';

import '../screen/detail_screen.dart';

class HomeBoxSlider extends StatefulWidget {

  // 영화 데이터를 담을 상태 변수
  List<Map<String, dynamic>> movieData = [];
  // 영화 포스터를 담을 상태 변수
  List<Image> posterData = [];
  // 지금 뜨는 콘텐츠 정보를 담을 리스트
  List<int> hotMovie = [];

  HomeBoxSlider(this.movieData, this.posterData, this.hotMovie, {super.key});

  @override
  State<HomeBoxSlider> createState() => _HomeBoxSliderState();
}

class _HomeBoxSliderState extends State<HomeBoxSlider> {

  @override
  Widget build(BuildContext context) {

    // 지금 뜨는 컨텐츠 정보 객체만 담는다.
    List<Map<String, dynamic>> hotMovieData = [];
    // 지금 뜨는 컨텐츠의 영화 포스터를 담을 리스트
    List<Image> hotMoviePoster = [];

    // 영화의 수 만큼 반복한다.
    for(int i=0; i<widget.movieData.length; i++){
      // 현재 영화의 번호가 지금 뜨는 컨텐츠 번호에 있다면 리스트에 담아준다.
      if(widget.hotMovie.contains(widget.movieData[i]['movie_idx'])){
        hotMovieData.add(widget.movieData[i]);
        hotMoviePoster.add(widget.posterData[i]);
      }
    }

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
              itemCount: hotMovieData.length,
              itemBuilder: (context, index) {
                return makeListItem(
                    context,
                    hotMovieData,
                    hotMoviePoster,
                    index
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

// 리스트뷰의 항목 하나를 구성하는 함수
Widget makeListItem(
    BuildContext context,
    List<Map<String, dynamic>> hotMovieData,
    List<Image> hotMoviePoster,
    int index
    ){
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
      child: hotMoviePoster[index],
    ),
  );
}