
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

// 지금 뜨는 콘텐츠 정보를 가져온다.
Future<List<int>> getHotMovieList() async {
  var querySnapshot = await FirebaseFirestore.instance.collection('hot').get();

  List<int> results = List<int>.from(querySnapshot.docs[0].data()['hot_movie_idx']);

  return results;
}