import 'package:flutter/material.dart';
import '../modals/rate.dart';

import 'Rating_widget.dart';
import 'meal_chip.dart';

class ReviewCard extends StatelessWidget {
  final Review review;
  ReviewCard(this.review);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Card(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(child: Text(review.name!.substring(0, 1))),
                      SizedBox(
                        width: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Rating(
                              rate: review.rate!,
                              size: 20,
                            ),
                            Text(review.name!,
                                style: TextStyle(fontWeight: FontWeight.bold))
                          ],
                        ),
                      ),
                    ],
                  ),
                  Align(
                      alignment: Alignment.topRight,
                      child: Text('Sun, Aug 22, 2021')),
                ],
              ),
            ),
            Align(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  review.review!,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
              alignment: Alignment.centerLeft,
            ),
            Align(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                child: Text('${review.name!} ordered:'),
              ),
              alignment: Alignment.centerLeft,
            ),
            GridView.builder(
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 165, childAspectRatio: 3 / 1),
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (ctx, i) => Container(
                height: 50,
                child: MealChip(
                  label: review.order![i],
                ),
              ),
              itemCount: review.order!.length,
            ),
            SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }
}
