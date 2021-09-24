import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:submission_3/data/model/detail_restaurant_model.dart';
import 'package:submission_3/data/model/restaurant_model.dart';
import 'package:submission_3/data/model/search_restaurant_model.dart';

class ApiService {
  static final String _baseUrl = 'https://restaurant-api.dicoding.dev/';

  restaurantList() async {
    final response = await http.get(Uri.parse(_baseUrl + 'list'));

    if (response.statusCode == 200) {
      return RestaurantResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load restaurant list');
    }
  }

  searchRestaurant(String query) async {
    final response = await http.get(Uri.parse(_baseUrl + 'search?q=' + query));

    if (response.statusCode == 200) {
      return SearchRestaurantResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Not Found');
    }
  }

  detailRestaurant(String id) async {
    final response = await http.get(Uri.parse(_baseUrl + 'detail/' + id));

    if (response.statusCode == 200) {
      return DetailRestaurantResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Not Found');
    }
  }
}
