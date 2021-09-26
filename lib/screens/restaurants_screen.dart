import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/restaurants_controller.dart';
import '../widgets/switch_button.dart';
import '../widgets/error_card.dart';
import '../widgets/restaurant_card.dart';

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
    final deliveryRestaurants = restaurantsController.deliveryRestaurants;

    final searchRes =
        restaurants.where((e) => e.name.contains(searchText)).toList();
    return Scaffold(
      body: loading
          ? Center(
              child: CircularProgressIndicator(
                valueColor:
                    AlwaysStoppedAnimation(Theme.of(context).primaryColor),
              ),
            )
          : SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
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
                              child: GestureDetector(
                                onTap: () {
                                  Get.bottomSheet(
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          border:
                                              Border.all(color: Colors.white),
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(20),
                                              topRight: Radius.circular(20))),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            ListView.builder(
                                              shrinkWrap: true,
                                              itemCount: SortBy.values.length,
                                              itemBuilder: (ctx, i) => Column(
                                                children: [
                                                  GestureDetector(
                                                    child: Text(
                                                        SortBy.values[i]
                                                            .toString()
                                                            .split('.')[1],
                                                        style: TextStyle(
                                                            fontSize: 20)),
                                                    onTap: () {
                                                      restaurantsController
                                                          .sortRestaurants(
                                                              SortBy.values[i]);
                                                      setState(() {});
                                                      Get.back();
                                                    },
                                                  ),
                                                  Divider()
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                child: Row(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.sort, color: Colors.black),
                                    Center(child: Text('Sort'))
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  errMsg != null
                      ? ErrorCard(errMsg!)
                      : ListView.builder(
                          itemBuilder: (ctx, i) => RestaurantCard(
                            restaurant: searchText == ''
                                ? delivery
                                    ? deliveryRestaurants[i]
                                    : restaurants[i]
                                : searchRes[i],
                          ),
                          itemCount: searchText == ''
                              ? delivery
                                  ? deliveryRestaurants.length
                                  : restaurants.length
                              : searchRes.length,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                        ),
                ],
              ),
            ),
    );
  }
}
