import 'package:flutter/material.dart';
import 'package:flutter03_lionflix/dao/movie_dao.dart';
import 'package:flutter03_lionflix/widget/like_list_view.dart';
import 'package:flutter03_lionflix/widget/like_top_app_bar.dart';

class LikeScreen extends StatefulWidget {
  const LikeScreen({super.key});

  @override
  State<LikeScreen> createState() => _LikeScreenState();
}

class _LikeScreenState extends State<LikeScreen> {

  // 영화 데이터를 담을 상태 변수
  List<Map<String, dynamic>> movieData = [];
  // 영화 포스터를 담을 상태 변수
  List<Image> posterData = [];
  // 찜한 영화 번호를 담을 상태 변수
  List<int> likeMovie = [];

  // 데이터를 가져오는 함수
  Future<void> getData() async {
    // 찜한 영화 번호 정보를 받아온다.
    likeMovie = await getLikeMovieList();

    // 영화 데이터를 가져온다.
    var tempMovieData = await getMovieDataByMovieIndexes(likeMovie);

    // 영화의 수 만큼 이미지 객체를 만들어준다.
    posterData = List<Image>.generate(
      // 리스트가 담을 객체의 개수
      tempMovieData.length,
      // 리스트가 담을 객체를 생성해 반환해준다.
          (index) => Image.asset('lib/assets/images/loading.gif'),
    );

    // 영화 데이터를 통해 상태를 설정한다.
    setState(() {
      movieData = tempMovieData;
    });

    // 포스터 데이터를 받아오며 상태를 설정해준다.
    for(int i=0; i<tempMovieData.length; i++){
      // i번째 영화 포스터 객체를 가져온다.
      var tempImage = await getImageData(tempMovieData[i]['movie_poster']);
      // 받아온 이미지 객체를 포스터를 담을 리스트에 담아주고 상태를 설정한다.
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
      appBar: LikeTopAppBar(),
      body: Container(
        padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
        child: LikeListView(movieData, posterData, likeMovie),
      ),
    );
  }
}
