import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter03_lionflix/dao/movie_dao.dart';
import 'package:flutter03_lionflix/widget/my_page_top_app_bar.dart';
import 'package:image_picker/image_picker.dart';

class MyPageScreen extends StatefulWidget {
  const MyPageScreen({super.key});

  @override
  State<MyPageScreen> createState() => _MyPageScreenState();
}

class _MyPageScreenState extends State<MyPageScreen> {

  // 사용자 프로필 이미지
  Image profileImage = Image.asset('lib/assets/images/youtube_logo.png');
  // 앨범이나 카메라에서 사진을 가져오기 위한 객체
  ImagePicker imagePicker = ImagePicker();
  // 앨범이나 카메라에서 사진을 가져오면 단말기 로컬 저장소에 저장이 된다.
  // 저장된 사진의 경로를 담을 변수
  String pickedImagePath = "";

  // 입력 요소들과 연결될 컨트롤러
  TextEditingController nameController = TextEditingController();
  TextEditingController nickNameController = TextEditingController();

  // 사용자 정보를 가져와 반환하는 함수
  void getUserData() async {
    // 사용자 정보를 가져온다.
    Map<String, dynamic>? map1 = await getUserInfo();

    if(map1 != null){
      profileImage = await getProfileImageData(map1["user_profilePath"]);

      setState(() {
        nameController.text = map1["user_name"];
        nickNameController.text = map1["user_nickName"];
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // 사용자 정보를 가져와 설정해준다.
    getUserData();
  }

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
                child: profileImage,
              ),
            ),
            const Padding(padding: EdgeInsets.only(top: 10)),
            // 카메라, 앨범 버튼
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.camera_alt),
                  onPressed: () {
                    getImage(ImageSource.camera);
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.photo_album),
                  onPressed: () {
                    getImage(ImageSource.gallery);
                  },
                ),
              ],
            ),
            const Padding(padding: EdgeInsets.only(top: 10)),
            // 이름 입력
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: '이름'
              ),
              controller: nameController,
            ),
            const Padding(padding: EdgeInsets.only(top: 10)),
            // 닉네임 입력
            TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: '닉네임'
              ),
              controller: nickNameController,
            ),
            const Padding(padding: EdgeInsets.only(top: 10)),
            // 저장 버튼
            TextButton(
              onPressed: () async {
                // 이미지를 업로드 한다.
                if(pickedImagePath.isNotEmpty){
                  await uploadImage(pickedImagePath, "user_profile.jpg");
                }
                // 사용자 정보를 저장한다.
                await saveUserInfo(nameController.text, nickNameController.text, "user_profile.jpg");

                FocusScope.of(context).unfocus();
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
                    Icons.save_alt,
                    color: Colors.white,
                  ),
                  Padding(padding: EdgeInsets.all(3)),
                  Text('저장', style: TextStyle(color: Colors.white)),
                ]
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 카메라나 앨범을 통해 사진을 가져와 설정한다.
  Future<void> getImage(ImageSource imageSource) async {
    // 사진을 가져온다.
    XFile? pickedImage = await imagePicker.pickImage(source: imageSource);
    if(pickedImage != null){
      // 가져온 사진을 보여준다
      setState(() {
        // 가져온 사진의 경로를 가져온다.
        var xfileImage = XFile(pickedImage.path);
        pickedImagePath = xfileImage.path;
        // 사진을 보여준다.
        profileImage = Image.file(File(pickedImagePath));
      });
    }
  }
}
