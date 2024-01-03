import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mobile_app/configs/themes/app_colors.dart';
import 'package:mobile_app/controllers/auth_controller.dart';
import 'package:mobile_app/widgets/common/main_button.dart';

class LoginScreen extends GetView<AuthController> {
  const LoginScreen({Key? key}) : super(key: key);

  static const String routeName = "/login";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
              gradient: mainGradient()
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(),
              ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: SizedBox.fromSize(
                  size: Size.fromRadius(120), // Image radius
                  child: Image.asset(
                    "assets/images/parking_app.jpg",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Spacer(),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Hey There,\nWelcome Back',
                  style: TextStyle(
                    color: onSurfaceTextColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
              ),
              SizedBox(height: 10,),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Sign In to your account to continue',
                  style: TextStyle(
                    color: onSurfaceTextColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w600
                  ),
                ),
              ),
              Spacer(),
              MainButton(
                onTap: () {
                  controller.navigateToEmailSignInPage();
                },
                child: Stack(
                  children: [
                    Positioned(
                        top: 0,
                        bottom: 0,
                        left: -280,
                        child: SvgPicture.asset("assets/icons/mail-ios.svg")
                    ),
                    const Center(
                      child: Text(
                        "Sign In with Email",
                        style: TextStyle(
                          color: onSurfaceTextColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40,),
              MainButton(
                onTap: () {
                  showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) => const Center(child: CircularProgressIndicator(),)
                  );
                  controller.signInWithGoogle();
                },
                child: Stack(
                  children: [
                    Positioned(
                        top: 0,
                        bottom: 0,
                        left: 0,
                        child: SvgPicture.asset("assets/icons/google.svg")
                    ),
                    const Center(
                      child: Text(
                        "Sign In with Google",
                        style: TextStyle(
                          color: onSurfaceTextColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16,),
              RichText(
                text: TextSpan(
                  text: "Don't Have and Account?  ",
                  style: const TextStyle(
                      color: onSurfaceTextColor,
                      fontSize: 16
                  ),
                  children: [
                    TextSpan(
                      text: 'Sign Up',
                      recognizer: TapGestureRecognizer()..onTap=() => controller.navigateToEmailSignUpPage(),
                      style: const TextStyle(
                        decoration: TextDecoration.underline,
                        color: Color.fromARGB(255, 66, 66, 66),
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
              Spacer(),
            ],
          )
      ),
    );
  }
}