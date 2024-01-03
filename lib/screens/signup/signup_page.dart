import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mobile_app/configs/themes/app_colors.dart';
import 'package:mobile_app/configs/themes/app_icons.dart';
import 'package:mobile_app/controllers/auth_controller.dart';
import 'package:mobile_app/widgets/common/main_button.dart';

class SignUpPage extends GetView<AuthController> {
  SignUpPage({Key? key}) : super(key: key);

  static const String routeName = "/emailSignUp";
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var displayNameController = TextEditingController();
  String? accountType;

  @override
  Widget build(BuildContext context) {

    final formKey = GlobalKey<FormState>();
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    final _customerTypes = ["Customer Only", "Business Only", "Customer & Business"];

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
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(25),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: SizedBox.fromSize(
                        size: Size.fromRadius(80), // Image radius
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
                      'Hey There,\nWelcome to Smart Parking',
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
                      'Sign Up with a Email and Password',
                      style: TextStyle(
                          color: onSurfaceTextColor,
                          fontSize: 20,
                          fontWeight: FontWeight.w600
                      ),
                    ),
                  ),
                  const SizedBox(height: 30,),
                  TextFormField(
                    controller: displayNameController,
                    cursorColor: Colors.white,
                    textInputAction: TextInputAction.next,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontFamily: AppIcons.fontFam,
                    ),
                    decoration: InputDecoration(
                      labelText: 'Display Name',
                      labelStyle: const TextStyle(
                        color: Colors.white,
                      ),
                      prefixIcon: const Icon(Icons.person, color: Colors.white, size: 30,),
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
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (name) =>
                    name != null && !RegExp(r"^\s*([A-Za-z]{1,}([\.,]|[-']| )?)+[A-Za-z]+\.?\s*$").hasMatch(name.trim())
                        ? 'Enter a valid name'
                        : null,
                  ),
                  const SizedBox(height: 20,),
                  TextFormField(
                    controller: emailController,
                    cursorColor: Colors.white,
                    textInputAction: TextInputAction.next,
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
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (name) {
                      if(name != null && !EmailValidator.validate(name)){
                        return 'Enter a valid email';
                      }else{
                        return null;
                      }
                    }
                  ),
                  const SizedBox(height: 20,),
                  TextFormField(
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
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if(value != null && value.length < 8){
                        return 'Enter min 8 characters';
                      }else if(value != null && !RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\><*~]).{8,}$').hasMatch(value)){
                        return 'Password must contain simple, capital letters, numbers and special characters';
                      }else{
                        return null;
                      }
                    }
                  ),
                  const SizedBox(height: 20,),
                  DropdownButtonFormField(
                    value: accountType,
                    items: _customerTypes.map(
                      (val) => DropdownMenuItem(child: Text(val), value: val)
                    ).toList(),
                    onChanged: (val){
                      accountType = val as String;
                    },
                    style: const TextStyle(
                      fontSize: 20,
                      fontFamily: AppIcons.fontFam,
                      color: Colors.white,
                    ),
                    icon: const Icon(Icons.expand_circle_down_outlined, color: Colors.white, size: 25,),
                    decoration: InputDecoration(
                      labelText: 'Account Type',
                      labelStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 20
                      ),
                      prefixIcon: const Icon(Icons.account_circle, color: Colors.white, size: 30,),
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
                    dropdownColor: const Color(0xFF2e3c62),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value == null) {
                        return 'Please select your account type';
                      }
                    },
                  ),
                  const SizedBox(height: 20,),
                  MainButton(
                    onTap: () {
                      final isValid = formKey.currentState!.validate();
                      if(!isValid) return;
                      showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) => const Center(child: CircularProgressIndicator(),)
                      );
                      controller.register(displayNameController.text.trim(), emailController.text.trim(), passwordController.text.trim(), accountType.toString());
                    },
                    child: Stack(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            SvgPicture.asset("assets/icons/sign-in-bold.svg", width: 32, height: 32,),
                            const SizedBox(width: 10,),
                            const Center(
                              child: Text("Sign Up",
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
                          text: "Have an account? ",
                          style: const TextStyle(
                            color: onSurfaceTextColor,
                            fontSize: 20,
                          ),
                          children: [
                            TextSpan(
                                text: "Sign In",
                                style: const TextStyle(
                                    color: Color.fromARGB(255, 66, 66, 66),
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline
                                ),
                                recognizer: TapGestureRecognizer()..onTap=() => controller.navigateToEmailSignInPage()
                            )
                          ]
                      )
                  ),
                  const SizedBox(height: 20,),
                  RichText(text: const TextSpan(
                      text: "--------------------  Or  --------------------",
                      style: TextStyle(
                        color: onSurfaceTextColor,
                        fontSize: 17,
                      )
                  )),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Color.alphaBlend(const Color(0xFF3ac3cb), const Color(0xFFf85187)),
                          width: 2
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    margin: const EdgeInsets.only(top: 16, bottom: 16),
                    child: MainButton(
                      onTap: () {
                        controller.signInWithGoogle();
                      },
                      color: Colors.grey[300],
                      child: Stack(
                        children: [
                          Positioned(
                              top: 0,
                              bottom: 0,
                              left: 0,
                              child: SvgPicture.asset("assets/icons/google.svg")
                          ),
                          Center(
                            child: Text(
                              "Sign up with Google",
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );

  }
}
