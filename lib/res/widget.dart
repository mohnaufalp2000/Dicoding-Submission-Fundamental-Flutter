import 'package:flutter/material.dart';

Widget textRegular(String text, double size, {Color color = Colors.black}) {
  return Text(
    text,
    style: TextStyle(
      fontSize: size,
      fontFamily: 'Poppins',
      color: color
    ),
  );
}

Widget textLight(String text, double size, {Color color = Colors.black, TextAlign align = TextAlign.left}) {
  return Text(
    text,
    textAlign: align,
    style: TextStyle(
      fontSize: size,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w300,
      color: color
    ),
  );
}

Widget textBold(String text, double size, {Color color = Colors.black}) {
  return Text(
    text,
    style: TextStyle(
        fontSize: size, 
        fontFamily: 'Poppins', 
        fontWeight: FontWeight.w700),
  );
}

