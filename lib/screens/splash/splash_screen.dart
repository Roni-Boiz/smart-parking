import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_app/configs/themes/app_colors.dart';
import 'package:mobile_app/configs/themes/app_icons.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(gradient: mainGradient()),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              const Text("Smart Parking Application",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontFamily: AppIcons.fontFam,
                ),
              ),
              const SizedBox(height: 80,),
              ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: SizedBox.fromSize(
                  size: const Size.fromRadius(120), // Image radius
                  child: Image.asset(
                    "assets/images/parking_app.jpg",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const Spacer(),
            ],
          ),
        )

      ),
    );
  }
}
