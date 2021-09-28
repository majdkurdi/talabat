import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:talabat/widgets/meal_card.dart';
import '../screens/reviews_screen.dart';
import '../screens/restaurant_details_screen.dart';
import '../modals/restaurant.dart';
import '../widgets/Rating_widget.dart';

class RestaurantScreen extends StatelessWidget {
  final Restaurant restaurant;

  RestaurantScreen(this.restaurant);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(children: [
              Container(
                child: Column(
                  children: [
                    FadeInImage(
                      placeholder: AssetImage('assets/logo.jpg'),
                      image: NetworkImage(restaurant.coverUrl),
                      height: Get.size.height / 2.5,
                      width: Get.size.width,
                      fit: BoxFit.cover,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            restaurant.name,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 25),
                          ),
                          Text(
                            restaurant.location.address!,
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 18,
                            ),
                          ),
                          Row(
                            children: [
                              Rating(rate: restaurant.rate.rate!),
                              Text(
                                '${restaurant.rate.ratings!} ratings',
                                style: TextStyle(color: Colors.grey),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  width: Get.size.width / 4,
                  height: Get.size.width / 4,
                  child: FadeInImage(
                    fit: BoxFit.fill,
                    placeholder: AssetImage('assets/logo.jpg'),
                    image: NetworkImage(restaurant.logoUrl),
                  ),
                ),
                top: Get.size.height / 3,
                right: 10,
              ),
            ]),
            Divider(
              color: Theme.of(context).primaryColor,
              indent: 10,
              endIndent: 10,
            ),
            Row(
              children: [
                SizedBox(
                  width: 20,
                ),
                TextButton(
                  child: Text('About',
                      style: TextStyle(
                          color: Theme.of(context).primaryColor, fontSize: 20)),
                  onPressed: () {
                    Get.to(() => RestaurantDetailsScreen(restaurant));
                  },
                ),
                TextButton(
                  child: Text(
                    'Reviews',
                    style: TextStyle(
                        color: Theme.of(context).primaryColor, fontSize: 20),
                  ),
                  onPressed: () {
                    Get.to(() => ReviewsScreen(restaurant));
                  },
                )
              ],
            ),
            Divider(
              color: Theme.of(context).primaryColor,
              indent: 10,
              endIndent: 10,
            ),
            ListView.builder(
              itemBuilder: (ctx, i) => MealCard(meal: restaurant.menu[i]),
              itemCount: restaurant.menu.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
            ),
          ],
        ),
      ),
    );
  }
}
