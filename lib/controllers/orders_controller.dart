import 'package:get/get.dart';
import '../modals/order.dart';
import '../modals/cart_item.dart';
import '../services/firestore.dart';

class OrdersController extends GetxController {
  final orders = <Order>[].obs;
  final firestore = Firestore();

  Future updateOrders(String email) async {
    List<Order> fetchedOrders = [];
    final data = await firestore.fetchOrders(email);
    data.forEach((e) {
      final itemsData = e['items'] as List<dynamic>;
      fetchedOrders.add(Order(
          date: DateTime.parse(e['date']),
          items: itemsData
              .map((ele) => CartItem(
                  id: ele['id'],
                  title: ele['title'],
                  price: ele['price'],
                  quantity: ele['quantity']))
              .toList(),
          total: e['total'],
          address: e['address'],
          phoneNumber: e['phoneNumber'],
          id: e['id']));
    });
    orders.value = fetchedOrders;
  }

  Future addOrder(
      {required DateTime date,
      required double total,
      required List<CartItem> items,
      required String address,
      required int phoneNumber,
      required String email}) async {
    final newOrder = Order(
        phoneNumber: phoneNumber,
        total: total,
        date: date,
        items: items,
        address: address,
        id: DateTime.now().toString());
    final response = await firestore.addOrder(newOrder, email);
    if (response != null) {
      return 'done';
    }
  }
}
