import 'package:flutter/material.dart';

class CardBackgroundData{
  final String title;
  final String subtittle;
  final ImageProvider image;
  final Color backgroundColor;
  final Color titleColor;
  final Color subtitleColor;

  const CardBackgroundData({
    required this.title,
    required this.subtittle,
    required this.image,
    required this.backgroundColor,
    required this.titleColor,
    required this.subtitleColor,
  });
}
class CardBackground extends StatelessWidget {
  const CardBackground({required this.data, Key? key}) : super(key: key);

  final CardBackgroundData data;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image(image: data.image),
        Text(
          data.title.toUpperCase(),
          style: TextStyle(
            color: data.titleColor,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
        Text(
          data.subtittle,
          style: TextStyle(
            color: data.subtitleColor,
            fontSize: 16,
          ),
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}