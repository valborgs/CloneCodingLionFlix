import 'package:flutter/material.dart';
import 'package:flutter03_lionflix/screen/my_page_screen.dart';

class MoreListView extends StatefulWidget {
  const MoreListView({super.key});

  @override
  State<MoreListView> createState() => _MoreListViewState();
}

class _MoreListViewState extends State<MoreListView> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        InkWell(
          onTap: () {
            Navigator.of(context).push(
              // 화면 전환시 기본 애니메이션이 적용된다.
              // 크로미움 기반 웹브라우저, 안드로이드 : pop animation
              // iOS, ipadOS : slide animation

              // 기본 애니메이션 대신 커스텀을 사용할 예정.
              // MaterialPageRoute(
              //   builder: (context) => MyPageScreen(),
              // )

              // 플러터에서 제공하는 애니메이션 클래스 사용
              // https://docs.flutter.dev/ui/widgets/animation
              PageRouteBuilder(
                // 보여줄 화면 객체를 지정한다.
                pageBuilder: (context, animation, secondaryAnimation) => const MyPageScreen(),
                // 화면 전환 애니메이션 구성
                // animation : 기본 애니메이션 정보가 설정되어있는 객체
                // child : 새롭게 나타나는 화면 객체, pageBuilder에서 반환한 화면 객체
                transitionsBuilder: (context, animation, secondaryAnimation, child) {
                  // 새로 나타나는 화면 초기 위치(가로축 길이 비율, 세로축 길이 비율)
                  var begin = const Offset(1.0, 0.0);
                  // 새로 나타나는 화면의 마지막 위치
                  // var end = Offset(0.0, 0.0);
                  var end = Offset.zero;
                  // 위치 관리 객체
                  var tween = Tween(begin: begin, end: end);
                  // Curves
                  // https://api.flutter.dev/flutter/animation/Curves-class.html
                  var curve = Curves.ease;
                  var curvedAnimation = CurvedAnimation(parent: animation, curve: curve);
                  // 애니메이션 객체를 반환한다.
                  return SlideTransition(
                    position: tween.animate(curvedAnimation),
                    child: child,
                  );
                },
              )
            );
          },
          child: const Text('마이 페이지', style: TextStyle(fontSize: 20)),
        ),
        const Divider(),
        InkWell(
          onTap: () {},
          child: const Text('메뉴1', style: TextStyle(fontSize: 20)),
        ),
        const Divider(),
        InkWell(
          onTap: () {},
          child: const Text('메뉴2', style: TextStyle(fontSize: 20)),
        ),
        Divider(),
        InkWell(
          onTap: () {},
          child: const Text('메뉴3', style: TextStyle(fontSize: 20)),
        ),
      ],
    );
  }
}
