import 'package:flutter/cupertino.dart';

class Rate {
  final int? rate;
  final int? ratings;
  final List<Review>? reviews;

  Rate({@required this.rate, @required this.ratings, @required this.reviews});
}

class Review {
  final String? name;
  final int? rate;
  final String? review;
  final List<String>? order;

  Review(
      {@required this.rate,
      @required this.review,
      @required this.order,
      @required this.name});
}
