import 'package:flutter/material.dart';
import 'package:submission_1/data/categories.dart';
import 'package:submission_1/data/restaurant.dart';
import 'package:submission_1/ui/widget/rating.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HomePage extends StatelessWidget {
  static const routeName = '/home_page';

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
                                  image:
                                      AssetImage('assets/placeholderimage.jpg'),
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
                    borderRadius: BorderRadius.circular(24),
                    color: Colors.grey),
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
                              fontFamily: 'Sansation',
                              fontWeight: FontWeight.w300),
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
                child: FutureBuilder<String>(
                    future: DefaultAssetBundle.of(context)
                        .loadString('assets/restaurant.json'),
                    builder: (context, snapshot) {
                      final List<Restaurant> restaurant =
                          welcomeFromJson(snapshot.data).restaurants;
                      return ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: 5,
                          itemBuilder: (context, index) {
                            return _popularItem(
                                context, restaurant[index], index);
                          });
                    }),
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
                      return _categoriesItem(context, categories, index);
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget _popularItem(BuildContext context, Restaurant restaurant, int index) {
  return InkWell(
    onTap: () {
      Navigator.pushNamed(context, '/detail_page', arguments: restaurant);
    },
    child: Padding(
      padding: EdgeInsets.only(
          left: (index == 0) ? 24 : 6, right: (index == 4) ? 24 : 6),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Card(
          elevation: 5,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CachedNetworkImage(
                  imageUrl: restaurant.pictureId,
                  imageBuilder: (context, imageProvider) => Container(
                      width: 200,
                      height: 120,
                      child: ClipRRect(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(24),
                              topRight: Radius.circular(24)),
                          child:
                              Image(image: imageProvider, fit: BoxFit.cover))),
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Container(
                        width: 200,
                        height: 120,
                        child: ClipRRect(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(24),
                                topRight: Radius.circular(24)),
                            child: Image(
                                image:
                                    AssetImage('assets/placeholderimage.jpg'),
                                fit: BoxFit.cover)),
                      )),
              SizedBox(
                height: 6,
              ),
              Container(
                padding: EdgeInsets.only(left: 8, right: 0),
                width: 150,
                child: Text(
                  restaurant.name,
                  style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'Sansation',
                      fontWeight: FontWeight.w700),
                ),
              ),
              SizedBox(
                height: 6,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  restaurant.city,
                  style: TextStyle(
                      fontSize: 12,
                      fontFamily: 'Sansation',
                      fontWeight: FontWeight.w300),
                ),
              ),
              SizedBox(
                height: 6,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Rating(rating: restaurant.rating),
              )
            ],
          ),
        ),
      ),
    ),
  );
}

Widget _categoriesItem(BuildContext context, Categories categories, int index) {
  return InkWell(
    onTap: () {
      Navigator.pushNamed(context, '/restaurant_list',
          arguments: categories.title);
    },
    child: Column(
      children: [
        Card(
          elevation: 5,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          child: Container(
            margin: EdgeInsets.fromLTRB(8, 8, 8, 8),
            alignment: Alignment.center,
            child: Image.asset(categories.image),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(24)),
          ),
        ),
        SizedBox(height: 2),
        Text(
          categories.title,
          style: TextStyle(
            fontFamily: 'Sansation',
          ),
        ),
      ],
    ),
  );
}
