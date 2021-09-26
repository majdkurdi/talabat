import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:talabat/modals/order.dart';
import '../modals/meal.dart';
import '../modals/extra.dart';
import '../modals/location.dart';
import '../modals/rate.dart';
import '../modals/restaurant.dart';

class Firestore {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<List<Restaurant>> fetchRestaurants() async {
    List<Restaurant> rests = [];
    try {
      CollectionReference restsCollection = firestore.collection('restaurants');
      final fetchedData = (await restsCollection.get()).docs;
      for (var rest in fetchedData) {
        final restData = rest.data() as Map<String, dynamic>;
        final reviews = restData['rate']['reviews'] as List<dynamic>;
        final menu = restData['menu'] as List<dynamic>;

        rests.add(Restaurant(
            id: rest.id,
            hours: Map<String, String>.from(restData['hours']),
            name: restData['name'],
            logoUrl: restData['logoUrl'],
            coverUrl: restData['coverUrl'],
            description: restData['description'],
            location: Location(
                latitude: restData['location']['latitude'],
                longitude: restData['location']['longitude'],
                address: restData['location']['address']),
            rate: Rate(
                rate: restData['rate']['rate'],
                ratings: restData['rate']['ratings'],
                reviews: reviews.map((e) {
                  final order = List<String>.from(e['order']);
                  return Review(
                      name: e['name'],
                      rate: e['rate'],
                      review: e['review'],
                      order: order);
                }).toList()),
            deliveryCharge: restData['deliveryCharge'],
            delivery: restData['delivery'],
            menu: menu
                .map((e) => Meal(
                    id: e['meal']['id'],
                    title: e['meal']['title'],
                    imageUrl: e['meal']['imageUrl'],
                    price: e['meal']['price'],
                    description: e['meal']['description'],
                    extras: extras,
                    category: e['category']))
                .toList()));
      }
      print(rests[0].name);
      return rests;
    } on FirebaseException catch (e) {
      throw e;
    } on Exception catch (e) {
      throw e;
    }
  }

  Future<DocumentReference> addUser(String email, String mobile) async {
    try {
      CollectionReference users = firestore.collection('users');
      return await users.add(
          {'mobile': mobile, 'email': email, 'address': null, 'name': null});
    } on Exception catch (e) {
      throw e;
    }
  }

  Future getUser(String email) async {
    try {
      List<Map<String, String?>> profiles = [];
      CollectionReference users = firestore.collection('users');

      var usersList = (await users.get()).docs;
      usersList.forEach((element) {
        profiles.add(
            Map<String, String?>.from(element.data() as Map<String, dynamic>));
      });
      return profiles.where((element) => element['email'] == email).first;
    } on Exception catch (e) {
      throw e;
    }
  }

  Future updateUser(Map<String, String?> profile) async {
    try {
      CollectionReference users = firestore.collection('users');
      final userRef = (await users.get())
          .docs
          .where((element) =>
              (element.data() as Map<String, dynamic>)['email'] ==
              profile['email'])
          .first
          .reference;

      await userRef.update(profile);
    } on Exception catch (e) {
      throw e;
    }
  }

  Future addOrder(Order order, String email) async {
    try {
      CollectionReference orders = firestore.collection('orders');
      final userOrdersRef = (await orders.get())
          .docs
          .where((element) => (element['email'] == email))
          .first
          .reference;

      var userOrders = (await userOrdersRef.get())['orders'] as List<dynamic>;
      userOrders.add({
        'id': order.id,
        'date': order.date.toIso8601String(),
        'total': order.total,
        'address': order.address,
        'phoneNumber': order.phoneNumber,
        'items': order.items
            .map((e) => {
                  'id': e.id,
                  'quantity': e.quantity,
                  'title': e.title,
                  'price': e.price
                })
            .toList()
      });
      await userOrdersRef.update({'orders': userOrders});
    } on Exception catch (e) {
      throw e;
    }
  }

  Future<List> fetchOrders(String email) async {
    CollectionReference orders = firestore.collection('orders');
    final userOrdersRef = (await orders.get())
        .docs
        .where((element) => (element['email'] == email))
        .first
        .reference;

    return (await userOrdersRef.get())['orders'] as List<dynamic>;
  }

  Future addOrderList(String email) async {
    CollectionReference orders = firestore.collection('orders');
    await orders.add({'email': email, 'orders': []});
  }
}
