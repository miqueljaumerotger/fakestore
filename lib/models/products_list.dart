import 'models.dart';

class ProductsList {
  int id;
  String title;
  double price;
  String description;
  Category category;
  String? image; // Ahora puede ser null
  Rating rating;

  ProductsList({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    this.image,
    required this.rating,
  });

  factory ProductsList.fromJson(String str) => ProductsList.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProductsList.fromMap(Map<String, dynamic> json) => ProductsList(
        id: json["id"],
        title: json["title"],
        price: json["price"]?.toDouble() ?? 0.0,
        description: json["description"],
        category: categoryValues.map[json["category"]]!,
        image: json["image"],
        rating: Rating.fromMap(json["rating"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        "price": price,
        "description": description,
        "category": categoryValues.reverse[category],
        "image": image,
        "rating": rating.toMap(),
      };

  // Getter para manejar imagen por defecto
  String get safeImage => image ?? 'https://i.sstatic.net/GNhxO.png';
}


enum Category {
    ELECTRONICS,
    JEWELERY,
    MEN_S_CLOTHING,
    WOMEN_S_CLOTHING
}

final categoryValues = EnumValues({
    "electronics": Category.ELECTRONICS,
    "jewelery": Category.JEWELERY,
    "men's clothing": Category.MEN_S_CLOTHING,
    "women's clothing": Category.WOMEN_S_CLOTHING
});

class Rating {
    double rate;
    int count;

    Rating({
        required this.rate,
        required this.count,
    });

    factory Rating.fromJson(String str) => Rating.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Rating.fromMap(Map<String, dynamic> json) => Rating(
        rate: json["rate"]?.toDouble(),
        count: json["count"],
    );

    Map<String, dynamic> toMap() => {
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
