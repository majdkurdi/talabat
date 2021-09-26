import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ErrorCard extends StatelessWidget {
  final String errMsg;
  ErrorCard(this.errMsg);
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        height: Get.size.height / 3,
        width: Get.size.width / 1.2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.error,
                size: 70,
                color: Theme.of(context).primaryColor,
              ),
            ),
            Text(errMsg),
            ElevatedButton(
              child: Text(
                'Try Again!',
                style: TextStyle(color: Theme.of(context).accentColor),
              ),
              onPressed: () {},
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                      Theme.of(context).primaryColor)),
            )
          ],
        ),
      ),
    );
  }
}
