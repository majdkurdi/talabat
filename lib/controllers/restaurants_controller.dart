import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../modals/restaurant.dart';
import '../services/firestore.dart';

class RestaurantsController extends GetxController {
  final restaurants = <Restaurant>[].obs;

  Future<String> updateRestaurants() async {
    try {
      final firestore = Firestore();
      restaurants.value = await firestore.fetchRestaurants();
      return 'done';
    } on FirebaseException catch (e) {
      return e.code;
    } on Exception catch (e) {
      return e.toString();
    }
  }
}
