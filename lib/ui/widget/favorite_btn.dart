import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';

class FavoriteButton extends StatefulWidget {
  @override
  _FavoriteButtonState createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  bool isLiked = false;
  final size = 24.0;
  final unlikedColor = Colors.grey;
  final likedColor = Colors.red;

  @override
  Widget build(BuildContext context) {
    return LikeButton(
      size: size,
      isLiked: isLiked,
      likeBuilder: (isLiked) {
        final color = isLiked ? likedColor : unlikedColor;
        return Icon(Icons.favorite, color: color, size: size);
      },
    );
  }
}
