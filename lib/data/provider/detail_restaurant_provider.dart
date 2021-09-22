import 'package:flutter/cupertino.dart';
import 'package:submission_3/data/api/api_service.dart';
import 'package:submission_3/data/model/detail_restaurant_model.dart';
import 'package:submission_3/ui/widget/empty_data.dart';
import 'package:submission_3/ui/widget/error.dart';
import 'package:submission_3/utils/result_state.dart';

class DetailRestaurantProvider extends ChangeNotifier {
  final ApiService apiService;
  final String id;

  DetailRestaurantProvider({required this.apiService, required this.id}) {
    _fetchDetailRestaurant(id);
  }

  late DetailRestaurantResult _result;
  late ResultState _state;
  Widget _widget = EmptyData();

  DetailRestaurantResult get result => _result;
  ResultState get state => _state;
  Widget get widget => _widget;

  Future<dynamic> _fetchDetailRestaurant(String id) async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final restaurant = await apiService.detailRestaurant(id);
      if (restaurant.restaurant == null) {
        _state = ResultState.NoData;
        notifyListeners();
        return _widget = EmptyData();
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _result = restaurant;
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _widget = ErrorInformation();
    }
  }
}
