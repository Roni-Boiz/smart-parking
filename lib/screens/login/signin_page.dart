import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobile_app/configs/themes/app_colors.dart';
import 'package:mobile_app/configs/themes/app_icons.dart';
import 'package:mobile_app/controllers/auth_controller.dart';
import 'package:get/get.dart';
import 'package:mobile_app/widgets/common/main_button.dart';

class SignInPage extends GetView<AuthController> {
  SignInPage({Key? key}) : super(key: key);

  static const String routeName = "/emailSignIn";
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(0),
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
                gradient: mainGradient()
            ),
            width: w,
            height: h,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(25),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: SizedBox.fromSize(
                      size: const Size.fromRadius(80), // Image radius
                      child: Image.asset(
                        "assets/images/parking_app.jpg",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
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
                const SizedBox(height: 10,),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Sign In with your Email and Password',
                    style: TextStyle(
                        color: onSurfaceTextColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w600
                    ),
                  ),
                ),
                const SizedBox(height: 50,),
                TextField(
                  controller: emailController,
                  cursorColor: Colors.white,
                  textInputAction: TextInputAction.done,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontFamily: AppIcons.fontFam,
                  ),
                  decoration: InputDecoration(
                    labelText: 'Email Address',
                    labelStyle: const TextStyle(
                      color: Colors.white,
                    ),
                    prefixIcon: const Icon(Icons.email, color: Colors.white, size: 30,),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(
                            color: Colors.white,
                            width: 1.0
                        )
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(
                            color: Colors.white,
                            width: 1.0
                        )
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                const SizedBox(height: 25,),
                TextField(
                  controller: passwordController,
                  textInputAction: TextInputAction.done,
                  cursorColor: Colors.white,
                  obscureText: true,
                  style: const TextStyle(
                    fontSize: 20,
                    fontFamily: AppIcons.fontFam,
                    color: Colors.white,
                  ),
                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: const TextStyle(
                      color: Colors.white,
                    ),
                    prefixIcon: const Icon(Icons.visibility_off, color: Colors.white, size: 30,),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(
                            color: Colors.white,
                            width: 1.0
                        )
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(
                            color: Colors.white,
                            width: 1.0
                        )
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                const SizedBox(height: 20,),
                GestureDetector(
                  child: Row(
                    children: [
                      Expanded(child: Container(),),
                      const Text(
                        "Forget your Password?",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontFamily: AppIcons.fontFam,
                        ),
                      ),
                    ],
                  ),
                  onTap: () => controller.navigateToForgotPasswordPage(),
                ),
                const SizedBox(height: 40,),
                MainButton(
                  onTap: () {
                    showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) => const Center(child: CircularProgressIndicator(),)
                    );
                    controller.login(emailController.text.trim(), passwordController.text.trim());
                  },
                  child: Stack(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SvgPicture.asset("assets/icons/lock-open-rounded.svg"),
                          const SizedBox(width: 10,),
                          const Center(
                            child: Text("Sign In",
                              style: TextStyle(
                                color: onSurfaceTextColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10,),
                RichText(
                  text: TextSpan(
                    text: "Don\'t have an account? ",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                    children: [
                      TextSpan(
                        text: "Sign Up",
                        style: const TextStyle(
                          color: Color.fromARGB(255, 66, 66, 66),
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline
                        ),
                        recognizer: TapGestureRecognizer()..onTap=() => controller.navigateToEmailSignUpPage()
                      )
                    ]
                    )
                ),
                Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

