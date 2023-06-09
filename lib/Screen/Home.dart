import 'package:dhamma/Helper/fadePageRoute.dart';
import 'package:dhamma/Screen/Audio.dart';
import 'package:dhamma/Screen/Blog.dart';
import 'package:dhamma/Screen/Pdf.dart';
import 'package:dhamma/Screen/SearchScreen.dart';
import 'package:dhamma/Screen/Video.dart';
import 'package:dhamma/Utlis/Logo.dart';
import 'package:flutter/cupertino.dart';

import '../Widgets/blogWidget.dart';
import '../Widgets/pdfWidget.dart';

import '../Widgets/audioWidget.dart';
import '../Widgets/videoWidget.dart';

import '../Provider/NavProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final navProvider = Provider.of<NavProvider>(context);
    final _page = navProvider.page;
    var _activeIndex = navProvider.activeIndex;
    return Scaffold(
      appBar: AppBar(
        leading: const Logo(),
        title: const Text('တရားတော်များ'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  fadePageRoute(
                    'search',
                    const SearchScreen(),
                  ),
                );
              },
              icon: const Icon(CupertinoIcons.search))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            HomeSubWidget(title: 'ရုပ်သံတရားတော်များ', SeeMore: Video()),
            const SizedBox(height: 20),
            const videoWidget(),
            const SizedBox(height: 20),
            HomeSubWidget(title: 'မှတ်တမ်းမှတ်ရာများ', SeeMore: Blog()),
            const SizedBox(height: 20),
            const blogWidget(),
            const SizedBox(height: 20),
            HomeSubWidget(title: 'အသံတရားတော်များ', SeeMore: Audio()),
            const SizedBox(height: 20),
            const audioWidget(),
            const SizedBox(height: 20),
            HomeSubWidget(title: 'တရားစာပေများ', SeeMore: Pdf()),
            const SizedBox(height: 20),
            const pdfWidget(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class HomeSubWidget extends StatelessWidget {
  final String title;
  final Widget SeeMore;
  const HomeSubWidget({super.key, required this.title, required this.SeeMore});

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () {
          Navigator.of(context).push(fadePageRoute('detail', SeeMore));
        },
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
          child: Text(
            'ထပ်ကြည့်ရန်',
            style: TextStyle(fontSize: 10),
          ),
        ),
      )
    ]);
  }
}
