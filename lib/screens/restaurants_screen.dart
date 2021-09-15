import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/restaurants_controller.dart';
import '../widgets/switch_button.dart';
import '../widgets/error_card.dart';

const String image =
    'https://nieuwspaal.nl/wp-content/uploads/mcdonalds-fastfood-mac-mcdrive.jpg';

class Restaurants extends StatefulWidget {
  @override
  _RestaurantsState createState() => _RestaurantsState();
}

class _RestaurantsState extends State<Restaurants> {
  final restaurantsController = Get.find<RestaurantsController>();
  String searchText = '';
  bool delivery = true;
  bool loading = true;
  String? errMsg;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 0)).then(
      (value) async {
        final response = await restaurantsController.updateRestaurants();
        if (response == 'done') {
          setState(() => loading = false);
        } else {
          setState(() {
            errMsg = response;
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final restaurants = restaurantsController.restaurants;
    return Scaffold(
      body: Center(
        child: loading
            ? CircularProgressIndicator(
                valueColor:
                    AlwaysStoppedAnimation(Theme.of(context).primaryColor),
              )
            : Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 30, left: 15, right: 15),
                    child: TextField(
                      style: TextStyle(fontSize: 15),
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search, color: Colors.black),
                        hintText: 'Search',
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40.0),
                          borderSide: BorderSide(
                              color: Theme.of(context).primaryColor,
                              width: 3.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(35.0),
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      onChanged: (val) {
                        setState(() => searchText = val);
                      },
                    ),
                  ),
                  Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    width: Get.size.width,
                    height: Get.size.height / 18,
                    child: Row(
                      children: [
                        Expanded(
                          child: SwitchButton(
                            value: delivery,
                            text1: 'Delivery',
                            text2: 'Pick up',
                            onClick: () {
                              setState(() {
                                delivery = !delivery;
                              });
                            },
                            icon1: Icons.delivery_dining,
                            icon2: Icons.directions_walk,
                          ),
                        ),
                        SizedBox(width: 10),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.sort, color: Colors.black),
                                  Center(child: Text('Sort'))
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      elevation: 8,
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(8),
                                topRight: Radius.circular(8)),
                            child: FadeInImage(
                                height: Get.size.height / 5,
                                width: double.infinity,
                                fit: BoxFit.cover,
                                placeholder: AssetImage('assets/logo.jpg'),
                                image: NetworkImage(image)),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 4),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('N3N3 Chicken',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold)),
                                    Text('3.5\$ delivery',
                                        style: TextStyle(
                                          color: Colors.green,
                                          fontSize: 18,
                                        ))
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Lattakia, Port Said St',
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
                  )
                ],
              ),
      ),
    );
  }
}
