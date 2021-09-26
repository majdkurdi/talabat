import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../screens/restaurant_screen.dart';
import '../modals/restaurant.dart';

// const String image =
//     'https://nieuwspaal.nl/wp-content/uploads/mcdonalds-fastfood-mac-mcdrive.jpg';

class RestaurantCard extends StatelessWidget {
  final Restaurant? restaurant;
  RestaurantCard({@required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: GestureDetector(
        onTap: () {
          Get.to(() => RestaurantScreen(restaurant!));
        },
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          elevation: 8,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8), topRight: Radius.circular(8)),
                child: FadeInImage(
                    height: Get.size.height / 5,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    placeholder: AssetImage('assets/logo.jpg'),
                    image: NetworkImage(restaurant!.coverUrl)),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(restaurant!.name,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        Text('${restaurant!.deliveryCharge}\$ delivery',
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: 18,
                            ))
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(restaurant!.location.address!,
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 18,
                            )),
                        Text('30-35 min',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 18,
                            ))
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
