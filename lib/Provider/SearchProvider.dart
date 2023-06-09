import 'package:dhamma/Helper/HttpHelper.dart';
import 'package:dhamma/Modal/Media.dart';
import 'package:flutter/material.dart';

class SearchProvider with ChangeNotifier {
  List<Media> _searchMedias = [];

  List<Media> get searchMedias {
    return [..._searchMedias];
  }

  late bool isLoading = false;
  late int page = 1;
  late bool noDataLoad = false;

  Future<void> fetchMedias(String keyword) async {
    // page = 0;
    isLoading = true;
    final url = Uri.parse(HttpHelper().coreUrl + '/medias?keyword=$keyword');
    final data = await HttpHelper.httpRequestGet(url);

    _searchMedias = [];

    if (data != null) {
      data.map((e) => _searchMedias.add(Media.fromJson(e))).toList();
      page++;
    }

    isLoading = false;
    noDataLoad = false;

    notifyListeners();
  }

  Future<void> loadMoreMedias(String keyword) async {
    if (noDataLoad) {
      return;
    }
    isLoading = true;
    notifyListeners();
    final url =
        Uri.parse(HttpHelper().coreUrl + '/medias?keyword=$keyword&page=$page');
    final data = await HttpHelper.httpRequestGet(url);
    if (data != null) {
      if (data.isNotEmpty) {
        data.map((e) => _searchMedias.add(Media.fromJson(e))).toList();
        page++;
      } else {
        noDataLoad = true;
        notifyListeners();
      }
    } else {
      noDataLoad = true;
      notifyListeners();
    }

    isLoading = false;
    notifyListeners();
  }
}
