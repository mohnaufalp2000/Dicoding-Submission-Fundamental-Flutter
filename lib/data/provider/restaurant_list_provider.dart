import 'package:flutter/cupertino.dart';
import 'package:submission_3/data/api/api_service.dart';
import 'package:submission_3/data/model/restaurant_model.dart';
import 'package:submission_3/ui/widget/empty_data.dart';
import 'package:submission_3/ui/widget/error.dart';
import 'package:submission_3/utils/result_state.dart';

class RestaurantProvider extends ChangeNotifier {
  final ApiService apiService;

  RestaurantProvider({required this.apiService}) {
    fetchAllRestaurant();
  }

  RestaurantResult _restaurantResult =
      RestaurantResult(count: 1, error: false, message: '', restaurants: []);
  late Widget _widget;
  late ResultState _state;

  Widget get widget => _widget;
  RestaurantResult get result => _restaurantResult;
  ResultState get state => _state;

  Future<dynamic> fetchAllRestaurant() async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final restaurants = await apiService.restaurantList();
      if (restaurants.restaurants.isEmpty) {
        _state = ResultState.NoData;
        notifyListeners();
        return _widget =  EmptyData();
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _restaurantResult = restaurants;
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _widget = ErrorInformation();
    }
  }
}
