import 'package:flutter/material.dart';
import 'package:flutter03_lionflix/screen/detail_screen.dart';
import 'package:flutter03_lionflix/widget/movie_top_app_bar.dart';

import '../dao/movie_dao.dart';

class MovieScreen extends StatefulWidget {
  const MovieScreen({super.key});

  @override
  State<MovieScreen> createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  // 영화 데이터를 담을 변수
  List<Map<String, dynamic>> movieData = [];
  // 영화 포스터를 담을 상태 변수
  List<Image> posterData = [];

  // 영화 데이터를 가져오는 메서드
  Future<void> getData() async {
    // 영화 데이터를 가져온다.
    var tempMovieData = await getMovieDataByType(2);

    // 영화의 수 만큼 이미지 객체를 만들어준다.
    posterData = List<Image>.generate(
        tempMovieData.length,
            (index) => Image.asset('lib/assets/images/loading.gif')
    );

    // 영화 데이터를 통해 상태를 설정한다.
    setState(() {
      movieData = tempMovieData;
    });

    // 포스터 데이터를 받아오며 상태를 설정한다.
    for(int i=0; i<tempMovieData.length; i++){
      // i번째 영화 포스터 객체를 가져온다.
      var tempImage = await getImageData(tempMovieData[i]['movie_poster']);
      setState(() {
        posterData[i] = tempImage;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MovieTopAppBar(),
      body: GridView.builder(
        // 보여줄 항목의 개수
        itemCount: movieData.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          // 컬럼의 개수
          crossAxisCount: 4,
          // 수평 방향 여백
          mainAxisSpacing: 10,
          // 수직 방향 여백
          crossAxisSpacing: 10,
          // 항목의 가로 세로 비율
          childAspectRatio: 0.7,
        ),
        itemBuilder: (context, index) => makeGridItem(context, movieData, posterData, index),
      ),
    );
  }
}

// 그리드 뷰의 항목 하나를 구성하는 함수
Widget makeGridItem(BuildContext context, List<Map<String, dynamic>> movieData, List<Image> posterData, int index){
  return InkWell(
    onTap: () {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => DetailScreen(movieData[index], posterData[index]),
          fullscreenDialog: true,
        )
      );
    },
    child: posterData[index],
  );
}