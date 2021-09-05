import 'package:flutter/material.dart';

class NotFound extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(Icons.error, size: 64, color: Color.fromRGBO(46, 71, 154, 1)),
        Text(
          'Oh No!',
          style: TextStyle(
              fontFamily: 'Sansation',
              fontWeight: FontWeight.w700,
              fontSize: 18,
              color: Color.fromRGBO(17, 31, 101, 1)),
        ),
        SizedBox(height: 12),
        Text(
          'We are unable to find the data that you are looking for',
          style: TextStyle(fontFamily: 'Sansation', fontSize: 13),
        ),
      ],
    );
  }
}