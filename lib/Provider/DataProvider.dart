import 'dart:convert';

import '../Modal/BLog.dart';
import '../Modal/Pdf.dart';

import '../Modal/Video.dart';
import '../Modal/Audio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DataProvider with ChangeNotifier {
  final coreUrl = 'https://dhama.lmsmm.com/api';
  late List<Audio> _audioMedias = [];
  late List<Video> _videoMedias = [];
  late List<Pdf> _pdfMedias = [];
  late List<Blog> _blogMedias = [];

  List<Audio> get audioMedias {
    return [..._audioMedias];
  }

  List<Video> get videoMedias {
    return [..._videoMedias];
  }

  List<Pdf> get pdfMedias {
    return [..._pdfMedias];
  }

  List<Blog> get blogMedias {
    return [..._blogMedias];
  }

  Future<void> fetchAudioMedias() async {
    if (_audioMedias.isNotEmpty) {
      return;
    }
    final url = Uri.parse(coreUrl + '/category/1/media');
    final data = await httpRequestGet(url);
    _audioMedias = [];

    if (data != null) {
      data.map((e) => _audioMedias.add(Audio.fromJson(e))).toList();
    }
    notifyListeners();
  }

  Future<void> fetchVideoMedias() async {
    if (_videoMedias.isNotEmpty) {
      return;
    }
    final url = Uri.parse(coreUrl + '/category/2/media');
    final data = await httpRequestGet(url);
    _videoMedias = [];

    if (data != null) {
      data.map((e) => _videoMedias.add(Video.fromJson(e))).toList();
    }
    notifyListeners();
  }

  Future<void> fetchPdfMedias() async {
    if (_pdfMedias.isNotEmpty) {
      return;
    }
    final url = Uri.parse(coreUrl + '/category/3/media');
    final data = await httpRequestGet(url);
    _pdfMedias = [];

    if (data != null) {
      data.map((e) => _pdfMedias.add(Pdf.fromJson(e))).toList();
    }

    notifyListeners();
  }

  Future<void> fetchBlogMedias() async {
    if (_blogMedias.isNotEmpty) {
      return;
    }
    final url = Uri.parse(coreUrl + '/category/4/media');
    final data = await httpRequestGet(url);
    _blogMedias = [];

    if (data != null) {
      data.map((e) => _blogMedias.add(Blog.fromJson(e))).toList();
    }

    notifyListeners();
  }

  Future<List?> httpRequestGet(Uri url) async {
    try {
      final data = await http.get(url);

      if (data.statusCode == 200) {
        final jsonData = jsonDecode(data.body);

        if (jsonData['data'] != null) {
          return jsonData['data'];
        }
        return null;
      }

      print(data.body);
    } catch (err) {
      return null;
      print(err);
    }
  }
}
