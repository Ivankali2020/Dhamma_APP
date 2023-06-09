import '../Helper/HttpHelper.dart';
import '../Modal/Video.dart';
import '../Modal/subCategory.dart';
import 'package:flutter/foundation.dart';

class VideoProvider with ChangeNotifier {
  final coreUrl = 'https://dhama.lmsmm.com/api';
  late List<Video> _videoMedias = [];
  late List<subCategory> _categories = [];

  List<Video> get VideoMedias {
    return [..._videoMedias];
  }

  List<subCategory> get categories {
    return [..._categories];
  }

  Future<void> fetchVideoMediasBySubCategory(int subCategoryId) async {

    final url = Uri.parse(coreUrl + '/media/sub-category/$subCategoryId');
    final data = await HttpHelper.httpRequestGet(url);
    print(data);
    _videoMedias = [];

    data!.map((e) => _videoMedias.add(Video.fromJson(e))).toList();

    notifyListeners();
  }

  Future<void> fetchVideoSubCategory() async {
    if (_categories.isNotEmpty) {
      return;
    }

    final data = await HttpHelper.fetchSubCategory(2);
    _categories = [];

    data!.map((e) => _categories.add(subCategory.fromJson(e))).toList();
  }


}
