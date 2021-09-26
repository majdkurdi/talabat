import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:talabat/controllers/cart_controller.dart';
import '../modals/meal.dart';

class MealCard extends StatefulWidget {
  MealCard({
    required this.meal,
    Key? key,
  }) : super(key: key);
  final Meal meal;

  @override
  _MealCardState createState() => _MealCardState();
}

class _MealCardState extends State<MealCard> {
  int? quantity = 1;
  final cartController = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: GestureDetector(
        onTap: () {
          Get.defaultDialog(
              title: 'Add this meal to your order',
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
              textConfirm: 'Add Meal',
              confirmTextColor: Theme.of(context).primaryColor,
              cancelTextColor: Theme.of(context).primaryColor,
              onConfirm: () {
                if (quantity != null) {
                  cartController.addToCart(widget.meal, quantity!);
                  Get.back();
                  Get.snackbar('Done!', 'Meal added to your Order!');
                } else {
                  Get.snackbar('Error!', 'Enter the quantity you need');
                }
              },
              onCancel: () {
                quantity = 1;
              });
        },
        child: Card(
            child: Row(
          children: [
            Container(
              width: Get.size.width / 3,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(3),
                    bottomLeft: Radius.circular(3)),
                child: Stack(children: [
                  FadeInImage(
                      placeholder: AssetImage('assets/logo.jpg'),
                      image: NetworkImage(widget.meal.imageUrl!)),
                  Positioned(
                    top: 2,
                    left: 2,
                    child: Chip(
                      backgroundColor: Colors.white,
                      label: Text(
                        '${widget.meal.price}\$',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ]),
              ),
            ),
            SizedBox(width: 10),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      widget.meal.title!,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      widget.meal.description!,
                    )
                  ],
                ),
              ),
            )
          ],
        )),
      ),
    );
  }
}
