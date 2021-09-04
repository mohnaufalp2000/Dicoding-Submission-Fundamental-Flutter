import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:submission_1/data/api/api_service.dart';
import 'package:submission_1/data/model/categories.dart';
import 'package:submission_1/data/model/list_restaurant.dart';
import 'package:submission_1/provider/restaurant_provider.dart';
import 'package:submission_1/ui/home_page/popular_list.dart';
import 'package:submission_1/ui/widget/categories_card.dart';
import 'package:submission_1/ui/widget/popular_card.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home_page';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(24, 12, 24, 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Surabaya, Indonesia',
                      style: TextStyle(
                          fontSize: 10,
                          fontFamily: 'Sansation',
                          fontWeight: FontWeight.w300),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text('Hello, Guest',
                        style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'Sansation',
                            fontWeight: FontWeight.w700))
                  ],
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: Container(
                    width: 50,
                    height: 50,
                    child: CachedNetworkImage(
                        imageUrl:
                            'https://mir-s3-cdn-cf.behance.net/project_modules/2800_opt_1/d07bca98931623.5ee79b6a8fa55.jpg',
                        imageBuilder: (context, imageProvider) => Image(
                              image: imageProvider,
                            ),
                        placeholder: (context, url) =>
                            CircularProgressIndicator(),
                        errorWidget: (context, url, error) => Container(
                            width: 50,
                            height: 50,
                            child: Image(
                              image: AssetImage('assets/placeholderimage.jpg'),
                              fit: BoxFit.cover,
                            ))),
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 24),
            height: 40,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24), color: Colors.grey),
            child: Material(
              borderRadius: BorderRadius.circular(24),
              child: InkWell(
                borderRadius: BorderRadius.circular(24),
                onTap: () {
                  Navigator.pushNamed(context, '/search_page');
                },
                child: Row(
                  children: [
                    SizedBox(
                      width: 12,
                    ),
                    Icon(Icons.search),
                    Text(
                      'What would you like to eat?',
                      style: TextStyle(
                          fontFamily: 'Sansation', fontWeight: FontWeight.w300),
                    )
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 24,
          ),
          Container(
              margin: EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                'Popular on this week',
                style: TextStyle(
                    fontSize: 24,
                    fontFamily: 'Sansation',
                    fontWeight: FontWeight.w700),
              )),
          SizedBox(
            height: 6,
          ),
          Container(
            height: MediaQuery.of(context).size.height * 2 / 6,
            child: ChangeNotifierProvider<RestaurantProvider>(
              create: (_) => RestaurantProvider(apiService: ApiService()),
              child: PopularList(),
            ),
          
          ),
          Container(
            margin: EdgeInsets.fromLTRB(24, 12, 24, 0),
            child: Text('Categories',
                style: TextStyle(
                    fontSize: 24,
                    fontFamily: 'Sansation',
                    fontWeight: FontWeight.w700)),
          ),
          SizedBox(
            height: 8,
          ),
          Container(
            margin: EdgeInsets.fromLTRB(24, 0, 24, 24),
            child: GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: listCategories.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemBuilder: (context, index) {
                  final Categories categories = listCategories[index];
                  return CategoriesCard(categories: categories, index: index);
                }),
          )
        ],
      ),
    )));
  }
}

