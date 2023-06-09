class Product {
  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.discountPrice,
    required this.discountPercentage,
    required this.stock,
    required this.unit,
    required this.detail,
    required this.categoryName,
    required this.categoryId,
    required this.brandName,
    required this.brandId,
    required this.photos,
  });
  late final int id;
  late final String name;
  late final int price;
  late final int discountPrice;
  late final int discountPercentage;
  late final int stock;
  late final String unit;
  late final String detail;
  late final String categoryName;
  late final int categoryId;
  late final String brandName;
  late final int brandId;
  late final List<String> photos;

  Product.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    price = json['price'];
    discountPrice = json['discount_price'];
    discountPercentage = json['discount_percentage'];
    stock = json['stock'];
    unit = json['unit'];
    detail = json['detail'];
    categoryName = json['category_name'];
    categoryId = json['category_id'];
    brandName = json['brand_name'];
    brandId = json['brand_id'];
    photos = List.castFrom<dynamic, String>(json['photos']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['price'] = price;
    _data['discount_price'] = discountPrice;
    _data['discount_percentage'] = discountPercentage;
    _data['stock'] = stock;
    _data['unit'] = unit;
    _data['detail'] = detail;
    _data['category_name'] = categoryName;
    _data['category_id'] = categoryId;
    _data['brand_name'] = brandName;
    _data['brand_id'] = brandId;
    _data['photos'] = photos;
    return _data;
  }
}