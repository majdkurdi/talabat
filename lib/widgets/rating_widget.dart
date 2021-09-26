import 'package:flutter/material.dart';

class Rating extends StatelessWidget {
  const Rating({Key? key, required this.rate, this.size}) : super(key: key);

  final int rate;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (int i = 0; i < rate; i++)
          Icon(
            Icons.star,
            color: Theme.of(context).primaryColor,
            size: size,
          ),
        for (int i = 0; i < 5 - rate; i++)
          Icon(
            Icons.star,
            color: Colors.grey,
          ),
        SizedBox(width: 10),
      ],
    );
  }
}
