import 'dart:convert';

Detail detailFromJson(String str) => Detail.fromJson(json.decode(str));

class Detail {
  Detail({
    required this.error,
    required this.message,
    required this.restaurant,
  });

  late bool error;
  late String message;
  late Restaurant restaurant;

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
        error: json["error"],
        message: json["message"],
        restaurant: Restaurant.fromJson(json["restaurant"]),
      );
}

class Restaurant {
  Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.city,
    required this.address,
    required this.pictureId,
    required this.categories,
    required this.menus,
    required this.rating,
    required this.customerReviews,
  });

  late String id;
  late String name;
  late String description;
  late String city;
  late String address;
  late String pictureId;
  late List<Category> categories;
  late Menus menus;
  late double rating;
  late List<CustomerReview> customerReviews;

  factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        city: json["city"],
        address: json["address"],
        pictureId: json["pictureId"],
        categories: List<Category>.from(
            json["categories"].map((x) => Category.fromJson(x))),
        menus: Menus.fromJson(json["menus"]),
        rating: json["rating"].toDouble(),
        customerReviews: List<CustomerReview>.from(
            json["customerReviews"].map((x) => CustomerReview.fromJson(x))),
      );

}

class Category {
  Category({
    required this.name,
  });

  late String name;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
      };
}

class CustomerReview {
  CustomerReview({
    required this.name,
    required this.review,
    required this.date,
  });

  late String name;
  late String review;
  late Date? date;

  factory CustomerReview.fromJson(Map<String, dynamic> json) => CustomerReview(
        name: json["name"],
        review: json["review"],
        date: dateValues.map[json["date"]],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "review": review,
        "date": dateValues.reverse[date],
      };
}

enum Date { THE_13_NOVEMBER_2019, THE_23_AGUSTUS_2021 }

final dateValues = EnumValues({
  "13 November 2019": Date.THE_13_NOVEMBER_2019,
  "23 Agustus 2021": Date.THE_23_AGUSTUS_2021
});

class Menus {
  Menus({
    required this.foods,
    required this.drinks,
  });

  late List<Category> foods;
  late List<Category> drinks;

  factory Menus.fromJson(Map<String, dynamic> json) => Menus(
        foods:
            List<Category>.from(json["foods"].map((x) => Category.fromJson(x))),
        drinks: List<Category>.from(
            json["drinks"].map((x) => Category.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "foods": List<dynamic>.from(foods.map((x) => x.toJson())),
        "drinks": List<dynamic>.from(drinks.map((x) => x.toJson())),
      };
}

class EnumValues<T> {
  late Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
