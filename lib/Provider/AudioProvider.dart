import '../Helper/HttpHelper.dart';
import '../Modal/Audio.dart';
import '../Modal/subCategory.dart';
import 'package:flutter/foundation.dart';

class AudioProvider with ChangeNotifier {
  final coreUrl = 'https://dhama.lmsmm.com/api';
  late List<Audio> _audioMedias = [];
  late List<subCategory> _categories = [];

  List<Audio> get audioMedias {
    return [..._audioMedias];
  }

  List<subCategory> get categories {
    return [..._categories];
  }

  Future<void> fetchAudioMediasBySubCategory(int subCategoryId) async {

    final url = Uri.parse(coreUrl + '/media/sub-category/$subCategoryId');
    final data = await HttpHelper.httpRequestGet(url);
    print(data);
    _audioMedias = [];
    if(data != null){
      data.map((e) => _audioMedias.add(Audio.fromJson(e))).toList();
    }

    notifyListeners();
  }

  Future<void> fetchAudioSubCategory() async {
    if (_categories.isNotEmpty) {
      return;
    }

    final data = await HttpHelper.fetchSubCategory(1);
    _categories = [];
    if(data != null){
      data.map((e) => _categories.add(subCategory.fromJson(e))).toList();
    }
  }


}
