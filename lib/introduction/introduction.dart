import 'package:flutter/material.dart';
import 'package:mobile_app/configs/themes/app_colors.dart';
import 'package:mobile_app/widgets/app_circle_button.dart';
import 'package:get/get.dart';

class AppIntroduction extends StatelessWidget {
  const AppIntroduction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
            gradient: mainGradient()
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Get.width*0.1,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.car_repair, size: 100),
              SizedBox(height: 40,),
              const Text(
                'This is modern world parking application. You can choose your destination and reserve available parking space before you leave your door step. Be comfortable, enjoy your day.',
                textAlign: TextAlign.justify,
                style: TextStyle(
                    fontSize: 24,
                    color: onSurfaceTextColor,
                    fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(height: 40,),
              AppCircleButton(
                onTap: () => Get.offAndToNamed("/home"),  // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => HomeScreen()))
                child: const Icon(Icons.arrow_forward, size: 36,),
              )
            ],
          ),
        ),
      ),
    );
  }
}
