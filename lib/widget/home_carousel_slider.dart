import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter03_lionflix/dao/movie_dao.dart';
import 'package:flutter03_lionflix/screen/detail_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeCarouselSlider extends StatefulWidget {

  // 영화 데이터를 담을 상태 변수
  List<Map<String, dynamic>> movieData;
  // 영화 포스터를 담을 상태 변수
  List<Image> posterData;
  // 찜한 영화 번호를 담을 상태 변수
  List<int> likeMovie;

  HomeCarouselSlider(this.movieData, this.posterData, this.likeMovie, {super.key});

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
    return Column(
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
              autoPlayInterval: const Duration(seconds: 5),
              // 이미지가 변경될 때 동작하는 리스너
              onPageChanged: (index, reason) {
                // 현재 보여지는 이미지의 순서 값을 설정해준다.
                setState(() {
                  imagePosition = index;
                });
              },
            )
        ),
        const Padding(padding: EdgeInsets.only(top: 10)),
        // 영화 제목
        Text(
          movieTitles[imagePosition],
          style: const TextStyle(fontSize: 20),
        ),
        // 버튼들
        Row(
          // 배치되는 뷰들의 간격을 설정해준다.
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // 찜
            Column(
              children: [
                // 현재 보여지는 영화의 번호가 찜한 영화 리스트에 있는지
                widget.likeMovie.contains(widget.movieData[imagePosition]['movie_idx'])
                    ? IconButton(
                      onPressed: () {
                        setState(() {
                          // 현재의 영화 번호를 likeMovie에서 제거한다.
                          widget.likeMovie.remove(widget.movieData[imagePosition]['movie_idx']);
                          // 저장한다.
                          setLikeMovie(widget.likeMovie);
                        });
                      },
                      icon: const Icon(Icons.check),
                    )
                    : IconButton(
                      onPressed: () {
                        setState(() {
                          // 현재의 영화 번호를 likeMovie에 저장한다.
                          widget.likeMovie.add(widget.movieData[imagePosition]['movie_idx']);
                          // 저장한다.
                          setLikeMovie(widget.likeMovie);
                        });
                      },
                      icon: const Icon(Icons.add)
                    ),
                const Text("내가 찜한 콘텐츠", style: TextStyle(fontSize: 11)),
              ],
            ),
            const Padding(padding: EdgeInsets.only(right: 10)),
            // 재생 버튼
            TextButton(
              onPressed: () {},
              // 버튼의 모양
              style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.white),
                shape: MaterialStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    ),
                ),
              ),
              child: const Row(
                  children: [
                    Icon(
                      Icons.play_arrow,
                      color: Colors.black,
                    ),
                    Padding(padding: EdgeInsets.all(3)),
                    Text("재생", style: TextStyle(color: Colors.black)),
                  ],
                ),
            ),
            const Padding(padding: EdgeInsets.only(right: 10)),
            // 정보
            Column(
              children: [
                IconButton(
                    onPressed: () {
                      // DetailScreen을 띄워준다.
                      Navigator.of(context).push(
                          MaterialPageRoute(
                            // 보여질 다음 화면을 설정한다.
                            builder: (context) => DetailScreen(widget.movieData[imagePosition], widget.posterData[imagePosition]),
                            // 다이얼로그로 보여지게 한다.
                            fullscreenDialog: true
                          )
                      );
                    },
                    icon: const Icon(Icons.info)
                ),
                const Text("정보", style: TextStyle(fontSize: 11))
              ],
            ),
          ],
        ),
        const Padding(padding: EdgeInsets.only(top: 10)),
        // 인디케이터
        AnimatedSmoothIndicator(
          activeIndex: imagePosition,
          count: images.length,
          effect: const WormEffect(
            dotWidth: 5,
            dotHeight: 5,
          ),
        ),
      ],
    );
  }
}
