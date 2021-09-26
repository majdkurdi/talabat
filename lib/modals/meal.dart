import 'package:flutter/cupertino.dart';
import './extra.dart';

class Meal {
  final String id;
  final String? title;
  final String? imageUrl;
  final double? price;
  final String? description;
  final List<Extra>? extras;
  final String? category;

  Meal(
      {required this.id,
      @required this.title,
      @required this.imageUrl,
      @required this.price,
      @required this.description,
      @required this.extras,
      @required this.category});
}
