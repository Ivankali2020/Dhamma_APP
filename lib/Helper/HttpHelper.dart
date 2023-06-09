import 'dart:convert';

import 'package:http/http.dart' as http;

class HttpHelper {
  final coreUrl = 'https://dhama.lmsmm.com/api';

  static Future<List?> httpRequestGet(Uri url) async {
    try {
      final data = await http.get(url, headers: {
        'Accept': 'application/json'
      });

      if (data.statusCode == 200) {
        final jsonData = jsonDecode(data.body);
        if (jsonData['data'] != null) {
          return jsonData['data'];
        }
        return [];
      }

    } catch (err) {
      print(err);
      return [];
    }
  }

  static Future<List<dynamic>?> fetchSubCategory(int categoryId) async {
    final url = Uri.parse(HttpHelper().coreUrl + '/sub-category/${categoryId}');
    final data = await HttpHelper.httpRequestGet(url);

    return data;
  }
}
