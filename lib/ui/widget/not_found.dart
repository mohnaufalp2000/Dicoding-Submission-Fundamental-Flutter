import 'package:flutter/material.dart';
import 'package:submission_3/res/widget.dart';

class NotFound extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(Icons.error, size: 64, color: Color.fromRGBO(46, 71, 154, 1)),
        textBold('Oh No!', 18),
        SizedBox(height: 12),
        Container(
          width: 250,
          child: Text(
            'Nothing found in here, Seems like data is empty.',
            textAlign: TextAlign.center,
            style: TextStyle(fontFamily: 'Poppins', fontSize: 13),
          ),
        ),
      ],
    );
  }
}