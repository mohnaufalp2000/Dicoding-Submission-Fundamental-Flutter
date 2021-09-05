import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:submission_1/data/api/api_service.dart';
import 'package:submission_1/data/model/search_restaurant.dart';
import 'package:submission_1/provider/search_restaurant_provider.dart';
import 'package:submission_1/ui/widget/error_information.dart';
import 'package:submission_1/ui/widget/not_found.dart';
import 'package:submission_1/ui/widget/rating.dart';
import 'package:cached_network_image/cached_network_image.dart';

class SearchPage extends StatefulWidget {
  static const routeName = '/search_page';

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
    return Scaffold(
      body: SafeArea(
          child: ChangeNotifierProvider<SearchRestaurantProvider>(
              create: (_) => SearchRestaurantProvider(apiService: ApiService()),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(24, 24, 24, 0),
                      child: Row(
                        children: [
                          InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Icon(Icons.arrow_back, color: Colors.black)),
                          SizedBox(
                            width: 12,
                          ),
                          Text('Search Restaurant',
                              style: TextStyle(
                                  fontFamily: 'Sansation',
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700)),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(24),
                      child: TextField(
                        controller: textController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            prefixIcon: Icon(Icons.search),
                            suffixIcon: IconButton(
                                onPressed: textController.clear,
                                icon: Icon(Icons.clear)),
                            hintText: "Search Here"),
                        onSubmitted: (value) {
                          setState(() {
                            query = value;
                          });
                        },
                      ),
                    ),
                    Consumer<SearchRestaurantProvider>(
                        builder: (context, state, _) {
                      if (state.state == ResultState.Loading) {
                        return Center(child: CircularProgressIndicator());
                      } else if (state.state == ResultState.HasData) {
                        if (query != '') {
                          state.fetchSearchRestaurant(query);
                        } else {
                          state.fetchSearchRestaurant('');
                        }
                        return ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: state.result.restaurants.length,
                            itemBuilder: (context, index) {
                              var dataRestaurant =
                                  state.result.restaurants[index];
                              return _foundRestaurant(context, dataRestaurant);
                            });
                      } else if (state.state == ResultState.NoData) {
                        if (query != '') {
                          state.fetchSearchRestaurant(query);
                        } else {
                          state.fetchSearchRestaurant('');
                        }
                        return NotFound();
                      } else if (state.state == ResultState.Error) {
                        if (query != '') {
                          state.fetchSearchRestaurant(query);
                        } else {
                          state.fetchSearchRestaurant('');
                        }
                        return ErrorInformation();
                      } else {
                        return Text('');
                      }
                    })
                  ],
                ),
              ))),
    );
  }
}

Widget _foundRestaurant(BuildContext context, SearchRestaurant restaurant) {
  return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/detail_page', arguments: restaurant.id);
      },
      child: Container(
        margin: EdgeInsets.fromLTRB(24, 0, 24, 24),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedNetworkImage(
                imageUrl: 'https://restaurant-api.dicoding.dev/images/medium/' +
                    restaurant.pictureId,
                imageBuilder: (context, imageProvider) => ClipRRect(
                      borderRadius: BorderRadius.circular(24),
                      child: Container(
                        height: 100,
                        width: 130,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: imageProvider, fit: BoxFit.cover)),
                      ),
                    ),
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.error, size: 48),
                    )),
            SizedBox(width: 12),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 150,
                    child: Text(restaurant.name,
                        style: TextStyle(
                            fontFamily: 'Sansation',
                            fontSize: 18,
                            fontWeight: FontWeight.w700)),
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Text(restaurant.city,
                      style: TextStyle(
                          fontFamily: 'Sansation',
                          fontWeight: FontWeight.w300)),
                  SizedBox(
                    height: 32,
                  ),
                  Rating(
                    rating: restaurant.rating,
                  )
                ],
              ),
            )
          ],
        ),
      ));
}
