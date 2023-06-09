
class Audio {
  Audio({
    required this.id,
    required this.name,
    required this.audio,
    required this.duration,
    required this.category,
    required this.categoryId,
    required this.subCategory,
    required this.subCategoryId,
  });
  late final int id;
  late final String name;
  late final String audio;
  late final String duration;
  late final String category;
  late final int categoryId;
  late final String subCategory;
  late final int subCategoryId;

  late bool isPlaying = false;

  void pause() {
    isPlaying = false;
  }

  void play() {
    isPlaying = true;
  }

  Audio.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    audio = json['audio'];
    duration = json['duration'];
    category = json['category'];
    categoryId = json['category_id'];
    subCategory = json['sub_category'];
    subCategoryId = json['sub_category_id'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['audio'] = audio;
    _data['duration'] = duration;
    _data['category'] = category;
    _data['category_id'] = categoryId;
    _data['sub_category'] = subCategory;
    _data['sub_category_id'] = subCategoryId;
    return _data;
  }
}
