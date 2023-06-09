import '../Helper/HttpHelper.dart';
import '../Modal/BLog.dart';
import '../Modal/Pdf.dart';
import '../Modal/subCategory.dart';
import 'package:flutter/foundation.dart';

class BlogProvider with ChangeNotifier {
  final coreUrl = 'https://dhama.lmsmm.com/api';
  late List<Blog> _blogMedias = [];
  late List<subCategory> _categories = [];

  List<Blog> get blogMedias {
    return [..._blogMedias];
  }

  List<subCategory> get categories {
    return [..._categories];
  }

  Future<void> fetchBlogMediasBySubCategory(int subCategoryId) async {

    final url = Uri.parse(coreUrl + '/media/sub-category/$subCategoryId');
    final data = await HttpHelper.httpRequestGet(url);
    print(data);
    _blogMedias = [];
    
    data!.map((e) => _blogMedias.add(Blog.fromJson(e))).toList();

    notifyListeners();
  }

  Future<void> fetchBlogSubCategory() async {
    if (_categories.isNotEmpty) {
      return;
    }

    final data = await HttpHelper.fetchSubCategory(4);
    _categories = [];

    data!.map((e) => _categories.add(subCategory.fromJson(e))).toList();
  }


}
