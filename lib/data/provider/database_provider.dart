import 'package:flutter/cupertino.dart';
import 'package:submission_3/data/database/database_helper.dart';
import 'package:submission_3/data/model/restaurant_model.dart';
import 'package:submission_3/ui/widget/empty_data.dart';
import 'package:submission_3/ui/widget/error.dart';
import 'package:submission_3/utils/result_state.dart';

class DatabaseProvider extends ChangeNotifier {
  final DatabaseHelper databaseHelper;

  DatabaseProvider({required this.databaseHelper}) {
    _getFavorite();
  }

  ResultState _state = ResultState.NoData;
  ResultState get state => _state;

  Widget _widget = EmptyData();
  Widget get widget => _widget;
  
  List<Restaurant> _favorite = [];
  List<Restaurant> get favorite => _favorite;

  void _getFavorite() async {
    _favorite = await databaseHelper.getFavorite();
    if (_favorite.length > 0) {
      _state = ResultState.HasData;
    } else {
      _state = ResultState.NoData;
      _widget = EmptyData();
    }
    notifyListeners();
  }

  void addFavorite(Restaurant restaurant) async {
    try {
      await databaseHelper.insertBookmark(restaurant);
      _getFavorite();
    } catch (e) {
      _state = ResultState.Error;
      _widget = ErrorInformation();
      notifyListeners();
    }
  }

  Future<bool> isFavorited(String id) async {
    final selectedRestaurant = await databaseHelper.isFavorite(id);
    return selectedRestaurant.isNotEmpty;
  }

  void deletedFavorite(String id) async {
    try {
      await databaseHelper.deleteFavorite(id);
      _getFavorite();
    } catch (e) {
      _state = ResultState.Error;
      _widget = ErrorInformation();
      notifyListeners();
    }
  }
}
