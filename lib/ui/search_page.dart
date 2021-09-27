import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:submission_3/data/provider/search_restaurant_provider.dart';
import 'package:submission_3/ui/widget/restaurant_card.dart';
import 'package:submission_3/utils/result_state.dart';


class SearchPage extends StatefulWidget {
  const SearchPage({ Key? key }) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController textController = TextEditingController();
  String query = '';

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

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
            // Search
            TextField(
                controller: textController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.search),
                    hintText: 'Search here...'),
                onChanged: (value) {
                  setState(() {
                    query = value;
                  });
                }),
            SizedBox(
              height: 12,
            ),
            // List Restaurant
            Consumer<SearchRestaurantProvider>(builder: (context, state, _) {
              // Loading
              if (state.state == ResultState.Loading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
                // Data is exist
              } else if (state.state == ResultState.HasData) {
                if (query != '') {
                  state.fetchFoundRestaurant(query);
                } else {
                  state.fetchFoundRestaurant('');
                }
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
                if (query != '') {
                  state.fetchFoundRestaurant(query);
                } else {
                  state.fetchFoundRestaurant('');
                }
                return Center(
                  child: state.widget,
                );
                // Error
              } else if (state.state == ResultState.Error) {
                if (query != '') {
                  state.fetchFoundRestaurant(query);
                } else {
                  state.fetchFoundRestaurant('');
                }
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