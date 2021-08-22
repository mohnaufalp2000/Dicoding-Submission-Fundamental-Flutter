import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:submission_1/data/restaurant.dart';
import 'package:submission_1/ui/widget/rating.dart';

class RestaurantList extends StatelessWidget {
  static const routeName = '/restaurant_list';
  final String title;

  const RestaurantList(this.title);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(24, 24, 24, 12),
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
                    Text(title,
                        style: TextStyle(
                            fontFamily: 'Sansation',
                            fontSize: 24,
                            fontWeight: FontWeight.w700)),
                  ],
                ),
              ),
              SizedBox(
                height: 24,
              ),
              FutureBuilder<String>(
                  future: DefaultAssetBundle.of(context)
                      .loadString('assets/restaurant.json'),
                  builder: (context, snapshot) {
                    final List<Restaurant> restaurant =
                        welcomeFromJson(snapshot.data).restaurants;
                    final List<Restaurant> nearbyRestaurant = [];
                    final List<Restaurant> bestRestaurant = [];
                    final List<Restaurant> dayNightRestaurant = [];
                    final List<Restaurant> newRestaurant = [];
                    for (int i = 0; i < restaurant.length; i++) {
                      if (restaurant[i].city == 'Surabaya') {
                        nearbyRestaurant.add(restaurant[i]);
                      }
                      if (restaurant[i].rating >= 4.2) {
                        bestRestaurant.add(restaurant[i]);
                      }
                      if (i >= 0 && i <= 5) {
                        dayNightRestaurant.add(restaurant[i]);
                      }
                      if (i >= 7 && i <= restaurant.length - 1) {
                        newRestaurant.add(restaurant[i]);
                      }
                    }
                    return ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: (title == 'Near me')
                            ? nearbyRestaurant.length
                            : (title == 'Best sellers')
                                ? bestRestaurant.length
                                : (title == '24 Hours')
                                    ? dayNightRestaurant.length
                                    : newRestaurant.length,
                        itemBuilder: (context, index) {
                          return (title == 'Near me')
                              ? _nearbyItems(
                                  context, nearbyRestaurant[index], index)
                              : (title == 'Best sellers')
                                  ? _bestItems(
                                      context, bestRestaurant[index], index)
                                  : (title == '24 Hours')
                                      ? _dayNightItems(context,
                                          dayNightRestaurant[index], index)
                                      : _newItems(
                                          context, newRestaurant[index], index);
                        });
                  })
            ],
          ),
        ),
      ),
    );
  }
}

Widget _newItems(BuildContext context, Restaurant newRestaurant, int index) {
  return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/detail_page', arguments: newRestaurant);
      },
      child: Container(
        margin: EdgeInsets.fromLTRB(24, 12, 24, 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedNetworkImage(
                imageUrl: newRestaurant.pictureId,
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
                errorWidget: (context, url, error) => ClipRRect(
                      borderRadius: BorderRadius.circular(24),
                      child: Container(
                        height: 100,
                        width: 130,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image:
                                    AssetImage('assets/placeholderimage.jpg'),
                                fit: BoxFit.cover)),
                      ),
                    )),
            SizedBox(width: 12),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(newRestaurant.name,
                      style: TextStyle(
                          fontFamily: 'Sansation',
                          fontSize: 18,
                          fontWeight: FontWeight.w700)),
                  SizedBox(
                    height: 2,
                  ),
                  Text(newRestaurant.city,
                      style: TextStyle(
                          fontFamily: 'Sansation',
                          fontWeight: FontWeight.w300)),
                  SizedBox(
                    height: 32,
                  ),
                  Rating(
                    rating: newRestaurant.rating,
                  )
                ],
              ),
            )
          ],
        ),
      ));
}

Widget _dayNightItems(
    BuildContext context, Restaurant dayNightRestaurant, int index) {
  return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/detail_page',
            arguments: dayNightRestaurant);
      },
      child: Container(
        margin: EdgeInsets.fromLTRB(24, 12, 24, 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedNetworkImage(
                imageUrl: dayNightRestaurant.pictureId,
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
                errorWidget: (context, url, error) => ClipRRect(
                      borderRadius: BorderRadius.circular(24),
                      child: Container(
                        height: 100,
                        width: 130,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image:
                                    AssetImage('assets/placeholderimage.jpg'),
                                fit: BoxFit.cover)),
                      ),
                    )),
            SizedBox(width: 12),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(dayNightRestaurant.name,
                      style: TextStyle(
                          fontFamily: 'Sansation',
                          fontSize: 18,
                          fontWeight: FontWeight.w700)),
                  SizedBox(
                    height: 2,
                  ),
                  Text(dayNightRestaurant.city,
                      style: TextStyle(
                          fontFamily: 'Sansation',
                          fontWeight: FontWeight.w300)),
                  SizedBox(
                    height: 32,
                  ),
                  Rating(
                    rating: dayNightRestaurant.rating,
                  )
                ],
              ),
            )
          ],
        ),
      ));
}

Widget _bestItems(BuildContext context, Restaurant bestRestaurant, int index) {
  return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/detail_page', arguments: bestRestaurant);
      },
      child: Container(
        margin: EdgeInsets.fromLTRB(24, 12, 24, 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedNetworkImage(
                imageUrl: bestRestaurant.pictureId,
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
                errorWidget: (context, url, error) => ClipRRect(
                      borderRadius: BorderRadius.circular(24),
                      child: Container(
                        height: 100,
                        width: 130,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image:
                                    AssetImage('assets/placeholderimage.jpg'),
                                fit: BoxFit.cover)),
                      ),
                    )),
            SizedBox(width: 12),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(bestRestaurant.name,
                      style: TextStyle(
                          fontFamily: 'Sansation',
                          fontSize: 18,
                          fontWeight: FontWeight.w700)),
                  SizedBox(
                    height: 2,
                  ),
                  Text(bestRestaurant.city,
                      style: TextStyle(
                          fontFamily: 'Sansation',
                          fontWeight: FontWeight.w300)),
                  SizedBox(
                    height: 32,
                  ),
                  Rating(
                    rating: bestRestaurant.rating,
                  )
                ],
              ),
            )
          ],
        ),
      ));
}

Widget _nearbyItems(
    BuildContext context, Restaurant nearbyRestaurant, int index) {
  return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/detail_page',
            arguments: nearbyRestaurant);
      },
      child: Container(
        margin: EdgeInsets.fromLTRB(24, 12, 24, 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedNetworkImage(
                imageUrl: nearbyRestaurant.pictureId,
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
                errorWidget: (context, url, error) => ClipRRect(
                      borderRadius: BorderRadius.circular(24),
                      child: Container(
                        height: 100,
                        width: 130,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image:
                                    AssetImage('assets/placeholderimage.jpg'),
                                fit: BoxFit.cover)),
                      ),
                    )),
            SizedBox(width: 12),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(nearbyRestaurant.name,
                      style: TextStyle(
                          fontFamily: 'Sansation',
                          fontSize: 18,
                          fontWeight: FontWeight.w700)),
                  SizedBox(
                    height: 2,
                  ),
                  Text(nearbyRestaurant.city,
                      style: TextStyle(
                          fontFamily: 'Sansation',
                          fontWeight: FontWeight.w300)),
                  SizedBox(
                    height: 32,
                  ),
                  Rating(
                    rating: nearbyRestaurant.rating,
                  )
                ],
              ),
            )
          ],
        ),
      ));
}
