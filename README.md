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