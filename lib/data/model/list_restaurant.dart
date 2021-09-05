import 'dart:convert';

Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));

class Welcome {
  Welcome({
    required this.error,
    required this.message,
    required this.count,
    required this.restaurants,
  });

  late bool error;
  late String message;
  late int count;
  late List<Restaurant> restaurants;

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
        error: json["error"],
        message: json["message"],
        count: json["count"],
        restaurants: List<Restaurant>.from(
            (json["restaurants"] as List)
            .map((x) => Restaurant.fromJson(x))
            .where((restaurant) =>
              restaurant.id != null &&
              restaurant.name != null &&
              restaurant.description != null &&
              restaurant.pictureId != null &&
              restaurant.city != null &&
              restaurant.rating != null
            )),
      );
}

class Restaurant {
  Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
  });

  late String id;
  late String name;
  late String description;
  late String pictureId;
  late String city;
  late double rating;

  factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        pictureId: json["pictureId"],
        city: json["city"],
        rating: json["rating"].toDouble(),
      );

}
