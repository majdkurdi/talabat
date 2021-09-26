import './cart_item.dart';

class Order {
  final String id;
  final DateTime date;
  final List<CartItem> items;
  final double total;
  final String address;
  final int phoneNumber;

  Order({
    required this.date,
    required this.items,
    required this.total,
    required this.address,
    required this.phoneNumber,
    required this.id,
  });
}
