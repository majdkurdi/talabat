import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/cart_controller.dart';
import '../modals/cart_item.dart';

class CartItemCard extends StatefulWidget {
  final int index;
  final CartItem item;
  final Function function;
  CartItemCard(this.index, this.item, this.function);

  @override
  _CartItemCardState createState() => _CartItemCardState();
}

class _CartItemCardState extends State<CartItemCard> {
  final cartController = Get.find<CartController>();
  int? quantity = 1;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: GlobalKey(),
      onDismissed: (_) async {
        await Get.defaultDialog(
            title: 'How many items you want to remove?',
            content: Column(
              children: [
                ListTile(
                    leading: Text('Quantity:'),
                    title: TextField(
                      keyboardType: TextInputType.number,
                      onChanged: (val) {
                        quantity = int.tryParse(val);
                      },
                      decoration: InputDecoration(hintText: '1'),
                    )),
              ],
            ),
            textCancel: 'Cancel',
            textConfirm: 'Remove',
            confirmTextColor: Theme.of(context).primaryColor,
            cancelTextColor: Theme.of(context).primaryColor,
            onConfirm: () {
              if (quantity != null) {
                Get.back();
              } else {
                Get.snackbar(
                    'Error!', 'Enter the quantity you need to remove!');
              }
            },
            onCancel: () {
              quantity = 1;
            });
        cartController.removeFromCart(widget.item, quantity!);
        widget.function();
      },
      direction: DismissDirection.endToStart,
      child: Card(
        child: ListTile(
          leading: Text('${widget.index}',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          title: Text(widget.item.title),
          trailing: Text('${widget.item.price}\$   X${widget.item.quantity}'),
        ),
      ),
    );
  }
}
