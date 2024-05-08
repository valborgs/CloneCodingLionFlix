import 'package:flutter/material.dart';
import 'package:flutter03_lionflix/widget/my_page_top_app_bar.dart';

class MyPageScreen extends StatefulWidget {
  const MyPageScreen({super.key});

  @override
  State<MyPageScreen> createState() => _MyPageScreenState();
}

class _MyPageScreenState extends State<MyPageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyPageTopAppBar(),
      body: Container(
        padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
        child: ListView(
          children: [
            // 상단 프로필 이미지
            Container(
              height: 100,
              child: Center(
                child: Image.asset('lib/assets/images/youtube_logo.png'),
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 10)),
            // 카메라, 앨범 버튼
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.camera_alt),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.photo_album),
                ),
              ],
            ),
            Padding(padding: EdgeInsets.only(top: 10)),
            // 이름 입력
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: '이름'
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 10)),
            // 닉네임 입력
            TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: '닉네임'
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 10)),
            // 버튼
            TextButton(
              onPressed: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.save_alt,
                    color: Colors.white,
                  ),
                  Padding(padding: EdgeInsets.all(3)),
                  Text('저장', style: TextStyle(color: Colors.white)),
                ]
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
          ],
        ),
      ),
    );
  }
}
