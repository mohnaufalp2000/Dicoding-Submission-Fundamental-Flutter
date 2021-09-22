import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:submission_3/data/provider/database_provider.dart';
import 'package:submission_3/ui/widget/restaurant_card.dart';
import 'package:submission_3/utils/result_state.dart';

class FavoritePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseProvider>(
      builder: (context, provider, child) {
        // Data exist
        if (provider.state == ResultState.HasData) {
          return Container(
            margin: EdgeInsets.symmetric(vertical: 24),
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: ListView.builder(
                itemCount: provider.favorite.length,
                itemBuilder: (context, index) {
                  return RestaurantCard(
                    restaurant: provider.favorite[index],
                  );
                }),
          );
        // Data is empty  
        } else {
          return Center(
            child: provider.widget
          );
        }
      },
    );
  }
}
