import 'package:flutter/cupertino.dart';

class Location {
  final double? latitude;
  final double? longitude;
  final String? address;
  Location({@required this.latitude, @required this.longitude, this.address});
}
