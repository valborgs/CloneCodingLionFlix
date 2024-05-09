import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter03_lionflix/screen/detail_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeCarouselSlider extends StatefulWidget {

  // 영화 데이터를 담을 상태 변수
  List<Map<String, dynamic>> movieData;
  // 영화 포스터를 담을 상태 변수
  List<Image> posterData;

  HomeCarouselSlider(this.movieData, this.posterData, {super.key});

  @override
  State<HomeCarouselSlider> createState() => _HomeCarouselSliderState();
}

class _HomeCarouselSliderState extends State<HomeCarouselSlider> {

  // 회전 목마에서 보여주고 있는 이미지의 순서 값
  var imagePosition = 0;

  // 포스터 이미지들
  var images = [
    Image.asset('lib/assets/images/movie1.jpg'),
    Image.asset('lib/assets/images/movie2.jpg'),
    Image.asset('lib/assets/images/movie3.jpg'),
    Image.asset('lib/assets/images/movie4.jpg'),
    Image.asset('lib/assets/images/movie5.jpg'),
    Image.asset('lib/assets/images/movie6.jpg'),
    Image.asset('lib/assets/images/movie7.jpg'),
    Image.asset('lib/assets/images/movie8.jpg'),
    Image.asset('lib/assets/images/movie9.jpg'),
    Image.asset('lib/assets/images/movie10.jpg'),
  ];

  // 영화 제목들
  var movieTitles = [
    "영화1", "영화2", "영화3", "영화4", "영화5",
    "영화6", "영화7", "영화8", "영화9", "영화10",
  ];

  // 찜 여부
  var movieLike = [
    true, false, true, false, true, false, true, false, true, false
  ];

  @override
  Widget build(BuildContext context) {

    // 영화 제목을 담아준다.
    movieTitles.clear();
    for(var map in widget.movieData){
      movieTitles.add(map['movie_title']);
    }
    return Container(
      child: Column(
        children: [
          // 회전목마
          CarouselSlider(
              items: widget.posterData,
              options: CarouselOptions(
                // 회전목마가 이미지를 보여주는 영역안에서 얼만큼의 크기로 이미지를
                // 보여줄지에 대한 비율. 1.0이 최대
                viewportFraction: 1.0,
                // 자동 슬라이드 활성화 여부
                autoPlay: true,
                // 자동 슬라이드 간격
                autoPlayInterval: Duration(seconds: 5),
                // 이미지가 변경될 때 동작하는 리스너
                onPageChanged: (index, reason) {
                  // 현재 보여지는 이미지의 순서 값을 설정해준다.
                  setState(() {
                    imagePosition = index;
                  });
                },
              )
          ),
          Padding(padding: EdgeInsets.only(top: 10)),
          // 영화 제목
          Text(
            movieTitles[imagePosition],
            style: TextStyle(fontSize: 20),
          ),
          // 버튼들
          Row(
            // 배치되는 뷰들의 간격을 설정해준다.
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // 찜
              Column(
                children: [
                  movieLike[imagePosition]
                      ? IconButton(onPressed: () {}, icon: Icon(Icons.check))
                      : IconButton(onPressed: () {}, icon: Icon(Icons.add)),
                  Text("내가 찜한 콘텐츠", style: TextStyle(fontSize: 11)),

                ],
              ),
              Padding(padding: EdgeInsets.only(right: 10)),
              // 재생 버튼
              TextButton(
                onPressed: () {},
                child: Row(
                    children: [
                      Icon(
                        Icons.play_arrow,
                        color: Colors.black,
                      ),
                      Padding(padding: EdgeInsets.all(3)),
                      Text("재생", style: TextStyle(color: Colors.black)),
                    ],
                  ),
                // 버튼의 모양
                style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.white),
                  shape: MaterialStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      ),
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.only(right: 10)),
              // 정보
              Column(
                children: [
                  IconButton(
                      onPressed: () {
                        // DetailScreen을 띄워준다.
                        Navigator.of(context).push(
                            MaterialPageRoute(
                              // 보여질 다음 화면을 설정한다.
                              builder: (context) => DetailScreen(),
                              // 다이얼로그로 보여지게 한다.
                              fullscreenDialog: true
                            )
                        );
                      },
                      icon: Icon(Icons.info)
                  ),
                  Text("정보", style: TextStyle(fontSize: 11))
                ],
              ),
            ],
          ),
          Padding(padding: EdgeInsets.only(top: 10)),
          // 인디케이터
          AnimatedSmoothIndicator(
            activeIndex: imagePosition,
            count: images.length,
            effect: WormEffect(
              dotWidth: 5,
              dotHeight: 5,
            ),
          ),
        ],
      ),
    );
  }
}
