import 'package:flutter/material.dart';
import 'package:get/get.dart';

import './login_screen.dart';
import '../widgets/my_step_content.dart';

class IntroScreen extends StatefulWidget {
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  int currStep = 0;

  @override
  Widget build(BuildContext context) {
    final stepTitleStyle = TextStyle(
        fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor);
    List<Step> mySteps = [
      Step(
          title: Text(
            'Fast',
            style: stepTitleStyle,
          ),
          content: MyStepContent('assets/fast.png', 'High Speed Delivery'),
          isActive: true),
      Step(
          title: Text(
            'Free',
            style: stepTitleStyle,
          ),
          content: MyStepContent(
              'assets/free.png', 'Pay For Your Meal With No Extra Charge'),
          isActive: currStep >= 1),
      Step(
          title: Text(
            'Easy',
            style: stepTitleStyle,
          ),
          content:
              MyStepContent('assets/easy.png', 'Few Clicks To Order Your Meal'),
          isActive: currStep >= 2),
    ];
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: Stepper(
          controlsBuilder: (context, {onStepContinue, onStepCancel}) => Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              if (currStep != 0)
                ElevatedButton(
                  onPressed: onStepCancel,
                  child: Icon(
                    Icons.arrow_back,
                    color: Theme.of(context).accentColor,
                  ),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          Theme.of(context).primaryColor)),
                ),
              if (currStep == 0) SizedBox(width: 20),
              SizedBox(width: 20),
              ElevatedButton(
                onPressed: onStepContinue,
                child: Icon(
                  currStep == mySteps.length - 1
                      ? Icons.done
                      : Icons.arrow_forward,
                  color: Theme.of(context).accentColor,
                ),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        Theme.of(context).primaryColor)),
              ),
            ],
          ),
          physics: NeverScrollableScrollPhysics(),
          type: StepperType.horizontal,
          currentStep: currStep,
          onStepContinue: () {
            if (currStep < mySteps.length - 1) {
              setState(() {
                currStep++;
              });
            } else {
              print('completed');
              Get.off(() => LoginScreen());
            }
          },
          onStepCancel: () {
            if (currStep > 0) {
              setState(() {
                currStep--;
              });
            }
          },
          onStepTapped: (i) {
            setState(() {
              currStep = i;
            });
          },
          steps: mySteps,
        ),
      ),
    );
  }
}
