import 'package:flutter/material.dart';
import '../widgets/review_card.dart';
import '../modals/restaurant.dart';
import '../widgets/Rating_widget.dart';

class ReviewsScreen extends StatelessWidget {
  final Restaurant restaurant;
  ReviewsScreen(this.restaurant);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Reviews & Ratings'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Rating(rate: restaurant.rate.rate!),
              Text(
                '${restaurant.rate.ratings!} ratings',
                style: TextStyle(color: Colors.grey),
              ),
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Reviews (${restaurant.rate.reviews!.length}):',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                  ),
                ),
              ),
              ListView.builder(
                itemBuilder: (ctx, i) => ReviewCard(
                  restaurant.rate.reviews![i],
                ),
                itemCount: restaurant.rate.reviews!.length,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
              )
            ],
          ),
        ),
      ),
    );
  }
}
