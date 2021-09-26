import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/cart_controller.dart';
import '../controllers/orders_controller.dart';
import '../controllers/auth_controller.dart';

import '../modals/cart_item.dart';
// import '../views/add_order_screen.dart';
import '../widgets/cart_item_card.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final cartController = Get.find<CartController>();
  final ordersController = Get.find<OrdersController>();
  final authController = Get.find<AuthController>();
  bool loading = false;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<CartItem> items = cartController.cart;
    double total = cartController.total;
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Card(
              margin: EdgeInsets.all(15),
              child: ListTile(
                leading: Icon(Icons.payment),
                title: Text(
                  'Total Amount:',
                  textAlign: TextAlign.center,
                ),
                trailing: Text('$total \$'),
              ),
            ),
            Text(
              'Your Meals:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            if (items.isEmpty)
              Container(
                height: 100,
                child: Center(
                  child: Text('Start adding meals to the Cart!'),
                ),
              ),
            ListView.builder(
              itemBuilder: (ctx, i) => CartItemCard(i + 1, items[i], () {
                setState(() {});
              }),
              itemCount: items.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(items.isEmpty
                        ? Colors.grey
                        : Theme.of(context).primaryColor)),
                onPressed: loading
                    ? null
                    : () async {
                        if (items.isNotEmpty) {
                          if (!authController.profile.values.contains(null)) {
                            setState(() => loading = true);
                            await ordersController.addOrder(
                                date: DateTime.now(),
                                total: total,
                                items: items,
                                address: authController.profile['address']!,
                                phoneNumber: int.parse(
                                    authController.profile['mobile']!),
                                email: authController.profile['email']!);

                            cartController.cart.value = <CartItem>[];
                            setState(() => loading = false);
                          } else {
                            Get.snackbar('error!',
                                'Some info are missing, go to account page and complete your information!');
                          }
                        } else
                          Get.snackbar('Warning', 'There is No items to Order!',
                              snackPosition: SnackPosition.BOTTOM);
                      },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      loading
                          ? CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation(Colors.white),
                            )
                          : Icon(Icons.shopping_bag),
                      SizedBox(width: 10),
                      Text('Order Now!')
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
