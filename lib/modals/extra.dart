import 'package:flutter/cupertino.dart';

class Extra {
  final String? title;
  final String? description;
  final double? price;

  Extra(
      {@required this.title, @required this.description, @required this.price});
}

List<Extra> extras = [
  Extra(
      title: 'cheese',
      description: 'extra slice of american cheese',
      price: 3.5),
  Extra(title: 'katchup', description: 'extra katchup', price: 0.5),
  Extra(title: 'egg', description: 'slice of egg', price: 1.2),
  Extra(title: 'hot sauce', description: 'spicy hot sauce', price: 0.5)
];
