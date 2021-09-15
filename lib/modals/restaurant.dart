import 'package:flutter/cupertino.dart';

import './meal.dart';
import './rate.dart';
import './location.dart';

class Restaurant {
  final String? id;
  final String? name;
  final String? logoUrl;
  final String? coverUrl;
  final Location? location;
  final Rate? rate;
  final String? description;
  final List<Meal>? menu;

  Restaurant(
      {@required this.id,
      @required this.name,
      @required this.logoUrl,
      @required this.coverUrl,
      @required this.description,
      @required this.location,
      @required this.rate,
      @required this.menu});
}
