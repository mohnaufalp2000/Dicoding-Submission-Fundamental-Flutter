import 'package:flutter/cupertino.dart';
import 'package:submission_1/data/api/api_service.dart';
import 'package:submission_1/data/model/detail_restaurant.dart';

enum ResultState { Loading, NoData, HasData, Error }

class DetailRestaurantProvider extends ChangeNotifier {
  final ApiService apiService;
  final String restaurantId;

  DetailRestaurantProvider(
      {required this.apiService, required this.restaurantId}) {
    _fetchDetailRestaurant(restaurantId);
  }

  late Detail _restaurantResult;
  late ResultState _state;
  String _message = '';

  String get message => _message;

  Detail get result => _restaurantResult;

  ResultState get state => _state;

  Future<dynamic> _fetchDetailRestaurant(String id) async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final restaurants = await apiService.detailRestaurant(id);
      if (restaurants.restaurant == null) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _restaurantResult = restaurants;
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}
