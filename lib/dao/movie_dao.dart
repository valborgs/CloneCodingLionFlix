
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

// 타입에 따라 영상 정보를 가져오는 함수
Future<List<Map<String, dynamic>>> getMovieDataByType(int movieType) async {
  // movie_data 컬렉션에 저장되어 있는 조건에 맞는 문서를 가져온다.
  // flutter에서 firebase 사용시 조건에 관련된 것은 모두 where 함수를 사용한다.
  // where 함수의 매개변수를 통해서 어떠한 조건인지를 설정한다.
  // 첫 번째 매개변수 : 필드 이름
  // isEqualTo : 값을 지정한다. 필드의 값이 지정된 값과 같은 것
  // isNotEqualTo : 값을 지정한다. 필드의 값이 지정된 값과 다른 것
  // isLessThan : 값을 지정한다. 필드의 값이 지정된 값보다 작은 것
  // isLessThanOrEqualTo : 값을 지정한다. 필드의 값이 지정된 값보다 작거나 같은 것
  // isGreaterThan : 값을 지정한다. 필드의 값이 지정된 값보다 큰 것
  // isGraterThanOrEqualTo : 값을 지정한다. 필드의 값이 지정된 값보다 크거나 같은 것
  // arrayContains : 값을 지정한다. 지정된 필드가 배열 값을 저장하고 있어야 하고 저장된 배열 내의 값이 지정된 값이 포함되어 있는 것
  // arrayContainsAny : 배열이나 리스트를 지정한다. 필드에 저장되어 있는 값은 배열이어야 한다. 필드에 저장되어 있는 값이 지정된 배열이나 리스트 안에 포함되어 있는 것
  // 예) 필드 a1의 값이 1이거나 2인 문서들을 모두 가져온다.
  // whereIn : 배열이나 리스트를 지정한다. 필드의 저장된 것이 리스트가 아닌 값. 필드의 저장된 것이 값이 지정된 배열이나 리스트 안에 포함되어 있는 것
  // whereNotIn : 배열이나 리스트를 지정한다. 필드의 저장된 것이 리스트가 아닌 값. 필드의 저장된 것이 값이 지정된 배열이나 리스트 안에 포함되어 있지 않는 것
  // isNull : true나 false를 지정한다. true를 지정할 경우 지정된 필드의 값이 null인 문서들을 가져오고
  //          false인 경우에는 지정된 필드의 값이 null이 아닌 문서들을 가져온다.
  var querySnapShot = await FirebaseFirestore.instance.collection('movie_data').where('movie_type', isEqualTo: movieType ).get();

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

// 찜한 영화 정보를 가져오는 함수
Future<List<int>> getLikeMovieList() async {
  // 찜한 영화의 번호 정보를 가져온다.
  var querySnapShot = await FirebaseFirestore.instance.collection('movie_like').doc('like_doc').get();
  // 데이터를 담을 리스트
  List<int> results = [];

  var map = querySnapShot.data();

  // 컬렉션과 문서가 있을 경우
  if(map != null){
    // likes 필드의 저장되어 있는 배열을 가져와 담아준다.
    for(var idx in map['likes']){
      results.add(idx);
    }
  }

  return results;
}

// 찜한 영화 정보를 새롭게 저장하는 함수
Future<void> setLikeMovie(List<int> likeMovie) async {
  await FirebaseFirestore.instance.collection('movie_like').doc('like_doc').set({
    'likes' : likeMovie,
  });
}

// 전달되는 영화 번호에 해당하는 영화 데이터를 반환한다.
// 영화 데이터 전체를 가져오는 함수
Future<List<Map<String, dynamic>>> getMovieDataByMovieIndexes(List<int> movieIndexes) async {


  // 데이터를 담을 리스트
  List<Map<String, dynamic>> results = [];

  if(movieIndexes.isNotEmpty){
    // movie_data 컬렉션에 저장되어 있는 모든 문서를 가져온다.
    var querySnapShot = await FirebaseFirestore.instance.collection('movie_data').where('movie_idx', whereIn: movieIndexes).get();

    // 데이터를 리스트에 담아준다.
    // 컬렉션에 담긴 모든 문서를 가져와 반복한다.
    for(var doc in querySnapShot.docs){
      // 문서에 담긴 데이터를 맵으로 추출하여 리스트에 담는다.
      results.add(doc.data());
    }
  }

  return results;
}