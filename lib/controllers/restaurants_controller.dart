import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../modals/restaurant.dart';
import '../services/firestore.dart';

enum SortBy { Rate, Alphabete }

class RestaurantsController extends GetxController {
  final restaurants = <Restaurant>[].obs;
  final deliveryRestaurants = <Restaurant>[].obs;

  Future<String> updateRestaurants() async {
    try {
      final firestore = Firestore();
      restaurants.value = await firestore.fetchRestaurants();
      deliveryRestaurants.value =
          restaurants.where((element) => element.delivery).toList();
      return 'done';
    } on FirebaseException catch (e) {
      return e.code;
    } on Exception catch (e) {
      return e.toString();
    }
  }

  void sortRestaurants(SortBy sort) {
    if (sort == SortBy.Alphabete) {
      restaurants.sort((a, b) => a.name.compareTo(b.name));
      deliveryRestaurants.sort((a, b) => a.name.compareTo(b.name));
      print(1);
    } else {
      restaurants.sort((a, b) => b.rate.rate!.compareTo(a.rate.rate!));
      deliveryRestaurants.sort((a, b) => a.rate.rate!.compareTo(b.rate.rate!));
      print(2);
    }
  }
}
