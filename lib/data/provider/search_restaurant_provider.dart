import 'package:flutter/cupertino.dart';
import 'package:submission_3/data/api/api_service.dart';
import 'package:submission_3/data/model/search_restaurant_model.dart';
import 'package:submission_3/ui/widget/error.dart';
import 'package:submission_3/ui/widget/not_found.dart';
import 'package:submission_3/utils/result_state.dart';

class SearchRestaurantProvider extends ChangeNotifier {
  final ApiService apiService;

  SearchRestaurantProvider({required this.apiService}) {
    fetchFoundRestaurant('');
  }

  SearchRestaurantResult _searchRestaurantResult =
      SearchRestaurantResult(error: false, founded: 0, restaurants: []);
  late Widget _widget;
  late ResultState _state;

  Widget get widget => _widget;
  SearchRestaurantResult get result => _searchRestaurantResult;
  ResultState get state => _state;

  Future<dynamic> fetchFoundRestaurant(String query) async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final foundRestaurant = await apiService.searchRestaurant(query);
      if (foundRestaurant.restaurants.isEmpty) {
        _state = ResultState.NoData;
        notifyListeners();
        return _widget = NotFound();
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _searchRestaurantResult = foundRestaurant;
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _widget = ErrorInformation();
    }
  }
}
