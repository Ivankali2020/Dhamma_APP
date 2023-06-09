class Media {
  Media({
    required this.id,
    required this.name,
     this.audio,
     this.duration,
     this.video,
     this.pdf,
     this.description,
     this.thumbnail,
    required this.category,
    required this.categoryId,
    required this.subCategory,
    required this.subCategoryId,
     this.photos,
  });
  late final int id;
  late final String name;
  late final String? audio;
  late final String? duration;
  late final String? video;
  late final String? pdf;
  late final String? description;
  late final String? thumbnail;
  late final String category;
  late final int categoryId;
  late final String subCategory;
  late final int subCategoryId;
  late final List<dynamic>? photos;

  Media.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    audio = json['audio'];
    duration = json['duration'];
    video = json['video'];
    pdf = json['pdf'];
    description = json['description'];
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
    _data['audio'] = audio;
    _data['duration'] = duration;
    _data['video'] = video;
    _data['pdf'] = pdf;
    _data['description'] = description;
    _data['thumbnail'] = thumbnail;
    _data['category'] = category;
    _data['category_id'] = categoryId;
    _data['sub_category'] = subCategory;
    _data['sub_category_id'] = subCategoryId;
    _data['photos'] = photos;
    return _data;
  }
}