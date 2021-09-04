import 'package:flutter/cupertino.dart';
import 'package:submission_1/data/api/api_service.dart';
import 'package:submission_1/data/model/search_restaurant.dart';

enum ResultState { Loading, NoData, HasData, Error }

class SearchRestaurantProvider extends ChangeNotifier {
  final ApiService apiService;

  SearchRestaurantProvider({required this.apiService}) {
    fetchSearchRestaurant('');
  }

  Search _searchRestaurantResult =
      Search(error: false, founded: 0, restaurants: []);
  late ResultState _state;
  String _message = '';
  String _search = '';

  String get message => _message;

  String get search => _search;

  Search get result => _searchRestaurantResult;

  ResultState get state => _state;

  Future<dynamic> fetchSearchRestaurant(String query) async {
    try {
      _state = ResultState.Loading;
      _search = query;
      notifyListeners();
      final restaurants = await ApiService().searchRestaurant(query);
      if (restaurants.restaurants.isEmpty) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _searchRestaurantResult = restaurants;
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}
