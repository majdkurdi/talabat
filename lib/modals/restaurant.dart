import 'package:flutter/cupertino.dart';

import './meal.dart';
import './rate.dart';
import './location.dart';

class Restaurant {
  final String id;
  final String name;
  final String logoUrl;
  final String coverUrl;
  final Location location;
  final Rate rate;
  final String description;
  final List<Meal> menu;
  final double deliveryCharge;
  final bool delivery;
  final Map<String, String>? hours;

  Restaurant(
      {required this.id,
      required this.name,
      required this.logoUrl,
      required this.coverUrl,
      required this.description,
      required this.location,
      required this.rate,
      required this.menu,
      required this.deliveryCharge,
      required this.delivery,
      required this.hours});
}

const List<String> days = ['sun', 'mon', 'tue', 'wed', 'thu', 'fri', 'sat'];
