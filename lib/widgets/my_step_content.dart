import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyStepContent extends StatelessWidget {
  final String asset;
  final String text;

  MyStepContent(this.asset, this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.size.height * 0.7,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            flex: 2,
            child: Image(
              image: AssetImage(asset),
              height: Get.size.height / 2,
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
          )
        ],
      ),
    );
  }
}
