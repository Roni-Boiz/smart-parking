import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobile_app/configs/themes/app_colors.dart';
import 'package:mobile_app/controllers/auth_controller.dart';
import 'package:mobile_app/main.dart';
import 'package:mobile_app/widgets/common/main_button.dart';
import 'package:get/get.dart';

class ForgotPasswordPage extends GetView<AuthController> {
  ForgotPasswordPage({Key? key}) : super(key: key);
  static const String routeName = "/forgotPassword";

  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Reset Password'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(25),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: SizedBox.fromSize(
                      size: Size.fromRadius(120), // Image radius
                      child: Image.asset(
                        "assets/images/parking_app.jpg",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                const Text('Receive an email to\nreset your password',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24),
                ),
                const SizedBox(height: 20,),
                TextFormField(
                  controller: emailController,
                  cursorColor: Colors.white,
                  textInputAction: TextInputAction.done,
                  style: const TextStyle(fontSize: 20),
                  decoration: const InputDecoration(labelText: "Email Address"),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (email) =>
                  email != null && !EmailValidator.validate(email)
                      ? 'Enter a valid email'
                      : null,
                ),
                const SizedBox(height: 20,),
                MainButton(
                  onTap: () {
                    showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) => const Center(child: CircularProgressIndicator(),)
                    );
                    controller.verifyEmail(emailController.text.trim());
                  },
                  child: Stack(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SvgPicture.asset("assets/icons/email.svg", color: Colors.white, width: 20, height: 20,),
                          const SizedBox(width: 10,),
                          const Center(
                            child: Text("Reset Password",
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
