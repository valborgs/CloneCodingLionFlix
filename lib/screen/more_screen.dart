import 'package:flutter/material.dart';
import 'package:flutter03_lionflix/widget/more_list_view.dart';
import 'package:flutter03_lionflix/widget/more_top_app_bar.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({super.key});

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MoreTopAppBar(),
      body: Container(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
        child: const MoreListView(),
      ),
    );
  }
}
