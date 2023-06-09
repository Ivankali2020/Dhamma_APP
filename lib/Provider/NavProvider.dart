
import '../Screen/Video.dart';
import '../Screen/Pdf.dart';

import '../Screen/Home.dart';
import '../Screen/Audio.dart';
import '../Screen/Blog.dart';
import 'package:flutter/material.dart';

class NavProvider with ChangeNotifier {
  late int activeIndex = 0;
  final List<Map<String, dynamic>> page = [
    {
      'name': 'နိဗ္ဗာန်',
      'icon': Icons.home_outlined,
      'active_icon': Icons.home,
      'page': Home(),
      'is_have_music_player' : true,
      'is_load' : false,
    },
    {
      'name': 'အသံ',
      'icon': Icons.music_note_outlined,
      'active_icon': Icons.music_note_sharp,
      'page': Audio(),
      'is_have_music_player' : true,
      'is_load' : false,

    },
    {
      'name': 'ရုပ်ရှင်',
      'icon': Icons.movie_outlined,
      'active_icon': Icons.movie,
      'page': Video(),
      'is_have_music_player' : false,
      'is_load' : false,

    },
     {
      'name': 'စာပေ',
      'icon': Icons.picture_as_pdf_outlined,
      'active_icon': Icons.padding_sharp,
      'page': Pdf(),
      'is_load' : false,
      'is_have_music_player' : false,
    },

     {
      'name': 'မှတ်တမ်း',
      'icon': Icons.book,
      'active_icon': Icons.book_sharp,
      'page': Blog(),
      'is_have_music_player' : false,
      'is_load' : false,

    }
  ];

  void changeIndex(index) {
    print(index);
    activeIndex = index;
    notifyListeners();
  }
}
