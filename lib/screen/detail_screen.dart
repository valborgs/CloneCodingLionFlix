import 'dart:ui';

import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {

  // 영화 데이터
  Map<String, dynamic> movieData = <String, dynamic>{};
  // 포스터
  Image posterData= Image.asset('lib/assets/images/youtube_logo.gif');

  DetailScreen(this.movieData, this.posterData, {super.key});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Stack(
            children: [
              Container(
                // 배경 이미지를 깔아준다.
                width: double.maxFinite,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: widget.posterData.image,
                    fit: BoxFit.cover,
                  ),
                ),
                child: BackdropFilter(
                  // 블러(흐림)처리 필터를 설정해준다.
                  // sigmaX : 가로 방향 블러 값
                  // sigmaY : 세로 방향 블러 값
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    // 가운데에 배치한다.
                    alignment: Alignment.center,
                    // 배경을 좀 더 어둡게 해주기 위해 배경색을 검정색으로, 투명도를 10% 정도로 설정한다.
                    color: Colors.black.withOpacity(0.1),
                    child: Column(
                      children: [
                        // 포스터 이미지
                        Container(
                          padding: const EdgeInsets.fromLTRB(0, 45, 0, 10),
                          height: 300,
                          child: widget.posterData,
                        ),
                        // 설명
                        Container(
                          padding: const EdgeInsets.all(7),
                          child: Text(
                            widget.movieData['movie_info'],
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 13),
                          ),
                        ),
                        // 영화 제목
                        Container(
                          padding: const EdgeInsets.all(7),
                          child: Text(
                            widget.movieData['movie_title'],
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                        // 재생 버튼
                        Container(
                          padding: const EdgeInsets.all(10),
                          child: TextButton(
                            onPressed: () {

                            },
                            style: const ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll(Colors.red),
                              shape: MaterialStatePropertyAll(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(5.0))
                                )
                              )
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.play_arrow,
                                  color: Colors.white,
                                ),
                                Padding(padding: EdgeInsets.all(3)),
                                Text(
                                  "재생",
                                  style: TextStyle(color: Colors.white)
                                ),
                              ],
                            ),
                          ),
                        ),
                        // 영화 설명
                        Container(
                          padding: const EdgeInsets.all(5),
                          child: Text(widget.movieData['movie_detail_info']),
                        ),
                        // 출연진
                        Container(
                          padding: const EdgeInsets.all(5),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            '출연 : ${widget.movieData['movie_actor']}',
                            style: const TextStyle(
                              color: Colors.white60,
                              fontSize: 12
                            ),
                          ),
                        ),
                        // 제작진
                        Container(
                          padding: const EdgeInsets.all(5),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            '제작진 : ${widget.movieData['movie_director']}',
                            style: const TextStyle(
                              color: Colors.white60,
                              fontSize: 12
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // 좌측 상단(기본값)에 닫기 버튼을 배치한다.
              Positioned(
                  child: AppBar(
                    // 배경색을 투명색으로 지정한다.
                    backgroundColor: Colors.transparent,
                  )
              ),
            ],
          ),
          // 버튼들
          Container(
            color: Colors.black26,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // 찜 버튼
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  width: 120,
                  child: const Column(
                    children: [
                      Icon(Icons.add),
                      Padding(padding: EdgeInsets.all(5)),
                      Text(
                        textAlign: TextAlign.center,
                        "내가 찜한 콘텐츠",
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.white60,
                        ),
                      )
                    ],
                  ),
                ),
                // 평가
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  width: 120,
                  child: const Column(
                    children: [
                      Icon(Icons.thumb_up),
                      Padding(padding: EdgeInsets.all(5)),
                      Text(
                        '평가',
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.white60,
                        ),
                      )
                    ],
                  ),
                ),
                // 공유
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  width: 120,
                  child: const Column(
                    children: [
                      Icon(Icons.send),
                      Padding(padding: EdgeInsets.all(5)),
                      Text(
                        '공유',
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.white60,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
