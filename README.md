# Flutter 종합 예제

---
## 2024-05-03

1. 코드 삭제
- lib/main.dart
- test/widget_test.dart

### MaterialApp 기본 구조 작성

1. StatefulWidget을 작성해준다.
```dart
import 'package:flutter/material.dart';

class LionFlixApp extends StatefulWidget {
  const LionFlixApp({super.key});

  @override
  State<LionFlixApp> createState() => _LionFlixAppState();
}

class _LionFlixAppState extends State<LionFlixApp> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

```
2. main 함수를 작성해준다.
```dart
void main(){
  runApp(LionFlixApp());
}
```

3. MaterialApp의 기본 테마를 설정해준다.
```dart
    return MaterialApp(
      title: 'LionFlix',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.blue,
            // 전체적인 어플의 테마를 어두운 테마로 설정한다.
            brightness: Brightness.dark
        ),
        useMaterial3: true,
      ),
      home: Center(child: Text('안녕하세요'),),
    );
```

### BottomNavigationBar를 배치한다.

1. home을 Scaffold 구조로 설정해준다.
```dart
      home: Scaffold(
        
      ),
```

2. widget 폴더를 만들어준다.
lib/widget

3. widget 폴더에 dart 파일을 생성해준다.
lib/widget/main_bottom_navigation_bar.dart

4. StatefulWidget으로 작성해준다.
```dart
import 'package:flutter/material.dart';

class MainBottomNavigationBar extends StatefulWidget {
  const MainBottomNavigationBar({super.key});

  @override
  State<MainBottomNavigationBar> createState() => _MainBottomNavigationBarState();
}

class _MainBottomNavigationBarState extends State<MainBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

```

5. 네비게이션 바를 작성해준다.
```dart
  Widget build(BuildContext context) {
  // 하단에 배치될 네비게이션 바
  return NavigationBar(
    // 네비게이션 바를 구성하는 아이콘들        
      destinations: [

      ]
  );
}
```

6. main.dart에 bottomNavigationBar를 설정해준다.
```dart
      home: Scaffold(
        bottomNavigationBar: MainBottomNavigationBar(),
      ),
```

7. destinations 안에 4개의 아이콘 메뉴를 배치한다.
```dart
    // 하단에 배치될 네비게이션 바
    return NavigationBar(
      // 네비게이션 바를 구성하는 아이콘들
      destinations: [
        NavigationDestination(
          // 평상시의 아이콘
          icon: Icon(Icons.home_outlined),
          // 눌러졌을 때의 아이콘
          selectedIcon: Icon(Icons.home),
          // 아이콘 하단에 표시될 문자열
          label: "Home"
        ),
        NavigationDestination(
            icon: Icon(Icons.search_outlined),
            selectedIcon: Icon(Icons.search),
            label: "Search"
        ),
        NavigationDestination(
            icon: Icon(Icons.save_alt_outlined),
            selectedIcon: Icon(Icons.save_alt),
            label: "saved"
        ),
        NavigationDestination(
            icon: Icon(Icons.list_outlined),
            selectedIcon: Icon(Icons.list),
            label: "more"
        ),
      ],
    );
```

8. 하단 아이콘 메뉴 중 선택되어 있는 아이콘 메뉴의 순서값을 담아준다
```dart
 class _MainBottomNavigationBarState extends State<MainBottomNavigationBar> {

  // 네비게이션 바에서 선택되어 있는 아이콘 메뉴의 순서값
  int tabPageIndex = 0;
```

9. 하단 아이콘 메뉴 중 어떤 것을 선택할 지 작성해준다.
```dart
      // 네비게이션 바에 배치된 아이콘 메뉴들 중 어떤 것을 선택할 것인가..
      selectedIndex: tabPageIndex,
```

10. 탭 메뉴를 눌렀을 때의 리스너를 구현해준다.
```dart
        // 하단 메뉴를 눌렀을 때
        // value: 사용자가 누른 메뉴 항목의 순서값
        onDestinationSelected: (value){
            setState(() {
              tabPageIndex = value;
            });
        },
```

11. 인디케이터 색상을 설정해준다.
```dart
      // indicator 색상
      indicatorColor: Colors.white12,
```

### 첫 화면을 구성한다.
- 네비게이션바 상단에 배치가 되며 본문 부분이 된다.
- 네비게이션바의 메뉴를 누르면 이 화면 안에서 화면들이 변경되게 한다.

1. 화면 파일들을 작성할 폴더를 생성한다.
lib/screen

2. screen 폴더에 첫 화면 파일을 생성한다.
lib/screen/main_screen.dart

3. StatefulWidget으로 작성해준다.
```dart
 import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
```

4. main.dart에 MainScreen을 설정해준다.
```dart
      home: Scaffold(
        bottomNavigationBar: MainBottomNavigationBar(),
        body: MainScreen(),
      ),
```

### provider 라이브러리 셋팅
- 사용자가 네비게이션 아이콘 메뉴를 누르면 화면이 변경되도록 할 것이다.
- 네비게이션 바는 main_bottom_navigation_bar.dart에 구현되어 있고 화면은 main_screen.dart에 구현되어 있다.
- 파일이 서로 다르기 때문에 상태 관리 객체도 각각 따로 존재하는 상황이다.
- 물론 모두 하나의 파일에서 작업을 하면 간단하지만 우리는 파일을 나눠서 작업하는 예를 실습한다.
- 상태 관리 객체는 다른 상태 관리 객체에 관여할 수 없다.
- 이럴 경우 글로벌 상태를 사용을 하면 쉽게 처리가 가능하다.
- provider 라이브러리를 사용하면 간단하게 처리가 가능하다.
1. https://pub.dev/ 사이트에 들어간다.
2. provider로 검색하여 라이브러리 페이지로 들어간다.
3. provider 라이브러리 설치 문자열을 복사한다(provider: ^6.1.2)
4. 프로젝트에 있는 pubspec.yaml 파일을 열어준다.
5. dependencies: 로 검색하여 위치를 찾아준다.
6. dependencies: 안에 라이브러리 설치 문자열을 입력해준다.
7. Pub get을 눌러준다.

8. provider 폴더를 만들어준다.
- lib/provider

9. provider 폴더 안에 tab_page_index_provider.dart 파일을 만들어준다.
- lib/provider/tab_page_index_provider.dart

10. TabPageIndexProvider를 사용하는 코드로 변경한다.

11. main_bottom_navigation_bar.dart 파일을 수정한다.
- tabPageIndex 변수 선언 부분을 제거한다.
```dart
class _MainBottomNavigationBarState extends State<MainBottomNavigationBar> {

  // 네비게이션 바에서 선택되어 있는 아이콘 메뉴의 순서값
  // int tabPageIndex = 0;
```

- Provider를 사용할 수 있도록 가져온다.
```dart
  @override
Widget build(BuildContext context) {

  // 네비게이션 바에서 선택되어 있는 아이콘 메뉴의 순서값을 관리하는 Provider
  // listen : true로 설정하면 Provider를 이용할 때 화면 자체가 다시 만들어진다.
  //          false로 설정하면 화면 전체가 다시 만들어지지 않는다.
  var tabPageIndexProvider = Provider.of<TabPageIndexProvider>(context, listen: false);
```

- selectedIndex도 Provider를 사용하는 것으로 변경한다.
```dart
      // 네비게이션 바에 배치된 아이콘 메뉴들 중 어떤 것을 선택할 것인가..
      selectedIndex: tabPageIndexProvider.currentPageIndex,
```

- onDestinationSelected도 Provider를 사용하는 것으로 변경한다.
```dart
        // 하단 메뉴를 눌렀을 때
        // value: 사용자가 누른 메뉴 항목의 순서값
        onDestinationSelected: (value){
            setState(() {
              tabPageIndexProvider.setCurrentPageIndex(value);
            });
        },
```

- main_screen_dart에서 Provider를 가져온다.
```dart
   @override
Widget build(BuildContext context) {
  // Provider
  var tabPageIndexProvider = Provider.of<TabPageIndexProvider>(context, listen: false);

```

- 보여줄 화면의 순서값을 담을 변수를 선언해준다.
```dart
    // Provider
    var tabPageIndexProvider = Provider.of<TabPageIndexProvider>(context, listen: false);
    // 보여줄 화면의 순서값
    var currentPageIndex = tabPageIndexProvider.currentPageIndex;
```

- 보여줄 화면의 순서값을 리스트에 적용해준다.
```dart
    // 보여줄 화면의 순서값
    var currentPageIndex = tabPageIndexProvider.currentPageIndex;
    
    return Container(
    child: [
        Center(child: Text("Home")),
        Center(child: Text("Search")),
        Center(child: Text("Saved")),
        Center(child: Text("More")),
        ][currentPageIndex],
    );
```

- 보여줄 화면을 변경할 수 있도록 Provider의 리스너를 등록해준다.
```dart
    // 프로바이더의 리스너를 등록해준다.
    // 프로바이더에서 notifyListeners(); 를 호출하면 동작한다.
    tabPageIndexProvider.addListener(() {
        // 화면의 순서값을 변경한다.
        setState(() {
          currentPageIndex = tabPageIndexProvider.currentPageIndex;
        });
    });
```

- main.dart의 home을 Provider를 이용할 수 있도록 설정해준다.
```dart
    // 화면 요소에서 프로바이더를 사용할 수 있도록 설정해준다.
    home: ChangeNotifierProvider(
        create: (BuildContext context) => TabPageIndexProvider(),
        child: Scaffold(
            bottomNavigationBar: MainBottomNavigationBar(),
            body: MainScreen(),
        ),
    ), 
```

### 이미지 사용을 위한 설정

1. lib 안에 assets 폴더를 만들고 그 안에 images 폴더를 만든다
lib/assets/images

2. 사용할 이미지들을 images 폴더에 복사해 넣어준다.

3. pubspec.yaml 파일 작업
- assets를 찾아 주석을 풀어준다.
- 이미지 파일들이 들어있는 경로를 등록해준다.
```yaml
  assets:
    - lib/assets/images/ 
```

### Carousel 사용 설정
1. pub.dev 사이트에서 carousel_slider로 검색한다.
2. 라이브러리 설치 문자열을 복사해 pubspec.yaml 파일에 넣어준다.
```yaml
dependencies:
  carousel_slider: ^4.2.1 
```
3. Pub get을 눌러준다.

### 첫 번째 화면 HomeScreen을 만들어준다.
1. screen 폴더에 home_screen.dart 파일을 만들어준다.
screen/home_screen.dart

2. Scaffold 구조의 기본 코드를 작성해준다.
```dart
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

    );
  }
}
```

3. main_screen.dart에서 첫 번째 화면으로 HomeScreen을 등록해준다.
```dart
    return Container(
        child: [
            HomeScreen(),
            Center(child: Text("Search")),
            Center(child: Text("Saved")),
            Center(child: Text("More")),
        ][currentPageIndex],
    );
```

### HomeScreen에서 사용할 상단 앱바를 만들어준다.
1. widget 폴더에 home_top_app_bar.dart 파일을 만들어준다.
- widget/home_top_app_bar.dart

2. StatefulWidget 구조를 작성해준다.
```dart
import 'package:flutter/material.dart';

class HomeTopAppBar extends StatefulWidget {
  const HomeTopAppBar({super.key});

  @override
  State<HomeTopAppBar> createState() => _HomeTopAppBarState();
}

class _HomeTopAppBarState extends State<HomeTopAppBar> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
```

3. HomeScreen의 appBar로 HomeTopAppBar를 등록해준다.
```dart
class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeTopAppBar(),
    );
  }
}
```

4. AppBar를 구성한다.
- Image.asset : 이미지를 가져와 보여준다.
- Image.asset의 fit : 이미지를 어떻게 채워줄 것인지 설정한다.
- BoxFit.fill : 원본 비율을 무시한 채 꽉 채워준다.
- BoxFit.contain : 원본 비율이 유지되는 최대 크기. 이미지가 모두 보이게 한다.
- BoxFit.cover : 원본 비율이 유지되는 최대 크기. 긴 쪽이 짤린다.
- BoxFit.fitWidth : 원본 비율이 유지되는 가로 최대 길이. 높이가 짤릴 수 있다.
- BoxFit.fitHeight : 원본 비율이 유지되는 세로 최대 길이. 가로가 짤릴 수 있다.
- BoxFit.none : 크기를 조정하지 않으며 이미지가 짤릴 수 있다.

- title을 구성해준다.
```dart
    // 앱바 구성
return AppBar(
    title: Row(
        children: [
            Image.asset(
              'lib/assets/images/youtube_logo.png',
              fit: BoxFit.contain, height: 25,
            ),
            Padding(padding: EdgeInsets.only(right: 10)),
            Text("LionFlix"),
        ],
    ),
);
```

- Appbar 우측에 나타나는 버튼들을 배치해준다.
```dart
    // 앱바 우측에 나타나는 메뉴들
    actions: [
        // tv 메뉴
        IconButton(
            onPressed: (){},
            icon: Icon(Icons.tv)
        ),
        // 영화 메뉴
        IconButton(
            onPressed: (){},
            icon: Icon(Icons.movie)
        ),
        // 찜 메뉴
        IconButton(
            onPressed: (){},
            icon: Icon(Icons.favorite)
        ),
    ],
```

### Carousel 을 구성한다.

1. widget 폴더에 home_carousel_slider.dart 파일을 만든다.

2. StatefulWidget 기본 코드를 작성해준다.
```dart
import 'package:flutter/material.dart';

class HomeCarouselSlider extends StatefulWidget {
  const HomeCarouselSlider({super.key});

  @override
  State<HomeCarouselSlider> createState() => _HomeCarouselSliderState();
}

class _HomeCarouselSliderState extends State<HomeCarouselSlider> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
```

3. HomeScreen에 등록해준다.
```dart
class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeTopAppBar(),
      body: HomeCarouselSlider(),
    );
  }
}
```

4. 위젯들을 배치할 수 있도록 Container를 배치해준다.
```dart
return Container(
    child: Column(
        children: [

        ],
    ),
);
```

5. 회전목마를 통해 보여줄 이미지 위젯들을 만들어준다.
```dart
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
```

6. 회전목마를 구현해준다.
```dart
    // 회전목마
    CarouselSlider(
        items: images,
        options: CarouselOptions(
            // 회전목마가 이미지를 보여주는 영역안에서 얼만큼의 크기로 이미지를
            // 보여줄지에 대한 비율. 1.0이 최대
            viewportFraction: 1.0,
            // 자동 슬라이드 활성화 여부
            autoPlay: true,
            // 자동 슬라이드 간격
            autoPlayInterval: Duration(seconds: 5),
        )
    ),
```

7. 현재 회전목마가 보여주고 있는 이미지의 순서값을 담을 변수를 선언해준다.
```dart
  // 회전 목마에서 보여주고 있는 이미지의 순서 값
  var imagePosition = 0;
```

8. 회전목마의 화면이 변경되었을 때의 리스너에서 변수에 현재 순서 번째 값을 넣어준다.
```dart
    onPageChanged: (index, reason) {
        // 현재 보여지는 이미지의 순서 값을 설정해준다.
        setState(() {
          imagePosition = index;
        });
    },
```

9. 영화 제목 임시 데이터를 만들어준다.
```dart
  // 영화 제목들
var movieTitles = [
  "영화1", "영화2", "영화3", "영화4", "영화5",
  "영화6", "영화7", "영화8", "영화9", "영화10",
];
```

10. 제목을 보여줄 부분을 작성해준다.
```dart
    Padding(padding: EdgeInsets.only(top: 10)),
    // 영화 제목
    Text(
        movieTitles[imagePosition],
        style: TextStyle(fontSize: 20),
    ),
```

### 버튼들 구성

1. Row를 배치한다.
```dart
    // 버튼들
    Row(
    
    ),
```

2. 내가 찜한 콘텐츠 버튼 부분을 구현해준다.
- 현재 순서 번째의 movieLike가 true면 check버튼을 사용하고 false면 add 버튼을 사용한다.
```dart
    // 버튼들
    Row(
        children: [
            // 찜
            Column(
                children: [
                    movieLike[imagePosition]
                    ? IconButton(onPressed: () {}, icon: Icon(Icons.check))
                        : IconButton(onPressed: () {}, icon: Icon(Icons.add)),
                    Text("내가 찜한 콘텐츠", style: TextStyle(fontSize: 11)),
                ],
            ),
        ],
    ),
```

3. 재생 버튼
```dart
    // 재생 버튼
    TextButton(
        onPressed: () {},
        child: Row(
            children: [
                Icon(
                    Icons.play_arrow,
                    color: Colors.black,
                ),
                Padding(padding: EdgeInsets.all(3)),
                Text("재생", style: TextStyle(color: Colors.black)),
            ],
        ),
        // 버튼의 모양
        style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(Colors.white),
            shape: MaterialStatePropertyAll(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                ),
            ),
        ),
    ),
```

4. 정보 버튼
```dart
    // 정보
    Column(
        children: [
            IconButton(
                onPressed: () {},
                icon: Icon(Icons.info)
            ),
            Text("정보", style: TextStyle(fontSize: 11))
        ],
    )
```

5. Row 안에 배치되는 요소들의 여백을 설정한다.
```dart
    Row(
        // 배치되는 뷰들의 간격을 설정해준다.
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
```

### 하단 인디케이터

1. pubspec.yaml에 인디케이터 라이브러리를 추가해준다.
   smooth_page_indicator: ^1.1.0

2. 인디케이터를 추가해준다
```dart
    // 인디케이터
    AnimatedSmoothIndicator(
        activeIndex: imagePosition,
        count: images.length,
        effect: WormEffect(
            dotWidth: 5,
            dotHeight: 5,
        ),
    ),
```

## 2024-05-07

### 미리보기 부분 구현
- 영화들을 좌우로 스크롤해서 확인할 수 있도록 구성한다.
- 영화 포스터를 둥근 모양으로 보여준다.

1. widget/home_circle_slider.dart 파일을 만든다.
2. StatefulWidget 코드를 작성해준다.
```dart
import 'package:flutter/material.dart';

class HomeCircleSlider extends StatefulWidget {
   const HomeCircleSlider({super.key});

   @override
   State<HomeCircleSlider> createState() => _HomeCircleSliderState();
}

class _HomeCircleSliderState extends State<HomeCircleSlider> {
   @override
   Widget build(BuildContext context) {
      return const Placeholder();
   }
}

```

3. HomeScreen의 body를 ListView 사용으로 변경한다.
```dart
      body: ListView(
         children: [
            // 상단 회전 목마
            HomeCarouselSlider(),
         ],
      ),
```

4. 미리 보기 부분을 배치한다.
```dart
      body: ListView(
         children: [
            // 상단 회전 목마
            HomeCarouselSlider(),
            Padding(padding: EdgeInsets.only(top: 20)),
            // 미리 보기 부분
            HomeCircleSlider(),
         ],
      ),
```

5. ListView 항목 하나를 구성하기 위한 함수를 작성해준다.
```dart
// ListView의 항목 하나를 구성하여 반환하는 함수
Widget makeListItem(){
   return Container(
      padding: EdgeInsets.only(right: 10),
      // 동그라미 형태로 보여주는 컨테이너
      child: CircleAvatar(
         // 배경 이미지
         backgroundImage: AssetImage("lib/assets/images/movie1.jpg"),
         // 크기
         radius: 48,
      ),
   );
}
```

6. ListView를 배치해준다.
```dart
return Container(
   padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
   child: Column(
   crossAxisAlignment: CrossAxisAlignment.start,
   children: [
      Text("미리보기"),
      Container(
         // 리스트 뷰의 크기를 컨테이너를 통해 설정한다.
         height: 120,
         // 다수의 항목을 보여주는 리스트 뷰는 builder를 통해 구성한다.
         child: ListView.builder(
            // 스크롤 방향은 가로 방향으로 설정한다.
            scrollDirection: Axis.horizontal,
            // 전체 항목의 개수
            itemCount: 10,
            // 항목 하나를 구성하기 위해 호출하는 함수
            // 여기서 반환하는 위젯이 항목 하나가 된다.
            itemBuilder: (context, index) {
              return makeListItem();
            },
         ),
      ),
   ],
   ),
);
```

### 지금 뜨는 컨텐츠 배치
- HomeCircleSlider와 거의 비슷하여 이미지가 네모 모양으로 나타나게 한다.

1. widget/home_box_slider.dart 파일을 만든다.

2. StatefulWidget 기본 코드를 작성해준다.

```dart
import 'package:flutter/material.dart';

class HomeBoxSlider extends StatefulWidget {
  const HomeBoxSlider({super.key});

  @override
  State<HomeBoxSlider> createState() => _HomeBoxSliderState();
}

class _HomeBoxSliderState extends State<HomeBoxSlider> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
```

3. HomeScreen에 배치해준다.
```dart
body: ListView(
   children: [
      // 상단 회전 목마
      HomeCarouselSlider(),
      Padding(padding: EdgeInsets.only(top: 20)),
      // 미리 보기 부분
      HomeCircleSlider(),
      Padding(padding: EdgeInsets.only(top: 20)),
      // 지금 뜨는 콘텐츠 부분
      HomeBoxSlider(),
   ],
),
```

4. 리스트뷰의 항목 하나를 구성하기 위한 함수를 호출한다.
```dart
// 리스트뷰의 항목 하나를 구성하는 함수
Widget makeListItem(){
   return Container(
      padding: EdgeInsets.only(right: 10),
      child: Image.asset('lib/assets/images/movie2.jpg'),
   );
}
```

5. 리스트뷰를 구성해준다.
```dart
   @override
   Widget build(BuildContext context) {
      return Container(
         padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
         child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Text("지금 뜨는 콘텐츠"),
               Container(
                  height: 120,
                  child: ListView.builder(
                     scrollDirection: Axis.horizontal,
                     itemCount: 10,
                     itemBuilder: (context, index) {
                        return makeListItem();
                     },
                  ),
               )
            ],
         ),
      );
   } 
```

### 영화 정보 보기 화면 구성
- 영화 정보를 상세하게 볼 수 있는 화면을 구성한다.
- 이 화면은 다음 동작에서 보여진다.
- HomeScreen에서 정보 버튼을 눌렀을 때
- HomeScreen에서 미리보기의 영화 포스터를 눌렀을 때
- HomeScreen에서 지금 뜨는 콘텐츠에서 영화 포스터를 눌렀을 때
- Search에서 검색된 결과에서 영화를 선택했을 때
- Saved에서 저장한 영화 목록에서 영화를 선택했을 때

1. screen/detail_screen.dart 파일을 만들어준다.

2. StatefulWidget 기본 코드를 작성한다.
```dart
import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
   const DetailScreen({super.key});

   @override
   State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
   @override
   Widget build(BuildContext context) {
      return const Placeholder();
   }
} 
```

3. home_carousel_slider의 정보 버튼을 눌렀을 때
```dart
              // 정보
Column(
   children: [
      IconButton(
         onPressed: () {
            // DetailScreen을 띄워준다.
            Navigator.of(context).push(
               MaterialPageRoute(
                  // 보여질 다음 화면을 설정한다.
                  builder: (context) => DetailScreen(),
                  // 다이얼로그로 보여지게 한다.
                  fullscreenDialog: true
               )
            );
         },
         icon: Icon(Icons.info)
      ),
      Text("정보", style: TextStyle(fontSize: 11))
   ],
),
```

4. DetailScreen을 구성해준다.
```dart
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

```

5. HomeCircleSlider의 makeListItem을 수정한다.
```dart
itemBuilder: (context, index) {
  return makeListItem(context);
},

// ListView의 항목 하나를 구성하여 반환하는 함수
Widget makeListItem(BuildContext context){
  // InkWell : 사용자 이벤트를 처리할 수 있는 컨테이너
  // 화면 요소에 사용자 이벤트에 관련된 리스너가 없을 경우 사용한다.
  return InkWell(
    // 눌렀을 때의 리스너
    onTap: () {
      // DetailScreen을 띄운다.
      Navigator.of(context).push(
          MaterialPageRoute(
              builder: (context) => DetailScreen(),
              fullscreenDialog: true
          )
      );
    },
    child: Container(
      padding: EdgeInsets.only(right: 10),
      // 동그라미 형태로 보여주는 컨테이너
      child: CircleAvatar(
        // 배경 이미지
        backgroundImage: AssetImage("lib/assets/images/movie1.jpg"),
        // 크기
        radius: 48,
      ),
    ),
  );
}
```

6. HomeBoxSlider를 수정한다.
```dart
itemBuilder: (context, index) {
  return makeListItem(context);
},

// 리스트뷰의 항목 하나를 구성하는 함수
Widget makeListItem(BuildContext context){
   return InkWell(
      // 눌렀을 때의 리스너
      onTap: () {
         // DetailScreen을 띄운다.
         Navigator.of(context).push(
                 MaterialPageRoute(
                         builder: (context) => DetailScreen(),
                         fullscreenDialog: true
                 )
         );
      },
      child: Container(
         padding: EdgeInsets.only(right: 10),
         child: Image.asset('lib/assets/images/movie2.jpg'),
      ),
   );
}
```

### 검색 화면 구성
- 상단에 검색창을 배치한다.
- 그 다음에는 검색결과가 나오는 리스트 뷰를 배치한다.

1. screen/search_screen.dart 파일을 만들어준다.

2. StatefulWidget 기본 코드를 작성해준다.
```dart
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
   const SearchScreen({super.key});

   @override
   State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
   @override
   Widget build(BuildContext context) {
      return const Placeholder();
   }
}
```

3. MainScreen의 두 번째 탭 화면을 변경한다.
```dart
      return Container(
         child: [
            HomeScreen(),
            SearchScreen(),
            Center(child: Text("Saved")),
            Center(child: Text("More")),
         ][currentPageIndex],
      );
```

4. SearchScreen을 Scaffold 구조로 작성해준다.
```dart
class _SearchScreenState extends State<SearchScreen> {
   @override
   Widget build(BuildContext context) {
      return Scaffold(

      );
   }
}
```

5. 상단 앱바 구성을 위해 widget/search_top_app_bar.dart 파일을 만든다.
```dart
import 'package:flutter/material.dart';

class SearchTopAppBar extends StatefulWidget implements PreferredSizeWidget {
   const SearchTopAppBar({super.key});

   @override
   State<SearchTopAppBar> createState() => _SearchTopAppBarState();

   @override
   Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _SearchTopAppBarState extends State<SearchTopAppBar> {
   @override
   Widget build(BuildContext context) {
      return const Placeholder();
   }
}

```

6. AppBar를 구성해준다.
```dart
      return AppBar(
         title: Row(
            children: [
               Image.asset(
                  'lib/assets/images/youtube_logo.png',
                  fit: BoxFit.contain,
                  height: 25,
               ),
               Padding(padding: EdgeInsets.only(right: 10)),
               Text("LionFlix"),
            ],
         ),
      );
```

7. SearchScreen에 AppBar를 배치한다.
```dart
   return Scaffold(
    appBar: SearchTopAppBar(),

   );
```

8. body 구조를 잡아준다.
```dart
   return Scaffold(
      appBar: SearchTopAppBar(),
      body: Container(
         padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
         child: Column(
            children: [
            
            ],
         ),
      ),
   );
```

9. 검색을 위한 SearchBar 구성을 위해 widget/search_search_bar 파일을 만든다.
```dart
import 'package:flutter/material.dart';

class SearchSearchBar extends StatefulWidget {
   const SearchSearchBar({super.key});

   @override
   State<SearchSearchBar> createState() => _SearchSearchBarState();
}

class _SearchSearchBarState extends State<SearchSearchBar> {
   @override
   Widget build(BuildContext context) {
      return const Placeholder();
   }
}
```

10. SearchBar를 구성해준다.
```dart
   Widget build(BuildContext context) {
      return SearchBar(
         // 좌측에 배치되는 아이콘
         leading: Icon(Icons.search),
         // 내부 여백
         padding: MaterialStatePropertyAll(EdgeInsets.fromLTRB(10, 0, 10, 0)),
      );
   }
```

11. SearchBar를 배치한다.
```dart
class _SearchScreenState extends State<SearchScreen> {
   @override
   Widget build(BuildContext context) {
      return Scaffold(
         appBar: SearchTopAppBar(),
         body: Container(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: Column(
               children: [
                  // 검색바
                  SearchSearchBar(),
               ],
            ),
         ),
      );
   }
}

```

12. 리스트 구성을 위해 widget/search_list_view.dart 파일을 만들어준다.
```dart
import 'package:flutter/material.dart';

class SearchListView extends StatefulWidget {
   const SearchListView({super.key});

   @override
   State<SearchListView> createState() => _SearchListViewState();
}

class _SearchListViewState extends State<SearchListView> {
   @override
   Widget build(BuildContext context) {
      return const Placeholder();
   }
}
```

13. 항목 하나를 구성하는 함수를 작성해준다.
```dart
// 리스트뷰의 항목 하나를 구성하는 함수
// 리스트뷰의 항목은 ListTitle을 사용해도 된다 대신 아이콘 사이즈 조절 불가
Widget makeListItem(BuildContext context){
   return Container(
      padding: EdgeInsets.only(top: 10),
      child: InkWell(
         onTap: () {
            MaterialPageRoute(
                    builder: (context) => DetailScreen(),
                    fullscreenDialog: true
            )
         },
         child: Row(
            children: [
               Image.asset(
                  'lib/assets/images/movie4.jpg',
                  width: 100,
               ),
               Padding(padding: EdgeInsets.only(right: 10)),
               Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     Text(
                             '영화제목',
                             style: TextStyle(fontSize: 15)
                     ),
                     Text(
                             '출연진 : 배우1, 배우2, 배우3',
                             style: TextStyle(fontSize: 12)
                     ),
                     Text(
                             '제작진 : 제작1, 제작2, 제작3',
                             style: TextStyle(fontSize: 12)
                     ),
                  ],
               )
            ],
         ),
      ),
   );
}

// ListTitle 사용 예
//
Widget makeListItem2(){
   return ListTile(
      leading: Image.asset('lib/assets/images/movie6.jpg'),
      title: Text('영화 제목'),
      subtitle: Text('출연진 : 배우1, 배우2, 배우3\n제작진 : 제작1, 제작2, 제작3'),
      isThreeLine: true,
      onTap: () {},
   );
} 
```

14. ListView를 구성해준다.
```dart
class _SearchListViewState extends State<SearchListView> {
   @override
   Widget build(BuildContext context) {
      return ListView.builder(
         itemCount: 10,
         itemBuilder: (context, index) => makeListItem(context),
         // itemBuilder: (context, index) => makeListItem2(),
      );
   }
} 
```

15. SearchScreen에 ListView를 배치해준다.
```dart
      child: Column(
         children: [
            // 검색바
            SearchSearchBar(),
            Padding(padding: EdgeInsets.only(top: 10)),
            // 검색 결과가 나올 ListView
            // Column이나 Row 등 사이즈를 정하지 못하는 컨테이너에
            // 리스트뷰를 배치할 때는 Expanded 컨테이너를 사용해야 한다.
            // Expanded는 컨테이너의 크기가 나중에(항목이 구성된 후)에 다시 조정되는 컨테이너이다.
            Expanded(child: SearchListView()),
         ],
      ),
```

## 2024-05-08

### 저장한 컨텐츠 보기

1. screen/like_screen.dart 파일을 만든다.

```dart
 import 'package:flutter/material.dart';

class LikeScreen extends StatefulWidget {
   const LikeScreen({super.key});

   @override
   State<LikeScreen> createState() => _LikeScreenState();
}

class _LikeScreenState extends State<LikeScreen> {
   @override
   Widget build(BuildContext context) {
      return const Placeholder();
   }
}
```

2. AppBar 작성을 위해 widget/like_top_app_bar.dart 파일을 만든다.

```dart
import 'package:flutter/material.dart';

class LikeTopAppBar extends StatefulWidget implements PreferredSizeWidget {
   const LikeTopAppBar({super.key});

   @override
   State<LikeTopAppBar> createState() => _LikeTopAppBarState();

   @override
   // TODO: implement preferredSize
   Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _LikeTopAppBarState extends State<LikeTopAppBar> {
   @override
   Widget build(BuildContext context) {
      return AppBar(
         title: Row(
            children: [
               Image.asset(
                  'lib/assets/images/youtube_log.png',
                  fit: BoxFit.contain,
                  height: 25,
               ),
               Padding(padding: EdgeInsets.only(right: 10)),
               Text('LionFlix'),
            ],
         ),
      );
   }
}

```

3. AppBar를 배치한다.

```dart
class _LikeScreenState extends State<LikeScreen> {
   @override
   Widget build(BuildContext context) {
      return Scaffold(
         appBar: LikeTopAppBar(),
      );
   }
}

```

4. MainScreen에 LikeScreen을 배치한다.

```dart
      return Container(
         child: [
            HomeScreen(),
            SearchScreen(),
            LikeScreen(),
            Center(child: Text("More")),
         ][currentPageIndex],
      );
```

5. ListView 구성을 위한 widget/like_list_view.dart 파일을 만든다.

```dart
import 'package:flutter/material.dart';

class LikeListView extends StatefulWidget {
   const LikeListView({super.key});

   @override
   State<LikeListView> createState() => _LikeListViewState();
}

class _LikeListViewState extends State<LikeListView> {
   @override
   Widget build(BuildContext context) {
      return const Placeholder();
   }
} 
```

6. 항목 하나의 구조를 작성한다.

```dart
// 리스트 뷰의 항목 하나를 구성하는 함수
Widget makeListItem(BuildContext context){
   return Container(
      padding: EdgeInsets.only(top: 10),
      child: InkWell(
         onTap: () {

         },
         child: Row(),
      ),
   );
}
```

7. Row 내부 구조를 작성해준다.

```dart
   child: InkWell(
      onTap: () {
      
      },
      child: Row(
         // 양쪽에 하나씩 배치되도록 한다.
         mainAxisAlignment: MainAxisAlignment.spaceBetween,
         children: [
            Row(),
            IconButton(
               onPressed: () {
               
               },
               icon: Icon(Icons.delete)
            ),
         ],
      ),
   ),
```

8. 항목 좌측 부분을 구성해준다.

```dart
      Row(
         children: [
            Image.asset(
               'lib/assets/images/movie7.jpg',
               width: 100,
            ),
            Padding(padding: EdgeInsets.only(right: 10)),
            Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                  Text('영화제목'),
                  Text('출연진 : 배우1, 배우2, 배우3'),
                  Text('제작진 : 제작1, 제작2, 제작3'),
               ],
            )
         ],
      ),
```

9. InkWell의 onTap을 구현한다.

```dart
   child: InkWell(
      onTap: () {
         Navigator.of(context).push(
            MaterialPageRoute(
               builder: (context) => DetailScreen(),
               fullscreenDialog: true,
            )
         );
      },
```

10. LikeScreen에 리스트뷰를 배치한다.

```dart
class _LikeScreenState extends State<LikeScreen> {
   @override
   Widget build(BuildContext context) {
      return Scaffold(
         appBar: LikeTopAppBar(),
         body: Container(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: LikeListView(),
         ),
      );
   }
}

```

### more 화면

1. screen/more_screen.dart 파일을 만들어준다.

```dart
import 'package:flutter/material.dart';

class MoreScreen extends StatefulWidget {
   const MoreScreen({super.key});

   @override
   State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
   @override
   Widget build(BuildContext context) {
      return const Placeholder();
   }
}

```

2. appbar 구성을 위한 widget/more_top_app_bar.dart 파일을 만들어준다.

```dart
import 'package:flutter/material.dart';

class MoreTopAppBar extends StatefulWidget implements PreferredSizeWidget {
   const MoreTopAppBar({super.key});

   @override
   State<MoreTopAppBar> createState() => _MoreTopAppBarState();

   @override
   // TODO: implement preferredSize
   Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _MoreTopAppBarState extends State<MoreTopAppBar> {
   @override
   Widget build(BuildContext context) {
      return AppBar(
         title: Row(
            children: [
               Image.asset(
                  'lib/assets/images/youtube_logo.png',
                  fit: BoxFit.contain,
                  height: 25,
               ),
               Padding(padding: EdgeInsets.only(right: 10)),
               Text('LionFlix'),
            ],
         ),
      );
   }
}
 
```

3. AppBar를 배치한다.

```dart
class _MoreScreenState extends State<MoreScreen> {
   @override
   Widget build(BuildContext context) {
      return Scaffold(
         appBar: MoreTopAppBar(),
      );
   }
}
```

4. MainScreen에 MoreScreen을 배치해준다.

```dart
   return Container(
      child: [
         HomeScreen(),
         SearchScreen(),
         LikeScreen(),
         MoreScreen(),
      ][currentPageIndex],
   ); 
```

5. ListView 구성을 위해 widget/more_list_view.dart 파일을 만들어준다.

```dart
import 'package:flutter/material.dart';

class MoreListView extends StatefulWidget {
   const MoreListView({super.key});

   @override
   State<MoreListView> createState() => _MoreListViewState();
}

class _MoreListViewState extends State<MoreListView> {
   @override
   Widget build(BuildContext context) {
      return const Placeholder();
   }
}
 
```

6. ListView를 배치한다.

```dart
class _MoreScreenState extends State<MoreScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MoreTopAppBar(),
      body: Container(
        padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
        child: MoreListView(),
      ),
    );
  }
}

```

7. ListView를 구성해준다.

```dart
class _MoreListViewState extends State<MoreListView> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        InkWell(
          onTap: () {},
          child: Text('마이 페이지', style: TextStyle(fontSize: 20)),
        ),
        Divider(),
        InkWell(
          onTap: () {},
          child: Text('메뉴1', style: TextStyle(fontSize: 20)),
        ),
        Divider(),
        InkWell(
          onTap: () {},
          child: Text('메뉴2', style: TextStyle(fontSize: 20)),
        ),
        Divider(),
        InkWell(
          onTap: () {},
          child: Text('메뉴3', style: TextStyle(fontSize: 20)),
        ),
      ],
    );
  }
}

```

### 마이 페이지

1. 마이페이지를 위한 screen/my_page_screen.dart 파일을 만들어준다.

```dart
import 'package:flutter/material.dart';

class MyPageScreen extends StatefulWidget {
   const MyPageScreen({super.key});

   @override
   State<MyPageScreen> createState() => _MyPageScreenState();
}

class _MyPageScreenState extends State<MyPageScreen> {
   @override
   Widget build(BuildContext context) {
      return const Placeholder();
   }
} 
```

2. 화면 전환 효과를 슬라이드로 적용하여 화면을 바꿔준다.

```dart
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
                pageBuilder: (context, animation, secondaryAnimation) => MyPageScreen(),
                // 화면 전환 애니메이션 구성
                // animation : 기본 애니메이션 정보가 설정되어있는 객체
                // child : 새롭게 나타나는 화면 객체, pageBuilder에서 반환한 화면 객체
                transitionsBuilder: (context, animation, secondaryAnimation, child) {
                  // 새로 나타나는 화면 초기 위치(가로축 길이 비율, 세로축 길이 비율)
                  var begin = Offset(1.0, 0.0);
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
```

3. widget/my_page_top_app_bar.dart 파일을 만든다.

```dart
import 'package:flutter/material.dart';

class MyPageTopAppBar extends StatefulWidget implements PreferredSizeWidget {
   const MyPageTopAppBar({super.key});

   @override
   State<MyPageTopAppBar> createState() => _MyPageTopAppBarState();

   @override
   // TODO: implement preferredSize
   Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _MyPageTopAppBarState extends State<MyPageTopAppBar> {
   @override
   Widget build(BuildContext context) {
      return AppBar(
         title: Row(
            children: [
               Image.asset(
                  'lib/assets/images/youtube_logo.png',
                  fit: BoxFit.contain,
                  height: 25,
               ),
               Padding(padding: EdgeInsets.only(right: 10)),
               Text('LionFlix'),
            ],
         ),
      );
   }
}
```

4. MyPageScreen에 배치해준다.

```dart
class _MyPageScreenState extends State<MyPageScreen> {
   @override
   Widget build(BuildContext context) {
      return Scaffold(
         appBar: MyPageTopAppBar(),
      );
   }
}
```

5. body 기본 구조를 작성해준다.
```dart
   body: Container(
      padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
      child: ListView(
         children: [

         ],
      ),
   ), 
```

6. 상단 프로필 사진을 배치해준다.
```dart
      child: ListView(
         children: [
            // 상단 프로필 이미지
            Container(
               height: 100,
               child: Center(
                child: Image.asset('lib/assets/images/youtube_logo.png'),
               ),
            )
         ],
      ), 
```

7. 카메라, 앨범 버튼을 배치한다.
```dart
            Padding(padding: EdgeInsets.only(top: 10)),
            // 카메라, 앨범 버튼
            Row(
               mainAxisAlignment: MainAxisAlignment.center,
               children: [
                  IconButton(onPressed: () {}, icon: Icon(Icons.camera_alt)),
                  IconButton(onPressed: () {}, icon: Icon(Icons.photo_album)),
               ],
            ),
```

8. 이름 입력 요소를 배치한다.

```dart
            Padding(padding: EdgeInsets.only(top: 10)),
            // 이름 입력
            TextField(
               decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: '이름'
               ),
            ), 
```

9. 닉네임 입력 요소를 배치한다.

```dart
            Padding(padding: EdgeInsets.only(top: 10)),
            // 이름 입력
            TextField(
               decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: '닉네임'
               ),
            ), 
```

10. 저장 버튼을 배치한다.
```dart
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
```

### 영화 드라마
- 둘은 코드가 거의 똑같기 때문에 같이 정리한다.

1. screen/movie_screen.dart, screen/drama_screen.dart 파일을 만든다.

```dart
import 'package:flutter/material.dart';

class MovieScreen extends StatefulWidget {
  const MovieScreen({super.key});

  @override
  State<MovieScreen> createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
```

```dart
import 'package:flutter/material.dart';

class DramaScreen extends StatefulWidget {
  const DramaScreen({super.key});

  @override
  State<DramaScreen> createState() => _DramaScreenState();
}

class _DramaScreenState extends State<DramaScreen> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

```

2. HomeScreen의 앱바 메뉴에 화면 전환 코드를 넣어준다.

```dart
      // 앱바 우측에 나타나는 메뉴들
      actions: [
        // tv 메뉴
        IconButton(
            onPressed: (){
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => DramaScreen(),
                ),
              );
            },
            icon: Icon(Icons.tv)
        ),
        // 영화 메뉴
        IconButton(
            onPressed: (){
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => MovieScreen(),
                ),
              );
            },
            icon: Icon(Icons.movie)
        ),
      ],
```

3. AppBar를 구성할 파일을 만들어준다.

- widget/drama_top_app_bar.dart
```dart
import 'package:flutter/material.dart';

class DramaTopAppBar extends StatefulWidget implements PreferredSizeWidget {
   const DramaTopAppBar({super.key});

   @override
   State<DramaTopAppBar> createState() => _DramaTopAppBarState();

   @override
   // TODO: implement preferredSize
   Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _DramaTopAppBarState extends State<DramaTopAppBar> {
   @override
   Widget build(BuildContext context) {
      return AppBar(
         title: Row(
            children: [
               Image.asset(
                  'lib/assets/images/youtube_logo.png',
                  fit: BoxFit.contain,
                  height: 25,
               ),
               Padding(padding: EdgeInsets.only(right: 10)),
               Text('LionFlix'),
            ],
         ),
      );
   }
} 
```

- widget/movie_top_app_bar.dart
```dart
import 'package:flutter/material.dart';

class MovieTopAppBar extends StatefulWidget implements PreferredSizeWidget {
   const MovieTopAppBar({super.key});

   @override
   State<MovieTopAppBar> createState() => _MovieTopAppBarState();

   @override
   // TODO: implement preferredSize
   Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _MovieTopAppBarState extends State<MovieTopAppBar> {
   @override
   Widget build(BuildContext context) {
      return AppBar(
         title: Row(
            children: [
               Image.asset(
                  'lib/assets/images/youtube_logo.png',
                  fit: BoxFit.contain,
                  height: 25,
               ),
               Padding(padding: EdgeInsets.only(right: 10)),
               Text('LionFlix'),
            ],
         ),
      );
   }
}
```

4. AppBar를 배치해준다.

```dart
class _DramaScreenState extends State<DramaScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DramaTopAppBar(),
    );
  }
}
```

```dart
class _MovieScreenState extends State<MovieScreen> {
   @override
   Widget build(BuildContext context) {
      return Scaffold(
         appBar: MovieTopAppBar(),
      );
   }
}
```

5. GridView의 항목 하나를 구성하는 함수를 만들어준다.

```dart
// 그리드 뷰의 항목 하나를 구성하는 함수
Widget makeGridItem(BuildContext context){
  return InkWell(
    onTap: () {
       Navigator.of(context).push(
               MaterialPageRoute(
                  builder: (context) => DetailScreen(),
                  fullscreenDialog: true,
               )
       );
    },
    child: Image.asset('lib/assets/images/movie8.jpg'),
  );
}
```

6. GridView를 구성해준다.

```dart
class _DramaScreenState extends State<DramaScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DramaTopAppBar(),
      body: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            // 컬럼의 개수
            crossAxisCount: 4,
            // 수평 방향 여백
            mainAxisSpacing: 10,
            // 수직 방향 여백
            crossAxisSpacing: 10,
            // 항목의 가로 세로 비율
            childAspectRatio: 0.7,
          ),
          itemBuilder: (context, index) => makeGridItem(context),
      ),
    );
  }
}
```

```dart
class _MovieScreenState extends State<MovieScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MovieTopAppBar(),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          // 컬럼의 개수
          crossAxisCount: 4,
          // 수평 방향 여백
          mainAxisSpacing: 10,
          // 수직 방향 여백
          crossAxisSpacing: 10,
          // 항목의 가로 세로 비율
          childAspectRatio: 0.7,
        ),
        itemBuilder: (context, index) => makeGridItem(context),
      ),
    );
  }
}
```

## 2024-05-09

### 파이어베이스 연동 설정
- Flutter Firebase 연동 작업을 모두 완료해준다.
- 라이브러리를 추가한다(pubspec.yaml)
- firebase_core
- cloud_firestore
- firebase_storage

1. main.dart 파일에서 파이어베이스 초기화
```dart
Future<void> main() async {

   // 파이어 베이스 사용 시 화면이 안나오는 문제 해결
   // 파이어 베이스의 await(동기화) 때문에 Flutter VM이 화면 처리를 못하는 문제 발생
   // 이를 위해 설정해준다.
   WidgetsFlutterBinding.ensureInitialized();
   // Firestore 초기 설정
   await Firebase.initializeApp();

   runApp(LionFlixApp());
}
```

2. 위 작업 후 실행하면 오류가 발생한다.
- 이 오류는 안드로이드의 프로젝트 설정때문에 발생하는 문제이다.
- android/app/build.gradle
- defaultConfig에 multiDexEnabled true를 넣어준다.

```gradle
    defaultConfig {
        ...
        multiDexEnabled true
        ...
    }
```

### 파이어베이스 연동 테스트
```dart
// 찜 메뉴
IconButton(
   onPressed: () => addTest,
   icon: Icon(Icons.favorite)
),

// 테스트 데이터 저장
Future<void> addTest() async {
   await FirebaseFirestore.instance.collection('test').add({
      'data1' : 100,
      'data2' : 11.111,
      'data3' : '안녕하세요'
   });
}

// 테스트 데이터 출력
Future<void> printTest() async {
   var result = await FirebaseFirestore.instance.collection('test').get();
   for(var doc in result.docs){
      var map = doc.data();
      print('firebase test : $map');
   }
}
```

### 파이어베이스에 기본 데이터 저장하기
1. Storage에 poster라는 폴더를 만들어주고 이미지 파일을 업로드한다.

2. main.dart에 데이터를 저장하는 함수를 넣어준다.
```dart
Future<void> addInitData() async {

   // await FirebaseFirestore.instance.collection('test').doc('bbbb').set(
   //   {
   //     'data1' : 100,
   //     'data2' : '하하하'
   //   }
   // );

   await FirebaseFirestore.instance.collection('movie_data').add({
      'movie_idx' : 1,
      'movie_title' : '라라 랜드',
      'movie_info' : '2016 12+',
      'movie_type' : 1,
      'movie_detail_info' : "꿈을 꾸는 사람들을 위한 별들의 도시 '라라랜드'. 재즈 피아니스트 '세바스찬'(라이언 고슬링)과 성공을 꿈꾸는 배우 지망생 '미아'(엠마 스톤). 인생에서 가장 빛나는 순간 만난 두 사람은 미완성인 서로의 무대를 만들어가기 시작한다.",
      'movie_actor' : '라이언 고슬링, 엠마 스톤, 존 레전드 외',
      'movie_director' : '데이미언 셔젤',
      'movie_poster' : 'movie1.jpg'
   });

   await FirebaseFirestore.instance.collection('movie_data').add({
      'movie_idx' : 2,
      'movie_title' : '백두산',
      'movie_info' : '2019 12+',
      'movie_type' : 2,
      'movie_detail_info' : "대한민국 관측 역사상 최대 규모의 백두산 폭발 발생. 갑작스러운 재난에 한반도는 순식간에 아비규환이 되고, 남과 북 모두를 집어삼킬 추가 폭발이 예측된다.",
      'movie_actor' : '이병헌, 하정우, 마동석, 전혜진, 배수지 外',
      'movie_director' : '이해준, 김병서',
      'movie_poster' : 'movie2.jpg'
   });

   await FirebaseFirestore.instance.collection('movie_data').add({
      'movie_idx' : 3,
      'movie_title' : '1987',
      'movie_info' : '2017 15+',
      'movie_type' : 1,
      'movie_detail_info' : "증거인멸을 위해 박 처장(김윤석)의 주도 하에 경찰은 시신 화장을 요청하지만, 사망 당일 당직이었던 최 검사(하정우)는 이를 거부하고 부검을 밀어붙인다.",
      'movie_actor' : '김윤석, 하정우, 유해진, 김태리, 박희순, 이희준 외',
      'movie_director' : '장준환',
      'movie_poster' : 'movie3.jpg'
   });

   await FirebaseFirestore.instance.collection('movie_data').add({
      'movie_idx' : 4,
      'movie_title' : '기생충',
      'movie_info' : '2020 15+',
      'movie_type' : 2,
      'movie_detail_info' : "전원백수로 살 길 막막하지만 사이는 좋은 기택(송강호) 가족.",
      'movie_actor' : '송강호, 이선균, 조여정, 최우식, 박소담, 장혜진, 이정은 外',
      'movie_director' : '봉준호',
      'movie_poster' : 'movie4.jpg'
   });

   await FirebaseFirestore.instance.collection('movie_data').add({
      'movie_idx' : 5,
      'movie_title' : '부산행',
      'movie_info' : '2016 15+',
      'movie_type' : 1,
      'movie_detail_info' : "정체불명의 바이러스가 전국으로 확산되고 대한민국 긴급재난경보령이 선포된 가운데,",
      'movie_actor' : '공유, 정유미, 마동석, 최우식, 안소희, 김의성, 김수안 등',
      'movie_director' : '연상호',
      'movie_poster' : 'movie5.jpg'
   });

   await FirebaseFirestore.instance.collection('movie_data').add({
      'movie_idx' : 6,
      'movie_title' : '너의 이름은',
      'movie_info' : '2017 12+',
      'movie_type' : 2,
      'movie_detail_info' : "한 달 후, 천 년 만에 찾아온다는 혜성을 기다리고 있는 일본.",
      'movie_actor' : '카미키 류노스케, 카미시라이시 모네, 타니 카논, 이시카와 카이토, 나가사와 마사미, 나리타 료, 시마자키 노부나가, 유우키 아오이',
      'movie_director' : '신카이 마코토',
      'movie_poster' : 'movie6.jpg'
   });

   await FirebaseFirestore.instance.collection('movie_data').add({
      'movie_idx' : 7,
      'movie_title' : '어벤져스 : 엔드게임',
      'movie_info' : '2019 12+',
      'movie_type' : 1,
      'movie_detail_info' : "인피니티 워 이후 절반만 살아남은 지구, 마지막 희망이 된 어벤져스. 먼저 떠난 그들을 위해 모든 것을 걸었다! 위대한 어벤져스, 운명을 바꿀 최후의 전쟁이 펼쳐진다!",
      'movie_actor' : '로버트 다우니 주니어, 크리스 에반스, 마크 러팔로, 크리스 헴스워스, 스칼렛 요한슨, 제레미 레너, 돈 치들, 폴 러드, 브리 라슨, 카렌 길런, 다나이 구리라, 브래들리 쿠퍼, 조시 브롤린, 톰 홀랜드',
      'movie_director' : '앤서니 루소, 조 루소',
      'movie_poster' : 'movie7.jpg'
   });

   await FirebaseFirestore.instance.collection('movie_data').add({
      'movie_idx' : 8,
      'movie_title' : '파묘',
      'movie_info' : '2024 15+',
      'movie_type' : 2,
      'movie_detail_info' : "미국 LA, 거액의 의뢰를 받은 무당 ‘화림’(김고은)과 ‘봉길’(이도현)은 기이한 병이 대물림되는 집안의 장손을 만난다.",
      'movie_actor' : '최민식, 김고은, 유해진, 이도현',
      'movie_director' : '장재현',
      'movie_poster' : 'movie8.jpg'
   });

   await FirebaseFirestore.instance.collection('movie_data').add({
      'movie_idx' : 9,
      'movie_title' : '길복순',
      'movie_info' : '2023 19+',
      'movie_type' : 1,
      'movie_detail_info' : "청부살인업계의 전설적인 킬러 길복순이 회사와 재계약 직전, 죽거나 또는 죽이거나, 피할 수 없는 대결에 휘말리게 되는 이야기를 그린 액션 영화",
      'movie_actor' : '전도연, 설경구, 김시아, 이솜, 구교환 外',
      'movie_director' : '변성현',
      'movie_poster' : 'movie9.jpg'
   });

   await FirebaseFirestore.instance.collection('movie_data').add({
      'movie_idx' : 10,
      'movie_title' : '대부',
      'movie_info' : '1977 19+',
      'movie_type' : 2,
      'movie_detail_info' : "1945년, 비토 코를레오네의 딸 코니 코를레오네와 카를로 리치의 결혼식이 진행되고 있다.",
      'movie_actor' : '말런 브랜도, 알 파치노 外',
      'movie_director' : '프랜시스 포드 코폴라',
      'movie_poster' : 'movie10.jpg'
   });

   await FirebaseFirestore.instance.collection('hot').add({
      'hot_movie_idx' : [1, 3]
   });

   await FirebaseFirestore.instance.collection('like').add({
      'like_movie_index' : []
   });
}
```

3. firestore에 테스트용으로 저장되어 있는 컬렉션은 모두 삭제한다.

4. main 함수에서 호출해준다.
```dart
Future<void> main() async {

   // 파이어 베이스 사용 시 화면이 안나오는 문제 해결
   // 파이어 베이스의 await(동기화) 때문에 Flutter VM이 화면 처리를 못하는 문제 발생
   // 이를 위해 설정해준다.
   WidgetsFlutterBinding.ensureInitialized();
   // Firestore 초기 설정
   await Firebase.initializeApp();

   // 초기 데이터 저장
   addInitData();

   runApp(LionFlixApp());
}
```

5. 실행 후 firestore에서 데이터가 저장되었는지 확인해준다.

6. addInitData() 호출 부분은 주석 처리해준다.

### HomeScreen 작업

1. lib 폴더에 dao 폴더를 생성해준다.

2. dao 폴더에 movie_dao.dart 파일을 만들어준다.

3. 영화 정보 전체를 가져오는 함수를 작성한다.
```dart
import 'package:cloud_firestore/cloud_firestore.dart';

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
```

4. 데이터를 가져오는 메서드를 만들어준다.
```dart
// 영화 데이터를 가져오는 메서드
// getMovieData를 initState에서 직접 호출하려면 async가 붙기 때문에
// initState를 async로 바꾸면 오류가 난다.
// 따라서 별도의 async 함수를 만들어 감싼 후 해당 함수를
// initState에서 호출하는 방식으로 사용한다.
Future<void> getData() async {
   // 영화 데이터를 가져온다.
   var tempMovieData = await getMovieData();
   print('home screen - $tempMovieData');
}
```

5. initState에서 호출해준다.
```dart
// 화면이 보여질 때마다 호출되는 함수
// 안드로이드의 onResume과 같은 역할
@override
void initState() {
   // TODO: implement initState
   super.initState();

   // 데이터를 가져오는 메서드를 호출해준다.
   getData();
}
```

6. 이미지를 가져오는 메서드를 만들어준다.
```dart
import 'package:flutter/material.dart';

// 이미지 데이터를 가져온다.
Future<Image> getImageData(String fileName) async {
   // 이미지를 가져올 수 있는 주소를 가져온다.
   String imageUrl = await FirebaseStorage.instance.ref('poster/$fileName').getDownloadURL();
   // print(imageUrl);

   // 이미지를 관리하는 객체
   Image resultImage = Image.network(imageUrl);

   return resultImage;
}
```

7. 영화 데이터와 이미지 데이터를 담을 상태 변수를 만들어준다.
```dart
// 영화 데이터를 담을 상태 변수
List<Map<String, dynamic>> movieData = [];
// 영화 포스터를 담을 상태 변수
List<Image> posterData = [];
```

8. 영화의 수 만큼 임시 포스터 객체를 만들어 담아준다.
```dart
   // 영화의 수 만큼 이미지 객체를 만들어준다.
   posterData = List<Image>.generate(
      // 리스트가 담을 객체의 개수
      tempMovieData.length,
      // 리스트가 담을 객체를 생성해 반환해준다.
      (index) => Image.asset('lib/assets/images/loading.gif'),
   );
```

9. 영화 정보 상태를 설정한다.
```dart
   // 영화 데이터를 통해 상태를 설정한다.
   setState(() {
    movieData = tempMovieData;
   }); 
```
10. 포스터 데이터를 받아오며 상태를 설정해준다.

```dart
    // 포스터 데이터를 받아오며 상태를 설정해준다.
    for(int i=0; i<tempMovieData.length; i++){
      // i번째 영화 포스터 객체를 가져온다.
      var tempImage = await getImageData(tempMovieData[i]['movie_poster']);
      // 받아온 이미지 객체를 포스터를 담을 리스트에 담아주고 상태를 설정한다.
      setState(() {
        posterData[i] = tempImage;
      });
    }
```

9. HomeCarouselSlider 객체의 생성자로 영화 데이터와 포스터 데이터를 전달해준다.
```dart
  @override
Widget build(BuildContext context) {
   return Scaffold(
      appBar: HomeTopAppBar(),
      body: ListView(
         children: [
            // 상단 회전 목마
            HomeCarouselSlider(movieData, posterData),
```

10. HomeCarouselSlider 객체에 담을 변수와 생성자를 수정한다.
```dart
class HomeCarouselSlider extends StatefulWidget {

   // 영화 데이터를 담을 상태 변수
   List<Map<String, dynamic>> movieData = [];
   // 영화 포스터를 담을 상태 변수
   List<Image> posterData = [];

   HomeCarouselSlider(this.movieData, this.posterData, {super.key}); 
```

11. 전달받은 포스터 데이터를 설정한다.
```dart

@override
Widget build(BuildContext context) {
   return Container(
      child: Column(
      children: [
        // 회전목마
        CarouselSlider(
          items: widget.posterData,
```

12. hoe_carousel_slider에서 영화 제목을 리스트에 담아준다.
```dart
  @override
Widget build(BuildContext context) {

   // 영화 제목을 담아준다.
   movieTitles.clear();
   for(var map in widget.movieData){
      movieTitles.add(map['movie_title']);
   }
```

13. 영화 정보와 포스터 정보를 HomeCircleSlider에 전달해준다.
```dart
            // 미리 보기 부분
            HomeCircleSlider(movieData, posterData),
```

14. 데이터를 담을 변수를 정의해주고 생성자를 수정한다.
```dart
class HomeCircleSlider extends StatefulWidget {

   // 영화 데이터를 담을 상태 변수
   List<Map<String, dynamic>> movieData = [];
   // 영화 포스터를 담을 상태 변수
   List<Image> posterData = [];

   HomeCircleSlider(this.movieData, this.posterData, {super.key}); 
```

15. 리스트 뷰의 항목 하나를 구성하는 함수의 매개변수를 수정한다.
```dart
// ListView의 항목 하나를 구성하여 반환하는 함수
Widget makeListItem(
   BuildContext context,
   List<Map<String, dynamic>> movieData,
   List<Image> posterData,
   int index
)
```

16. 이미지 데이터를 설정하는 곳을 수정해준다.
```dart
         child: CircleAvatar(
            // 배경 이미지
            backgroundImage: posterData[index].image,
            // 크기
            radius: 48,
         ),
```

17. makeListItem 함수를 호출할 때 영화 데이터, 포스터 데이터, 항목의 순서값을 전달해준다.
```dart
            // 항목 하나를 구성하기 위해 호출하는 함수
            // 여기서 반환하는 위젯이 항목 하나가 된다.
            itemBuilder: (context, index) {
               return makeListItem(
                  context,
                  widget.movieData,
                  widget.posterData,
                  index
               );
            },
```

18. movie_dao에서 지금 뜨는 콘텐츠 정보를 가져오는 메서드를 작성한다.
```dart
// 지금 뜨는 콘텐츠 정보를 가져온다.
Future<List<int>> getHotMovieList() async {
   var querySnapshot = await FirebaseFirestore.instance.collection('hot').get();

   List<int> results = List<int>.from(querySnapshot.docs[0].data()['hot_movie_idx']);

   return results;
}
```

19. 지금 뜨는 콘텐츠 정보를 담을 리스트를 정의해준다.
```dart
class _HomeScreenState extends State<HomeScreen> {

   // 영화 데이터를 담을 상태 변수
   List<Map<String, dynamic>> movieData = [];
   // 영화 포스터를 담을 상태 변수
   List<Image> posterData = [];
   // 지금 뜨는 콘텐츠 정보를 담을 리스트
   List<int> hotMovie = [];
```

20. 지금 뜨는 콘텐츠 정보를 받아와 담아준다.
```dart
  Future<void> getData() async {
   ...
   // 지금 뜨는 콘텐츠 정보를 받아온다.
   hotMovie = await getHotMovieList();
   ...
  }
```

21. HomeBoxSlider 객체에 필요한 데이터를 전달해준다.
```dart
   body: ListView(
      children: [
         // 상단 회전 목마
         HomeCarouselSlider(movieData, posterData),
         Padding(padding: EdgeInsets.only(top: 20)),
         // 미리 보기 부분
         HomeCircleSlider(movieData, posterData),
         Padding(padding: EdgeInsets.only(top: 20)),
         // 지금 뜨는 콘텐츠 부분
         HomeBoxSlider(movieData, posterData, hotMovie),
      ],
   ),
```

22. HomeBoxSlider에 데이터를 담을 변수를 선언해주고 생성자를 통해 받아준다.
```dart
class HomeBoxSlider extends StatefulWidget {

   // 영화 데이터를 담을 상태 변수
   List<Map<String, dynamic>> movieData = [];
   // 영화 포스터를 담을 상태 변수
   List<Image> posterData = [];
   // 지금 뜨는 콘텐츠 정보를 담을 리스트
   List<int> hotMovie = [];

   HomeBoxSlider(this.movieData, this.posterData, this.hotMovie, {super.key});
```

23. 영화 데이터 중에 지금 뜨는 콘텐츠에 해당하는 것만 리스트에 담아준다.
```dart
class _HomeBoxSliderState extends State<HomeBoxSlider> {

   @override
   Widget build(BuildContext context) {

      // 지금 뜨는 컨텐츠 정보 객체만 담는다.
      List<Map<String, dynamic>> hotMovieData = [];
      // 지금 뜨는 컨텐츠의 영화 포스터를 담을 리스트
      List<Image> hotMoviePoster = [];

      // 영화의 수 만큼 반복한다.
      for(int i=0; i<widget.movieData.length; i++){
         // 현재 영화의 번호가 지금 뜨는 컨텐츠 번호에 있다면 리스트에 담아준다.
         if(widget.hotMovie.contains(widget.movieData[i]['movie_idx'])){
            hotMovieData.add(widget.movieData[i]);
            hotMoviePoster.add(widget.posterData[i]);
         }
      }
```

24. makeListItem 함수의 매개 변수를 수정해준다.
```dart
// 리스트뷰의 항목 하나를 구성하는 함수
Widget makeListItem(
        BuildContext context,
        List<Map<String, dynamic>> hotMovieData,
        List<Image> hotMoviePoster,
        int index
        ){
```

25. 항목을 통해 보여줄 이미지를 설정한다.
```dart
      child: Container(
         padding: EdgeInsets.only(right: 10),
         child: hotMoviePoster[index],
      ),
```

26. makeListItem 함수를 호출하는 부분을 수정해준다.
```dart
         itemBuilder: (context, index) {
            return makeListItem(
               context,
               hotMovieData,
               hotMoviePoster,
               index
            );
         },
```

27. 데이터가 없을 때를 대비하여 화면을 변경해준다.
```dart
  @override
Widget build(BuildContext context) {

   if(movieData.isEmpty){
      return Scaffold(
         appBar: HomeTopAppBar(),
      );
   }else{
      return Scaffold(
         appBar: HomeTopAppBar(),
         body: ListView(
            children: [
               // 상단 회전 목마
               HomeCarouselSlider(movieData, posterData),
               Padding(padding: EdgeInsets.only(top: 20)),
               // 미리 보기 부분
               HomeCircleSlider(movieData, posterData),
               Padding(padding: EdgeInsets.only(top: 20)),
               // 지금 뜨는 콘텐츠 부분
               HomeBoxSlider(movieData, posterData, hotMovie),
            ],
         ),
      );
   }
}
```