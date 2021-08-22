import 'package:flutter/material.dart';

class Rating extends StatelessWidget {
  final double rating;
  final double starSize;
  final double fontSize;

  Rating({this.rating = 0, this.starSize = 20, this.fontSize = 12});

  @override
  Widget build(BuildContext context) {
    int ratingInt = rating ~/ 1;
    List<Widget> widgets = List.generate(
        5,
        (index) => Icon(
            index < ratingInt ? Icons.star : Icons.star_border_outlined,
            color: Colors.yellow[700],
            size: starSize));

    widgets.add(SizedBox(width: 3));
    widgets.add(Text(
      '$rating/5',
      style: TextStyle(
        fontSize: fontSize,
        fontFamily: 'Sansation',
      ),
      ));

    return Row(
      children: widgets,
    );
  }
}
