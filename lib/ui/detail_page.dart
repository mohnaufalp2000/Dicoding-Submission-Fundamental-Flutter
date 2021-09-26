import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:submission_3/data/api/api_service.dart';
import 'package:submission_3/data/provider/detail_restaurant_provider.dart';
import 'package:submission_3/data/provider/preferences_provider.dart';
import 'package:submission_3/res/navigation.dart';
import 'package:submission_3/res/styles.dart';
import 'package:submission_3/res/widget.dart';
import 'package:submission_3/ui/widget/food_and_drink_card.dart';
import 'package:submission_3/ui/widget/rating.dart';
import 'package:submission_3/utils/result_state.dart';

class DetailPage extends StatelessWidget {
  static const routeName = '/detail_page';
  final String id;

  const DetailPage({
    required this.id
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            bottom: false,
            child: ChangeNotifierProvider<DetailRestaurantProvider>(
                create: (_) =>
                    DetailRestaurantProvider(apiService: ApiService(), id: id),
                child: Consumer<DetailRestaurantProvider>(
                    builder: (context, state, _) {
                  if (state.state == ResultState.Loading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state.state == ResultState.HasData) {
                    var restaurant = state.result.restaurant;
                    var category = restaurant.categories;
                    var foods = restaurant.menus.foods;
                    var drinks = restaurant.menus.drinks;
                    var reviews = restaurant.customerReviews;
                    return Stack(
                      children: [
                        // Restaurant Image
                        Hero(
                          tag: restaurant.pictureId,
                          child: CachedNetworkImage(
                            width: MediaQuery.of(context).size.width,
                            height: 350,
                            imageUrl:
                                'https://restaurant-api.dicoding.dev/images/medium/${restaurant.pictureId}',
                            fit: BoxFit.cover,
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          ),
                        ),
                        ListView(children: [
                          SizedBox(
                            height: 330,
                          ),
                          Consumer<PreferencesProvider>(
                            builder: (context, provider, child) {
                              return Container(
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      color: (provider.isDarkTheme)
                                          ? darkPrimaryColor
                                          : Colors.white,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(24),
                                          topRight: Radius.circular(24))),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 24,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 24),
                                          child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    // Restaurant Name
                                                    Container(
                                                        width: 200,
                                                        child: textBold(
                                                            restaurant.name,
                                                            24)),
                                                    SizedBox(height: 2),
                                                    // Restaurant Category
                                                    Container(
                                                      height: 20,
                                                      child: ListView.builder(
                                                          physics:
                                                              NeverScrollableScrollPhysics(),
                                                          scrollDirection:
                                                              Axis.horizontal,
                                                          shrinkWrap: true,
                                                          itemCount:
                                                              category.length,
                                                          itemBuilder:
                                                              (context, index) {
                                                            return (index ==
                                                                    category.length -
                                                                        1)
                                                                ? textLight(
                                                                    category[
                                                                            index]
                                                                        .name,
                                                                    14)
                                                                : textLight(
                                                                    category[index]
                                                                            .name +
                                                                        ', ',
                                                                    14);
                                                          }),
                                                    ),
                                                    SizedBox(
                                                      height: 2,
                                                    ),
                                                  ],
                                                ),
                                                // Rating
                                                Rating(
                                                    rating: restaurant.rating)
                                              ]),
                                        ),
                                        SizedBox(
                                          height: 24,
                                        ),
                                        // Food List
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 24.0),
                                          child: textRegular('Food', 18),
                                        ),
                                        SizedBox(
                                          height: 6,
                                        ),
                                        menusCard(
                                            context, foods, 'images/food.jpg'),
                                        SizedBox(
                                          height: 12,
                                        ),
                                        // Drink List
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 24.0),
                                          child: textRegular('Drink', 18),
                                        ),
                                        SizedBox(
                                          height: 6,
                                        ),
                                        menusCard(context, drinks,
                                            'images/drink.png'),
                                        SizedBox(
                                          height: 24,
                                        ),
                                        // Location
                                        Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 24),
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  textRegular('Location', 18),
                                                  SizedBox(
                                                    height: 2,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      SizedBox(
                                                        width: 200,
                                                        child: textLight(
                                                          restaurant.address +
                                                              ', ' +
                                                              restaurant.city,
                                                          16,
                                                        ),
                                                      ),
                                                      Image.asset(
                                                          'images/btn_location.png')
                                                    ],
                                                  ),
                                                ])),
                                        SizedBox(
                                          height: 24,
                                        ),
                                        // Description
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 24),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              textRegular('Description', 18),
                                              SizedBox(
                                                height: 6,
                                              ),
                                              textLight(
                                                  restaurant.description, 18,
                                                  align: TextAlign.justify)
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 24,
                                        ),
                                        // Review
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 24),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              textRegular('Review', 18),
                                              SizedBox(
                                                height: 6,
                                              ),
                                              Container(
                                                  child: ListView.builder(
                                                      shrinkWrap: true,
                                                      physics:
                                                          NeverScrollableScrollPhysics(),
                                                      itemCount: reviews.length,
                                                      itemBuilder:
                                                          (context, index) {
                                                        return Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Row(
                                                              children: [
                                                                Icon(
                                                                    Icons
                                                                        .account_circle,
                                                                    size: 48),
                                                                textBold(
                                                                  reviews[index]
                                                                      .name,
                                                                  14,
                                                                ),
                                                                SizedBox(
                                                                  height: 16,
                                                                ),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              height: 8,
                                                            ),
                                                            textRegular(
                                                              reviews[index]
                                                                  .review,
                                                              14,
                                                            ),
                                                            (index !=
                                                                    restaurant
                                                                            .customerReviews
                                                                            .length -
                                                                        1)
                                                                ? Column(
                                                                    children: [
                                                                      Divider(),
                                                                      SizedBox(
                                                                        height:
                                                                            0,
                                                                      )
                                                                    ],
                                                                  )
                                                                : SizedBox(
                                                                    height: 24,
                                                                  )
                                                          ],
                                                        );
                                                      })),
                                            ],
                                          ),
                                        ),
                                      ]));
                            },
                          ),
                        ]),
                        // Back Button
                        InkWell(
                          onTap: () {
                            Navigation.back();
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Image.asset('images/btn_back.png'),
                          ),
                        ),
                      ],
                    );
                  } else if (state.state == ResultState.NoData) {
                    return Center(
                      child: state.widget,
                    );
                  } else if (state.state == ResultState.Error) {
                    return Center(
                      child: state.widget,
                    );
                  } else {
                    return Center(child: Text(''));
                  }
                }))));
  }
}
