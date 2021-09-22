import 'package:flutter/material.dart';
import 'package:submission_3/data/model/detail_restaurant_model.dart';
import 'package:submission_3/res/widget.dart';

Widget menusCard(BuildContext context, List<Category> category, String images) {
  return Container(
    height: 120,
    child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: category.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: (index == 0)
                ? EdgeInsets.only(left: 24, right: 6)
                : (index == category.length - 1)
                    ? EdgeInsets.only(right: 24, left: 6)
                    : EdgeInsets.symmetric(horizontal: 6),
            child: Container(
              width: 150,
              height: 120,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  image: DecorationImage(
                      fit: BoxFit.cover, image: AssetImage(images))),
              child: Container(
                width: 150,
                height: 120,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Colors.black.withOpacity(0.61),
                          Colors.black.withOpacity(0)
                        ])),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: textRegular(category[index].name, 14,
                          color: Colors.white),
                    )
                  ],
                ),
              ),
            ),
          );
        }),
  );
}
