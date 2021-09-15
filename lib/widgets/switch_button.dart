import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SwitchButton extends StatelessWidget {
  final bool? value;
  final String? text1;
  final String? text2;
  final IconData? icon1;
  final IconData? icon2;

  final void Function()? onClick;

  SwitchButton(
      {@required this.value,
      @required this.text1,
      @required this.text2,
      @required this.onClick,
      this.icon1,
      this.icon2});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.size.height / 18,
      // width: Get.size.width,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: GestureDetector(
              onTap: !value! ? onClick : () {},
              child: Container(
                child: Center(
                    child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (icon1 != null) Icon(icon1),
                    Text(text1!),
                  ],
                )),
                decoration: BoxDecoration(
                    color: value! ? Colors.grey[700] : null,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        bottomLeft: Radius.circular(30)),
                    border: Border.all(
                        color: value! ? Colors.grey[700]! : Colors.grey)),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: value! ? onClick : () {},
              child: Container(
                child: Center(
                    child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (icon2 != null) Icon(icon2),
                    Text(text2!),
                  ],
                )),
                decoration: BoxDecoration(
                    color: !value! ? Colors.grey[700] : null,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(30),
                        bottomRight: Radius.circular(30)),
                    border: Border.all(
                        color: !value! ? Colors.grey[700]! : Colors.grey)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
