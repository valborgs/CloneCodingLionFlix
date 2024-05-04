
import 'package:flutter/material.dart';

class TabPageIndexProvider extends ChangeNotifier{

  // 눈에 보여질 화면의 순서값
  // 하단 내비게이션바의 선택한 메뉴 번호
  int _currentPageIndex = 0;

  int get currentPageIndex => _currentPageIndex;

  void setCurrentPageIndex(int index){
    _currentPageIndex = index;
    notifyListeners();
  }
}