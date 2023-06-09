class Video {
  Video({
    required this.id,
    required this.name,
    required this.video,
    required this.thumbnail,
    required this.category,
    required this.categoryId,
    required this.subCategory,
    required this.subCategoryId,
    required this.photos,
  });
  late final int id;
  late final String name;
  late final String video;
  late final String thumbnail;
  late final String category;
  late final int categoryId;
  late final String subCategory;
  late final int subCategoryId;
  late final List<dynamic> photos;

  Video.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    video = json['video'];
    thumbnail = json['thumbnail'];
    category = json['category'];
    categoryId = json['category_id'];
    subCategory = json['sub_category'];
    subCategoryId = json['sub_category_id'];
    photos = List.castFrom<dynamic, dynamic>(json['photos']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['video'] = video;
    _data['thumbnail'] = thumbnail;
    _data['category'] = category;
    _data['category_id'] = categoryId;
    _data['sub_category'] = subCategory;
    _data['sub_category_id'] = subCategoryId;
    _data['photos'] = photos;
    return _data;
  }
}