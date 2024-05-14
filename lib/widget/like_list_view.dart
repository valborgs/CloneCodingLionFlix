import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter03_lionflix/dao/movie_dao.dart';
import 'package:flutter03_lionflix/screen/detail_screen.dart';

class LikeListView extends StatefulWidget {

  // 영화 데이터를 담을 상태 변수
  List<Map<String, dynamic>> movieData;
  // 영화 포스터를 담을 상태 변수
  List<Image> posterData;
  // 찜한 영화 번호를 담을 상태 변수
  List<int> likeMovie;

  LikeListView(this.movieData, this.posterData, this.likeMovie, {super.key});

  @override
  State<LikeListView> createState() => _LikeListViewState();
}

class _LikeListViewState extends State<LikeListView> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.movieData.length,
      itemBuilder: (context, index) => makeListItem(widget.movieData, widget.posterData, index),
    );
  }

  // 리스트 뷰의 항목 하나를 구성하는 함수
  Widget makeListItem(List<Map<String, dynamic>> movieData, List<Image> posterData, int index){
    return Container(
      padding: const EdgeInsets.only(top: 10),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => DetailScreen(movieData[index], posterData[index]),
              fullscreenDialog: true,
            )
          );
        },
        child: Row(
          // 양쪽에 하나씩 배치되도록 한다.
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child:Row(
                children: [
                  Image(image: widget.posterData[index].image, width: 100),
                  const Padding(padding: EdgeInsets.only(right: 10)),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.movieData[index]['movie_title'], overflow: TextOverflow.ellipsis),
                        Text('출연진 : ${widget.movieData[index]['movie_actor']}', overflow: TextOverflow.ellipsis),
                        Text('제작진 : ${widget.movieData[index]['movie_director']}', overflow: TextOverflow.ellipsis),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
                onPressed: () {
                  // index번째 항목을 제거한다.
                  setState(() {
                    widget.movieData.removeAt(index);
                    widget.posterData.removeAt(index);
                    widget.likeMovie.removeAt(index);
                  });
                  // 찜 데이터를 새롭게 저장한다.
                  setLikeMovie(widget.likeMovie);
                },
                icon: const Icon(Icons.delete)
            ),
          ],
        ),
      ),
    );
  }

}