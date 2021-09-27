import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:submission_3/data/provider/restaurant_list_provider.dart';
import 'package:submission_3/data/provider/search_restaurant_provider.dart';
import 'package:submission_3/res/widget.dart';
import 'package:submission_3/ui/widget/restaurant_card.dart';
import 'package:submission_3/utils/result_state.dart';

class RestaurantList extends StatefulWidget {
  @override
  _RestaurantListState createState() => _RestaurantListState();
}

class _RestaurantListState extends State<RestaurantList> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: ListView(
          children: [
            SizedBox(
              height: 24,
            ),
            // Title
            textBold('Find Restaurant', 24),
            SizedBox(
              height: 6,
            ),
            textLight('Help you to find restaurant', 14),
            SizedBox(
              height: 24,
            ),
            // List Restaurant
            Consumer<RestaurantProvider>(builder: (context, state, _) {
              // Loading
              if (state.state == ResultState.Loading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
                // Data is exist
              } else if (state.state == ResultState.HasData) {
                return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: state.result.restaurants.length,
                    itemBuilder: (context, index) {
                      var restaurant = state.result.restaurants[index];
                      return RestaurantCard(
                        restaurant: restaurant,
                      );
                    });
                // Data is empty
              } else if (state.state == ResultState.NoData) {
                return Center(
                  child: state.widget,
                );
                // Error
              } else if (state.state == ResultState.Error) {
                return Center(
                  child: state.widget,
                );
              } else {
                return Center(
                  child: Text(''),
                );
              }
            }),
            SizedBox(
              height: 24,
            ),
          ],
        ),
      ),
    );
  }
}
