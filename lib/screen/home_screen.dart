import 'package:flutter/material.dart';
import 'package:flutter03_lionflix/dao/movie_dao.dart';
import 'package:flutter03_lionflix/widget/home_box_slider.dart';
import 'package:flutter03_lionflix/widget/home_carousel_slider.dart';
import 'package:flutter03_lionflix/widget/home_top_app_bar.dart';

import '../widget/home_circle_slider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  // 영화 데이터를 담을 상태 변수
  List<Map<String, dynamic>> movieData = [];
  // 영화 포스터를 담을 상태 변수
  List<Image> posterData = [];
  // 지금 뜨는 콘텐츠 정보를 담을 리스트
  List<int> hotMovie = [];
  // 찜한 영화 번호를 담을 리스트
  List<int> likeMovie = [];

  // 화면이 보여질 때마다 호출되는 함수
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // 데이터를 가져오는 메서드를 호출해준다.
    getData();
  }

  // 영화 데이터를 가져오는 메서드
  // getMovieData를 initState에서 직접 호출하려면 async가 붙기 때문에
  // initState를 async로 바꾸면 오류가 난다.
  // 따라서 별도의 async 함수를 만들어 감싼 후 해당 함수를
  // initState에서 호출하는 방식으로 사용한다.
  Future<void> getData() async {
    // 영화 데이터를 가져온다.
    var tempMovieData = await getMovieData();
    // print('home screen - $tempMovieData');

    // getImageData(tempMovieData.first['movie_poster']);

    // 영화의 수 만큼 이미지 객체를 만들어준다.
    posterData = List<Image>.generate(
      // 리스트가 담을 객체의 개수
      tempMovieData.length,
      // 리스트가 담을 객체를 생성해 반환해준다.
          (index) => Image.asset('lib/assets/images/loading.gif'),
    );

    // 지금 뜨는 콘텐츠 정보를 받아온다.
    hotMovie = await getHotMovieList();

    // 찜한 영화 번호 정보를 받아온다.
    likeMovie = await getLikeMovieList();

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

  // build는 보여지고 있는 화면을 구성할 때 호출된다.
  // 처음 보여질때, 상태가 설정되었을 때, 사용자에 의해 이벤트가 발생했을 때 등 수시로 호출된다.
  // 따라서 build에서 데이터를 받아오는 함수를 호출해주면 수시로 호출되어버린다.
  @override
  Widget build(BuildContext context) {

    if(movieData.isEmpty){
      return Scaffold(
        appBar: HomeTopAppBar(),
      );
    }else{
      return Scaffold(
        appBar: HomeTopAppBar(),
        body: ListView(
          children: [
            // 상단 회전 목마
            HomeCarouselSlider(movieData, posterData, likeMovie),
            Padding(padding: EdgeInsets.only(top: 20)),
            // 미리 보기 부분
            HomeCircleSlider(movieData, posterData),
            Padding(padding: EdgeInsets.only(top: 20)),
            // 지금 뜨는 콘텐츠 부분
            HomeBoxSlider(movieData, posterData, hotMovie),
          ],
        ),
      );
    }
  }
}
