import 'package:flutter/cupertino.dart';
import 'package:submission_1/data/api/api_service.dart';
import 'package:submission_1/data/model/list_restaurant.dart';

enum ResultState { Loading, NoData, HasData, Error }

class RestaurantProvider extends ChangeNotifier {
  final ApiService apiService;

  RestaurantProvider({required this.apiService}) {
    fetchAllRestaurant();
  }

  Welcome _listRestaurantResult =
      Welcome(count: 1, error: false, message: '', restaurants: []);
  late ResultState _state;
  String _message = '';

  String get message => _message;


  Welcome get result => _listRestaurantResult;

  ResultState get state => _state;

  Future<dynamic> fetchAllRestaurant() async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final restaurants = await apiService.restaurantList();
      if (restaurants.restaurants.isEmpty) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _listRestaurantResult = restaurants;
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }

  // Future<dynamic> fetchSearchRestaurant(String query) async {
  //   try {
  //     _state = ResultState.Loading;
  //     _query = query;
  //     notifyListeners();
  //     final restaurants = await apiService.searchRestaurant(query);
  //     if (restaurants.restaurants.isEmpty) {
  //       _state = ResultState.NoData;
  //       notifyListeners();
  //       return _message = 'Empty Data';
  //     } else {
  //       _state = ResultState.HasData;
  //       notifyListeners();
  //       return _listRestaurantResult = restaurants;
  //     }
  //   } catch (e) {
  //     _state = ResultState.Error;
  //     notifyListeners();
  //     return _message = 'Error --> $e';
  //   }
  // }

}
