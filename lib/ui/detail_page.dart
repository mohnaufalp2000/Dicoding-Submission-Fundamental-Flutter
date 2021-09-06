import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:submission_1/data/api/api_service.dart';
import 'package:submission_1/data/model/categories.dart';
import 'package:submission_1/data/model/detail_restaurant.dart';
import 'package:submission_1/data/model/list_restaurant.dart';
import 'package:submission_1/provider/detail_restaurant_provider.dart';
import 'package:submission_1/ui/widget/error_information.dart';
import 'package:submission_1/ui/widget/favorite_btn.dart';
import 'package:submission_1/ui/widget/rating.dart';

class DetailPage extends StatefulWidget {
  static const routeName = '/detail_page';
  late String restaurantId;

  DetailPage(String restaurant) {
    restaurantId = restaurant;
  }

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ChangeNotifierProvider<DetailRestaurantProvider>(
          create: (_) => DetailRestaurantProvider(
              apiService: ApiService(), restaurantId: widget.restaurantId),
          child: Consumer<DetailRestaurantProvider>(
            builder: (context, state, _) {
              if (state.state == ResultState.Loading) {
                return Center(child: CircularProgressIndicator());
              } else if (state.state == ResultState.HasData) {
                var restaurant = state.result.restaurant;
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          CachedNetworkImage(
                              imageUrl:
                                  'https://restaurant-api.dicoding.dev/images/medium/' +
                                      restaurant.pictureId,
                              imageBuilder: (context, imageProvider) =>
                                  ClipRRect(
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(24),
                                          bottomRight: Radius.circular(24)),
                                      child: Image(
                                          image: imageProvider,
                                          fit: BoxFit.cover)),
                              placeholder: (context, url) =>
                                  CircularProgressIndicator(),
                              errorWidget: (context, url, error) =>
                                  Image.asset('assets/placeholderimage.jpg')),
                          Positioned(
                              top: 24,
                              left: 24,
                              child: InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Icon(Icons.arrow_back,
                                      color: Colors.white))),
                          Positioned(
                            top: 24,
                            right: 24,
                            child: FavoriteButton(),
                          )
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(24, 24, 24, 3),
                        child: SizedBox(
                          width: 200,
                          child: Text(restaurant.name,
                              style: TextStyle(
                                  fontSize: 24,
                                  fontFamily: 'Sansation',
                                  fontWeight: FontWeight.w700)),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        height: 20,
                        margin: EdgeInsets.fromLTRB(24, 0, 24, 6),
                        child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: restaurant.categories.length,
                            itemBuilder: (context, index) {
                              return (index == restaurant.categories.length - 1)
                                  ? Text(restaurant.categories[index].name,
                                      style: TextStyle(
                                          fontFamily: 'Sansation',
                                          fontWeight: FontWeight.w300))
                                  : Text(
                                      restaurant.categories[index].name + ', ',
                                      style: TextStyle(
                                          fontFamily: 'Sansation',
                                          fontWeight: FontWeight.w300));
                            }),
                      ),
                      Container(
                          margin: EdgeInsets.only(left: 24),
                          child: Rating(
                            rating: restaurant.rating,
                          )),
                      SizedBox(
                        height: 12,
                      ),
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.symmetric(horizontal: 24),
                        child: Text(restaurant.address + ', ' + restaurant.city,
                            style: TextStyle(
                                fontFamily: 'Sansation',
                                fontWeight: FontWeight.w700)),
                      ),
                      SizedBox(
                        height: 36,
                      ),
                      Container(
                          margin: EdgeInsets.symmetric(horizontal: 24),
                          child: Text(
                            'Description',
                            style: TextStyle(
                                fontSize: 18,
                                fontFamily: 'Sansation',
                                fontWeight: FontWeight.w700),
                            textAlign: TextAlign.justify,
                          )),
                      SizedBox(
                        height: 6,
                      ),
                      Container(
                          margin: EdgeInsets.symmetric(horizontal: 24),
                          child: Text(restaurant.description,
                              style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'Sansation',
                              ),
                              textAlign: TextAlign.justify)),
                      SizedBox(
                        height: 36,
                      ),
                      Container(
                          margin: EdgeInsets.symmetric(horizontal: 24),
                          child: Text('Food',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: 'Sansation',
                                  fontWeight: FontWeight.w700))),
                      SizedBox(
                        height: 6,
                      ),
                      Container(
                          height: MediaQuery.of(context).size.height * 2 / 7,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: restaurant.menus.foods.length,
                              itemBuilder: (context, index) {
                                return _foodList(
                                    context,
                                    restaurant.menus.foods[index],
                                    index,
                                    restaurant.menus.foods);
                              })),
                      SizedBox(
                        height: 12,
                      ),
                      Container(
                          margin: EdgeInsets.symmetric(horizontal: 24),
                          child: Text('Drink',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: 'Sansation',
                                  fontWeight: FontWeight.w700))),
                      SizedBox(
                        height: 6,
                      ),
                      Container(
                          height: MediaQuery.of(context).size.height * 2 / 7,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: restaurant.menus.drinks.length,
                              itemBuilder: (context, index) {
                                return _drinkList(
                                    context,
                                    restaurant.menus.drinks[index],
                                    index,
                                    restaurant.menus.drinks);
                              })),
                      SizedBox(
                        height: 12,
                      ),
                      Container(
                          margin: EdgeInsets.symmetric(horizontal: 24),
                          child: Text('Review',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: 'Sansation',
                                  fontWeight: FontWeight.w700))),
                      SizedBox(
                        height: 12,
                      ),
                      Container(
                          margin: EdgeInsets.fromLTRB(24, 0, 24, 24),
                          width: double.infinity,
                          child: ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: restaurant.customerReviews.length,
                              itemBuilder: (context, index) {
                                var review = restaurant.customerReviews[index];
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(Icons.account_circle, size: 48),
                                        Text(review.name,
                                            style: TextStyle(
                                                fontFamily: 'Sansation',
                                                fontWeight: FontWeight.w700)),
                                      ],
                                    ),
                                    SizedBox(height: 16),
                                    Text(review.review,
                                        style: TextStyle(
                                          fontFamily: 'Sansation',
                                        )),
                                    SizedBox(height: 8),
                                    (index !=
                                            restaurant.customerReviews.length -
                                                1)
                                        ? Column(
                                            children: [
                                              Divider(),
                                              SizedBox(
                                                height: 0,
                                              )
                                            ],
                                          )
                                        : SizedBox(
                                            height: 0,
                                          )
                                  ],
                                );
                              })),
                    ],
                  ),
                );
              } else if (state.state == ResultState.NoData) {
                return Center(child: Text(state.message));
              } else if (state.state == ResultState.Error) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.all(24),
                      child: InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child:
                                Icon(Icons.arrow_back))
                      ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(child: ErrorInformation(),),
                      ],
                    )
                  ],
                );
              } else {
                return Center(child: Text(''));
              }
            },
          ),
        ),
      ),
    );
  }
}

Widget _foodList(BuildContext context, Category restaurant, int index,
    List<Category> listFood) {
  return Padding(
    padding: EdgeInsets.only(
        left: (index == 0) ? 24 : 12,
        right: (index == listFood.length - 1) ? 24 : 12),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 150,
          width: 150,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              image: DecorationImage(
                  image: AssetImage('assets/food.jpg'), fit: BoxFit.cover)),
        ),
        SizedBox(
          height: 12,
        ),
        Container(
          width: 150,
          child: Text(
            restaurant.name,
            style: TextStyle(fontSize: 18, fontFamily: 'Sansation'),
          ),
        ),
      ],
    ),
  );
}

Widget _drinkList(BuildContext context, Category restaurant, int index,
    List<Category> listDrink) {
  return Padding(
    padding: EdgeInsets.only(
        left: (index == 0) ? 24 : 12,
        right: (index == listDrink.length - 1) ? 24 : 12),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 150,
          width: 150,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              image: DecorationImage(
                  image: AssetImage('assets/drink.png'), fit: BoxFit.cover)),
        ),
        SizedBox(height: 12),
        Container(
          width: 150,
          child: Text(
            restaurant.name,
            style: TextStyle(
              fontSize: 18,
              fontFamily: 'Sansation',
            ),
          ),
        ),
      ],
    ),
  );
}
