import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../modals/restaurant.dart';

class RestaurantDetailsScreen extends StatelessWidget {
  final Restaurant restaurant;
  RestaurantDetailsScreen(this.restaurant);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('About'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                '${restaurant.description}.',
                style: TextStyle(fontSize: 15),
              ),
            ),
            Stack(children: [
              Container(
                width: Get.size.width,
                height: Get.size.width - 20,
                child: GoogleMap(
                  initialCameraPosition: CameraPosition(
                      target: LatLng(restaurant.location.latitude!,
                          restaurant.location.longitude!),
                      zoom: 11),
                  liteModeEnabled: true,
                ),
              ),
              GestureDetector(
                onTap: () async {
                  if (await canLaunch(
                      'https://www.google.com/maps/place/${restaurant.location.latitude!},${restaurant.location.longitude!}')) {
                    launch(
                        'https://www.google.com/maps/place/${restaurant.location.latitude!},${restaurant.location.longitude!}');
                  }
                },
                child: Container(
                  color: Colors.white.withOpacity(0),
                  width: Get.size.width,
                  height: Get.size.width - 20,
                ),
              ),
            ]),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  'Hours',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
            ),
            ListView(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              children: days
                  .map((e) => Row(
                        children: [
                          SizedBox(width: 20),
                          Text(
                            '$e:',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 17),
                          ),
                          SizedBox(width: 20),
                          Text(
                            restaurant.hours![e]!,
                            style: TextStyle(fontSize: 17),
                          ),
                        ],
                      ))
                  .toList(),
            ),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}
