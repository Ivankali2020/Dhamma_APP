class Pdf {
  Pdf({
    required this.id,
    required this.name,
    required this.pdf,
    required this.category,
    required this.categoryId,
    required this.subCategory,
    required this.subCategoryId,
    required this.thumbnail,

  });
  late final int id;
  late final String name;
  late final String pdf;
  late final String category;
  late final int categoryId;
  late final String subCategory;
  late final int subCategoryId;
  late final String thumbnail;


  late bool isPlaying = false;

  void pause() {
    isPlaying = !isPlaying;
  }

  Pdf.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    pdf = json['pdf'];
    category = json['category'];
    categoryId = json['category_id'];
    subCategory = json['sub_category'];
    subCategoryId = json['sub_category_id'];
    thumbnail = json['thumbnail'];

  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['pdf'] = pdf;
    _data['category'] = category;
    _data['category_id'] = categoryId;
    _data['sub_category'] = subCategory;
    _data['sub_category_id'] = subCategoryId;
    _data['thumbnail'] = thumbnail;
    return _data;
  }
}
