import 'dart:ui';

import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key});

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
                    image: AssetImage('lib/assets/images/movie3.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Container(
                  // 기존에 그려진 영역을 필터를 적용해 다시 그리고
                  // child를 보여주는 컨테이너
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
                      child: Container(
                        child: Column(
                          children: [
                            // 포스터 이미지
                            Container(
                              padding: EdgeInsets.fromLTRB(0, 45, 0, 10),
                              child: Image.asset('lib/assets/images/movie3.jpg'),
                              height: 300,
                            ),
                            // 설명
                            Container(
                              padding: EdgeInsets.all(7),
                              child: Text(
                                "2019년 15+ 시즌 1개",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 13),
                              ),
                            ),
                            // 영화 제목
                            Container(
                              padding: EdgeInsets.all(7),
                              child: Text(
                                '영화 제목',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                            // 재생 버튼
                            Container(
                              padding: EdgeInsets.all(10),
                              child: TextButton(
                                onPressed: () {

                                },
                                child: Row(
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
                                style: ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll(Colors.red),
                                  shape: MaterialStatePropertyAll(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(5.0))
                                    )
                                  )
                                ),
                              ),
                            ),
                            // 영화 설명
                            Container(
                              padding: EdgeInsets.all(5),
                              child: Text("동해물과 백두산이 마르고 닳도록 하느님이 보우하사 우리나라 만세"),
                            ),
                            // 출연진
                            Container(
                              padding: EdgeInsets.all(5),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                '출연 : 배우1, 배우2, 배우3, 배우4',
                                style: TextStyle(
                                  color: Colors.white60,
                                  fontSize: 12
                                ),
                              ),
                            ),
                            // 제작진
                            Container(
                              padding: EdgeInsets.all(5),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                '제작진 : 제작1, 제작2',
                                style: TextStyle(
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
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: Container(
                    child: Column(
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
                  width: 120,
                ),
                // 평가
                Container(
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: Container(
                    child: Column(
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
                  width: 120,
                ),
                // 공유
                Container(
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: Container(
                    child: Column(
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
                  width: 120,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
