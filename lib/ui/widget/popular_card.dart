import 'package:flutter/material.dart';
import 'package:submission_1/data/model/list_restaurant.dart';
import 'package:submission_1/ui/widget/rating.dart';
import 'package:cached_network_image/cached_network_image.dart';


class PopularCard extends StatelessWidget {
  final Restaurant restaurant;
  final int index;

  const PopularCard({
    required this.restaurant,
    required this.index
    });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/detail_page', arguments: restaurant.id);
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
                    imageUrl: 'https://restaurant-api.dicoding.dev/images/medium/' + restaurant.pictureId,
                    imageBuilder: (context, imageProvider) => Container(
                        width: 200,
                        height: 120,
                        child: ClipRRect(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(24),
                                topRight: Radius.circular(24)),
                            child: Image(
                                image: imageProvider, fit: BoxFit.cover))),
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
    ;
  }
}
