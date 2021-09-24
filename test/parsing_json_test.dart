import 'package:flutter_test/flutter_test.dart';
import 'package:submission_3/data/api/api_service.dart';
import 'package:submission_3/data/model/restaurant_model.dart';
import 'package:submission_3/data/provider/restaurant_list_provider.dart';
import 'package:mockito/mockito.dart';

class MockApiService extends Mock implements ApiService {}

var restaurantResult = {
  "error": false,
  "message": "success",
  "count": 1,
  "restaurants": [
    {
      "id": "rqdv5juczeskfw1e867",
      "name": "Melting Pot",
      "description":
          "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. ...",
      "pictureId": "14",
      "city": "Medan",
      "rating": 4.2
    },
  ]
};

var restaurant = {
  "id": "rqdv5juczeskfw1e867",
  "name": "Melting Pot",
  "description":
      "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. ...",
  "pictureId": "14",
  "city": "Medan",
  "rating": 4.2
};

var searchResult = {
  "error": false,
  "founded": 1,
  "restaurants": [
    {
      "id": "fnfn8mytkpmkfw1e867",
      "name": "Makan mudah",
      "description":
          "But I must explain to you how all this mistaken idea of denouncing pleasure and praising pain was born and I will give you a complete account of the system, ...",
      "pictureId": "22",
      "city": "Medan",
      "rating": 3.7
    }
  ]
};

var detailRestaurant = {
  "error": false,
  "message": "success",
  "restaurant": {
    "id": "rqdv5juczeskfw1e867",
    "name": "Melting Pot",
    "description":
        "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. ...",
    "city": "Medan",
    "address": "Jln. Pandeglang no 19",
    "pictureId": "14",
    "categories": [
      {"name": "Italia"},
      {"name": "Modern"}
    ],
    "menus": {
      "foods": [
        {"name": "Paket rosemary"},
        {"name": "Toastie salmon"}
      ],
      "drinks": [
        {"name": "Es krim"},
        {"name": "Sirup"}
      ]
    },
    "rating": 4.2,
    "customerReviews": [
      {
        "name": "Ahmad",
        "review": "Tidak rekomendasi untuk pelajar!",
        "date": "13 November 2019"
      }
    ]
  }
};

void main() {
  group('Test parsing restaurant json', () {
    late RestaurantProvider restaurantProvider;
    late ApiService apiService;

    setUp(() {
      apiService = MockApiService();
      when(apiService.restaurantList())
          .thenAnswer((_) async => RestaurantResult.fromJson(restaurantResult));
      restaurantProvider = RestaurantProvider(apiService: apiService);
    });

    test('parsing restaurant', () async {
      var result = restaurantProvider.result.restaurants[0];
      var jsonRes = Restaurant.fromJson(restaurant);
      expect(result.name == jsonRes.name, true);
    });
  });
}
