import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:submission_1/data/restaurant.dart';
import 'package:submission_1/ui/widget/rating.dart';

class SearchPage extends StatefulWidget {
  static const routeName = '/search_page';

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<Restaurant> restaurant = [];
  List<Restaurant> listFound = [];

  @override
  void initState() {
    super.initState();

    setState(() {
      listFound = restaurant;
    });
  }

  onSearch(String value) {
    setState(() {
      listFound = restaurant
          .where((element) => element.name.toLowerCase().contains(value))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 24,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 6,
                  ),
                  InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.arrow_back)),
                  SizedBox(
                    width: 12,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.86,
                    child: TextField(
                      onChanged: (value) => onSearch(value),
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(24)),
                          hintText: 'Enter a search term',
                          contentPadding: EdgeInsets.fromLTRB(12, 8, 12, 8),
                          prefixIcon: Icon(Icons.search)),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 12,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 14),
                child: FutureBuilder<String>(
                    future: DefaultAssetBundle.of(context)
                        .loadString('assets/restaurant.json'),
                    builder: (context, snapshot) {
                      restaurant.clear();
                      final List<Restaurant> welcomeRestaurant =
                          welcomeFromJson(snapshot.data).restaurants;
                      restaurant.addAll(welcomeRestaurant);
                      return ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: listFound.length,
                          itemBuilder: (context, index) {
                            return _foundRestaurant(context, listFound[index]);
                          });
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget _foundRestaurant(BuildContext context, Restaurant restaurant) {
  return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/detail_page', arguments: restaurant);
      },
      child: Container(
        margin: EdgeInsets.fromLTRB(24, 0, 24, 24),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedNetworkImage(
                imageUrl: restaurant.pictureId,
                imageBuilder: (context, imageProvider) => ClipRRect(
                      borderRadius: BorderRadius.circular(24),
                      child: Container(
                        height: 100,
                        width: 130,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(restaurant.pictureId),
                                fit: BoxFit.cover)),
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
