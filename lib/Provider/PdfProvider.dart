import '../Helper/HttpHelper.dart';
import '../Modal/Pdf.dart';
import '../Modal/subCategory.dart';
import 'package:flutter/foundation.dart';

class PdfProvider with ChangeNotifier {
  final coreUrl = 'https://dhama.lmsmm.com/api';
  late List<Pdf> _pdfMedias = [];
  late List<subCategory> _categories = [];

  List<Pdf> get pdfMedias {
    return [..._pdfMedias];
  }

  List<subCategory> get categories {
    return [..._categories];
  }

  Future<void> fetchPdfMediasBySubCategory(int subCategoryId) async {

    final url = Uri.parse(coreUrl + '/media/sub-category/$subCategoryId');
    final data = await HttpHelper.httpRequestGet(url);
    print(data);
    _pdfMedias = [];

    data!.map((e) => _pdfMedias.add(Pdf.fromJson(e))).toList();

    notifyListeners();
  }

  Future<void> fetchPdfSubCategory() async {
    if (_categories.isNotEmpty) {
      return;
    }

    final data = await HttpHelper.fetchSubCategory(3);
    _categories = [];

    data!.map((e) => _categories.add(subCategory.fromJson(e))).toList();
  }


}
