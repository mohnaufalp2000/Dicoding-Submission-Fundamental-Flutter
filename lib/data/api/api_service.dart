import 'dart:convert';
import 'package:submission_1/data/model/detail_restaurant.dart';
import 'package:submission_1/data/model/list_restaurant.dart';
import 'package:http/http.dart' as http;
import 'package:submission_1/data/model/search_restaurant.dart';

class ApiService {
  static final String _baseUrl = 'https://restaurant-api.dicoding.dev/';

  Future<Welcome> restaurantList() async {
    final response = await http.get(Uri.parse(_baseUrl + 'list'));

    if (response.statusCode == 200) {
      return Welcome.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load Restaurant List');
    }
  }

  Future<Detail> detailRestaurant(String id) async {
    final response = await http.get(Uri.parse(_baseUrl + 'detail/' + id));

    if (response.statusCode == 200) {
      return Detail.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load Restaurant Detail');
    }
  }

  Future<Search> searchRestaurant(String query) async {
    final response = await http.get(Uri.parse(_baseUrl + 'search?q=' + query));

    if (response.statusCode == 200) {
      return Search.fromJson(json.decode(response.body));
    } else {
      throw Exception('Not Found');
    }
  }
}
