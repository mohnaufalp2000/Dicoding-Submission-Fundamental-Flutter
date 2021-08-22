import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:submission_1/data/restaurant.dart';
import 'package:submission_1/ui/widget/favorite_btn.dart';
import 'package:submission_1/ui/widget/rating.dart';

class DetailPage extends StatelessWidget {
  static const routeName = '/detail_page';
  final Restaurant restaurant;

  const DetailPage(this.restaurant);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  CachedNetworkImage(
                      imageUrl: restaurant.pictureId,
                      imageBuilder: (context, imageProvider) => ClipRRect(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(24),
                              bottomRight: Radius.circular(24)),
                          child:
                              Image(image: imageProvider, fit: BoxFit.cover)),
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
                          child: Icon(Icons.arrow_back, color: Colors.white))),
                  Positioned(
                    top: 24,
                    right: 24,
                    child: FavoriteButton(),
                  )
                ],
              ),
              Container(
                margin: EdgeInsets.fromLTRB(24, 24, 24, 6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 200,
                      child: Text(restaurant.name,
                          style: TextStyle(
                              fontSize: 24,
                              fontFamily: 'Sansation',
                              fontWeight: FontWeight.w700)),
                    ),
                    Row(
                      children: [
                        Icon(Icons.location_on),
                        SizedBox(width: 2),
                        Text(restaurant.city,
                            style: TextStyle(
                                fontFamily: 'Sansation',
                                fontWeight: FontWeight.w700))
                      ],
                    )
                  ],
                ),
              ),
              Container(
                  margin: EdgeInsets.only(left: 24),
                  child: Rating(
                    rating: restaurant.rating,
                  )),
              SizedBox(
                height: 24,
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
                height: 18,
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
                        return _foodList(context, restaurant.menus.foods[index],
                            index, restaurant.menus.foods);
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
            ],
          ),
        ),
      ),
    );
  }
}

Widget _foodList(
    BuildContext context, Drink restaurant, int index, List<Drink> listFood) {
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

Widget _drinkList(
    BuildContext context, Drink restaurant, int index, List<Drink> listDrink) {
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
