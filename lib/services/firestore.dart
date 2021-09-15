import 'package:cloud_firestore/cloud_firestore.dart';
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

        rests.add(Restaurant(
            id: rest.id,
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
                      rate: e['rate'], review: e['review'], order: order);
                }).toList()),
            menu: null));
      }
      print(rests[0].name);
      return rests;
    } on FirebaseException catch (e) {
      throw e;
    }
  }
}
