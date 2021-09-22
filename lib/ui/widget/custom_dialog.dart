import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:submission_3/res/navigation.dart';

customDialog(BuildContext context) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Coming Soon'),
          content: Text('This feature will be coming soon!'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigation.back();
                },
                child: Text('OK'))
          ],
        );
      });
}
