import 'package:flutter/material.dart';
import 'package:submission_1/data/model/categories.dart';

class CategoriesCard extends StatelessWidget {
  final Categories categories;
  final int index;

  const CategoriesCard({
    required this.categories,
    required this.index
    });

  @override
  Widget build(BuildContext context) {
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
}