import 'package:flutter/material.dart';

Widget textRegular(String text, double size, {TextAlign align = TextAlign.left}) {
  return Text(
    text,
    textAlign: align,
    style: TextStyle(
      fontSize: size,
      fontFamily: 'Poppins',
    ),
  );
}

Widget textLight(String text, double size, {TextAlign align = TextAlign.left}) {
  return Text(
    text,
    textAlign: align,
    style: TextStyle(
      fontSize: size,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w300,
    ),
  );
}

Widget textBold(String text, double size, {TextAlign align = TextAlign.left}) {
  return Text(
    text,
    textAlign: align,
    style: TextStyle(
        fontSize: size, 
        fontFamily: 'Poppins', 
        fontWeight: FontWeight.w700),
  );
}

