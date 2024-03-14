import 'package:hive/hive.dart';
import 'dart:convert';
part 'products.g.dart';

List<Product> productFromJson(String str) => List<Product>.from(json.decode(str).map((x) => Product.fromJson(x)));

String productToJson(List<Product> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
@HiveType(typeId: 1)
class Product extends HiveObject {
  @HiveField(1)
  int? id;
  @HiveField(2)
  String? title;
  @HiveField(3)
  double? price;
  @HiveField(4)
  String? description;
  @HiveField(5)
  Category? category;
  @HiveField(6)
  String? image;
  @HiveField(7)
  Rating? rating;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    required this.rating,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    title: json["title"],
    price: json["price"]?.toDouble(),
    description: json["description"],
    category: categoryValues.map[json["category"]]!,
    image: json["image"],
    rating: Rating.fromJson(json["rating"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "price": price,
    "description": description,
    "category": categoryValues.reverse[category],
    "image": image,
    "rating": rating!.toJson(),
  };
}
@HiveType(typeId: 2)
enum Category {
  @HiveField(1)
  ELECTRONICS,
  @HiveField(2)
  JEWELERY,
  @HiveField(3)
  MEN_S_CLOTHING,
  @HiveField(4)
  WOMEN_S_CLOTHING
}

final categoryValues = EnumValues({
  "electronics": Category.ELECTRONICS,
  "jewelery": Category.JEWELERY,
  "men's clothing": Category.MEN_S_CLOTHING,
  "women's clothing": Category.WOMEN_S_CLOTHING
});
@HiveType(typeId: 3)
class Rating {
  @HiveField(1)
  double? rate;
  @HiveField(2)
  int? count;

  Rating({
    required this.rate,
    required this.count,
  });

  factory Rating.fromJson(Map<String, dynamic> json) => Rating(
    rate: json["rate"]?.toDouble(),
    count: json["count"],
  );

  Map<String, dynamic> toJson() => {
    "rate": rate,
    "count": count,
  };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
