class subCategory {
  subCategory({
    required this.name,
    required this.id,
    required this.type,
    required this.mediasCount,
  });
  late final String name;
  late final int id;
  late final String type;
  late final int mediasCount;

  subCategory.fromJson(Map<String, dynamic> json){
    name = json['name'];
    id = json['id'];
    type = json['type'];
    mediasCount = json['medias_count'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['name'] = name;
    _data['id'] = id;
    _data['type'] = type;
    _data['medias_count'] = mediasCount;
    return _data;
  }
}