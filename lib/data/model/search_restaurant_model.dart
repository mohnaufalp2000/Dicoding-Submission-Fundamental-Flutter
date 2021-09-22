import 'dart:convert';

import 'package:submission_3/data/model/restaurant_model.dart';

SearchRestaurantResult  searchRestaurantResultFromJson(String str) => SearchRestaurantResult.fromJson(json.decode(str));

String searchRestaurantResultToJson(SearchRestaurantResult  data) => json.encode(data.toJson());

class SearchRestaurantResult {
  SearchRestaurantResult ({
    required this.error,
    required this.founded,
    required this.restaurants,
  });

  late bool error;
  late int founded;
  late List<Restaurant> restaurants;

  factory SearchRestaurantResult.fromJson(Map<String, dynamic> json) => SearchRestaurantResult(
        error: json["error"],
        founded: json["founded"],
        restaurants: List<Restaurant>.from((json["restaurants"] as List)
            .map((e) => Restaurant.fromJson(e))
            .where((restaurant) =>
                restaurant.id != null &&
                restaurant.name != null &&
                restaurant.description != null &&
                restaurant.pictureId != null &&
                restaurant.city != null &&
                restaurant.rating != null)),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "founded": founded,
        "restaurants": List<dynamic>.from(restaurants.map((x) => x.toJson())),
      };
}

