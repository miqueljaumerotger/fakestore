import 'models.dart';

/**
 * Aquesta implementació defineix el model de dades per gestionar productes i les seves categories,
 * juntament amb les valoracions associades. Inclou classes, enumeracions i funcionalitats per a
 * convertir dades entre formats JSON i objectes de Dart, així com altres utilitats.
 *
 * Components principals:
 *
 * 1. **Classe ProductsList**:
 *    - Representa un producte amb atributs com ID, títol, preu, descripció, categoria,
 *      imatge i valoració.
 *    - Constructor amb paràmetres requerits i opcional (`image` pot ser null).
 *    - Mètodes de fàbrica `fromJson` i `fromMap` per crear instàncies a partir de dades JSON o mapes.
 *    - Mètode `toJson` per convertir l'objecte a un string JSON.
 *    - Mètode `toMap` per convertir l'objecte a un mapa.
 *    - Getter `safeImage` que retorna una imatge per defecte si l'atribut `image` és null.
 *
 * 2. **Enumeració Category**:
 *    - Defineix les categories possibles dels productes: ELECTRONICS, JEWELERY, MEN_S_CLOTHING, i WOMEN_S_CLOTHING.
 *
 * 3. **Classe Rating**:
 *    - Representa la valoració d'un producte amb atributs `rate` (qualificació mitjana) i `count` (nombre de valoracions).
 *    - Mètodes de fàbrica `fromJson` i `fromMap` per convertir dades JSON/mapes a instàncies.
 *    - Mètode `toJson` per convertir l'objecte a JSON.
 *    - Mètode `toMap` per convertir l'objecte a un mapa.
 *
 * 4. **Classe EnumValues<T>**:
 *    - Gestiona la conversió entre strings i enumeracions (mapes i reverse mapes).
 *    - Constructor per inicialitzar el mapa directe.
 *    - Getter `reverse` que crea un mapa invers per a les conversions en sentit contrari.
 *
 * Funcionalitats destacades:
 * - Gestió de valors per defecte per atributs opcionals (`image`).
 * - Conversió eficient entre objectes, JSON i mapes per facilitar la interoperabilitat amb serveis externs.
 */

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
