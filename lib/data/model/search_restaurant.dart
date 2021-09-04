import 'dart:convert';

Search searchFromJson(String str) => Search.fromJson(json.decode(str));

class Search {
    Search({
        required this.error,
        required this.founded,
        required this.restaurants,
    });

    late bool error;
    late int founded;
    late List<SearchRestaurant> restaurants;

    factory Search.fromJson(Map<String, dynamic> json) => Search(
        error: json["error"],
        founded: json["founded"],
        restaurants: List<SearchRestaurant>.from(json["restaurants"].map((x) => SearchRestaurant.fromJson(x))),
    );

}

class SearchRestaurant {
    SearchRestaurant({
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

    factory SearchRestaurant.fromJson(Map<String, dynamic> json) => SearchRestaurant(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        pictureId: json["pictureId"],
        city: json["city"],
        rating: json["rating"].toDouble(),
    );

}
