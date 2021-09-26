import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:submission_3/data/model/restaurant_model.dart';
import 'package:submission_3/data/provider/database_provider.dart';
import 'package:submission_3/res/navigation.dart';
import 'package:submission_3/res/widget.dart';
import 'package:submission_3/ui/detail_page.dart';
import 'package:submission_3/ui/widget/rating.dart';

class RestaurantCard extends StatelessWidget {
  final Restaurant restaurant;

  const RestaurantCard({required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseProvider>(
      builder: (context, provider, child) {
        return FutureBuilder<bool>(
          future: provider.isFavorited(restaurant.id),
          builder: (context, snapshot) {
            var isFavorited = snapshot.data ?? false;
            // Intent Detail Page
            return InkWell(
              onTap: () =>
               Navigation.intentWithData(DetailPage.routeName, restaurant.id),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Row(
                  children: [
                    Hero(
                      tag: restaurant.pictureId,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(24),
                        child: Container(
                            width: 130,
                            height: 110,
                            child: CachedNetworkImage(
                              imageUrl:
                                  'https://restaurant-api.dicoding.dev/images/medium/${restaurant.pictureId}',
                              fit: BoxFit.cover,
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                            )),
                      ),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            width: 110,
                            child: textRegular(
                              restaurant.name,
                              18,
                            )),
                        SizedBox(
                          height: 2,
                        ),
                        Rating(
                          rating: restaurant.rating,
                        ),
                        SizedBox(
                          height: 24,
                        ),
                        textLight(
                          restaurant.city,
                          14,
                        )
                      ],
                    ),
                    SizedBox(
                      width: 14,
                    ),
                    isFavorited
                        ? IconButton(
                            onPressed: () =>
                                provider.deletedFavorite(restaurant.id),
                            icon: Icon(Icons.favorite))
                        : IconButton(
                            onPressed: () => provider.addFavorite(restaurant),
                            icon: Icon(Icons.favorite_border))
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
