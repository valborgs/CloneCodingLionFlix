
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

// 영화 데이터 전체를 가져오는 함수
Future<List<Map<String, dynamic>>> getMovieData() async {
  // movie_data 컬렉션에 저장되어 있는 모든 문서를 가져온다.
  var querySnapShot = await FirebaseFirestore.instance.collection('movie_data').get();

  // 데이터를 담을 리스트
  List<Map<String, dynamic>> results = [];

  // 데이터를 리스트에 담아준다.
  // 컬렉션에 담긴 모든 문서를 가져와 반복한다.
  for(var doc in querySnapShot.docs){
    // 문서에 담긴 데이터를 맵으로 추출하여 리스트에 담는다.
    results.add(doc.data());
  }

  return results;
}

// 이미지 데이터를 가져온다.
Future<Image> getImageData(String fileName) async {
  // 이미지를 가져올 수 있는 주소를 가져온다.
  String imageUrl = await FirebaseStorage.instance.ref('poster/$fileName').getDownloadURL();
  // print(imageUrl);

  // 이미지를 관리하는 객체
  Image resultImage = Image.network(imageUrl);

  return resultImage;
}

// 프로필 이미지 데이터를 가져온다.
Future<Image> getProfileImageData(String fileName) async {
  // 이미지를 가져올 수 있는 주소를 가져온다.
  String imageUrl = await FirebaseStorage.instance.ref('user_image/$fileName').getDownloadURL();
  // print(imageUrl);

  // 이미지를 관리하는 객체
  Image resultImage = Image.network(imageUrl);

  return resultImage;
}

// 지금 뜨는 콘텐츠 정보를 가져온다.
Future<List<int>> getHotMovieList() async {
  var querySnapshot = await FirebaseFirestore.instance.collection('hot').get();

  List<int> results = List<int>.from(querySnapshot.docs[0].data()['hot_movie_idx']);

  return results;
}

// Storage에 이미지를 저장하는 함수
// localImagePath: 단말기에 저장되어 있는 이미지의 경로
// serverImagePath: 서버상에서의 이미지의 경로
Future<void> uploadImage(String localImagePath, String serverImagePath) async {
  await FirebaseStorage.instance
      .ref().child("user_image").child(serverImagePath)
      .putFile(File(localImagePath));
}

// 사용자 정보를 서버에 저장한다.
// 여기에서는 사용자가 한 명임을 가정한다.
// add : 문서 추가
// set : 문서 내의 모든 필드를 삭제하고 다시 저장
// update : 문서 내의 필드 일부를 수정
Future<void> saveUserInfo(String name, String nickName, String profilePath) async {
  await FirebaseFirestore.instance.collection("user_data").doc("user_profile").set({
    'user_name' : name,
    'user_nickName' : nickName,
    'user_profilePath' : profilePath,
  });
}

// 서버에 저장되어 있는 사용자 정보를 읽어와 반환한다.
Future<Map<String, dynamic>?> getUserInfo() async {
  var querySnapShot = await FirebaseFirestore.instance.collection('user_data').doc('user_profile').get();
  Map<String, dynamic>? map = querySnapShot.data();

  return map;
}