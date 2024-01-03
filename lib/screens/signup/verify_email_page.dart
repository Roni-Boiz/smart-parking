import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobile_app/configs/themes/app_colors.dart';
import 'package:mobile_app/controllers/auth_controller.dart';
import 'package:mobile_app/main.dart';
import 'package:mobile_app/screens/home/home_screen.dart';
import 'package:get/get.dart';
import 'package:mobile_app/widgets/common/main_button.dart';

class VerifyEmailPage extends StatefulWidget {
  const VerifyEmailPage({Key? key}) : super(key: key);

  static const String routeName = "/verifyAccount";

  @override
  State<VerifyEmailPage> createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {

  bool isEmailVerified  = false;
  bool canResendEmail =  false;
  Timer? timer;
  final String? displayName = Get.arguments['displayName'];
  final String email = Get.arguments['email'];

  @override
  void initState() {
    super.initState();

    // user needs to be created before
    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;

    if(!isEmailVerified){
      sendVerificationEmail();

      timer = Timer.periodic(
        const Duration(seconds: 2),
          (_) => checkEmailVerified(),
      );
    }
  }

  @override
  void dispose(){
    timer?.cancel();
    super.dispose();
  }

  Future checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser!.reload();
    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });

    if(isEmailVerified) timer?.cancel();
  }

  Future sendVerificationEmail() async{
    try{
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();
      Get.snackbar("Register user", "Verification message",
          backgroundColor: Colors.greenAccent,
          snackPosition: SnackPosition.TOP,
          icon: const Icon(Icons.send, size: 32),
          titleText: const Text(
            "Verification Email Send",
            style: TextStyle(
                color: Colors.white
            ),
          ),
          messageText: Text(
            'Hello $displayName, Please verify your account through following email - $email',
            style: const TextStyle(
                color: Colors.white
            ),
          )
      );
      setState(() {
        canResendEmail = false;
      });
      await Future.delayed(const Duration(seconds: 10));
      setState(() {
        canResendEmail = true;
      });
    }on Exception catch(error){
      Get.snackbar("Register user", "Verification message",
        backgroundColor: Colors.redAccent,
        snackPosition: SnackPosition.TOP,
        icon: const Icon(Icons.error_outline, size: 32),
        titleText: const Text(
          "Verification Email Abort",
          style: TextStyle(
              color: Colors.white
          ),
        ),
        messageText: Text(
          error.toString(),
          style: const TextStyle(
              color: Colors.white
          ),
        )
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if(isEmailVerified){
      return HomeScreen(displayName: displayName, email: email,);
    }else {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Verify Email'),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(25),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: SizedBox.fromSize(
                      size: const Size.fromRadius(120), // Image radius
                      child: Image.asset(
                        "assets/images/parking_app.jpg",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Text('A verification email has been sent to your email ($email)',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 24),
                ),
                const SizedBox(height: 24,),
                MainButton(
                  onTap: () {
                    if(canResendEmail){
                      sendVerificationEmail();
                    }
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
                            child: Text("Resend Verification Email",
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
                TextButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                  ),
                  child: const Text('Cancel',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
                  ),
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                    navigatorKey.currentState!.pop();
                  },
                )
              ],
            ),
          ),
        ),
      );
    }
  }
}

// class VerifyEmailPage extends GetView<AuthController> {
//   VerifyEmailPage({Key? key}) : super(key: key);
//
//   static const String routeName = "/verifyAccount";
//   bool isEmailVerified  = false;
//   bool canResendEmail =  false;
//   Timer? timer;
//
//   void onInit() {
//     // user needs to be created before
//     isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
//
//     if(!isEmailVerified){
//       sendVerificationEmail();
//
//       timer = Timer.periodic(
//         const Duration(seconds: 2),
//             (_) => checkEmailVerified(),
//       );
//     }
//   }
//
//   void dispose(){
//     timer?.cancel();
//   }
//
//   Future checkEmailVerified() async {
//     await FirebaseAuth.instance.currentUser!.reload();
//
//     isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
//
//     if(isEmailVerified) timer?.cancel();
//   }
//
//   Future sendVerificationEmail() async{
//     try{
//       final user = FirebaseAuth.instance.currentUser!;
//       await user.sendEmailVerification();
//       Get.snackbar("Register user", "Verification message",
//           backgroundColor: Colors.greenAccent,
//           snackPosition: SnackPosition.TOP,
//           icon: const Icon(Icons.send, size: 32),
//           titleText: const Text(
//             "Verification Email Send",
//             style: TextStyle(
//                 color: Colors.white
//             ),
//           ),
//           messageText: Text(
//             'Please verify your account through following email - ${user.email.toString()}',
//             style: const TextStyle(
//                 color: Colors.white
//             ),
//           )
//       );
//       canResendEmail = false;
//       await Future.delayed(Duration(seconds: 10));
//       canResendEmail = true;
//     }on Exception catch(error){
//       Get.snackbar("Register user", "Verification message",
//           backgroundColor: Colors.redAccent,
//           snackPosition: SnackPosition.TOP,
//           icon: const Icon(Icons.error_outline, size: 32),
//           titleText: const Text(
//             "Verification Email Abort",
//             style: TextStyle(
//                 color: Colors.white
//             ),
//           ),
//           messageText: Text(
//             error.toString(),
//             style: const TextStyle(
//                 color: Colors.white
//             ),
//           )
//       );
//     }
//
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     if(isEmailVerified){
//       return const HomeScreen();
//     }else {
//       return Scaffold(
//         appBar: AppBar(
//           title: const Text('Verify Email'),
//           backgroundColor: Colors.transparent,
//           elevation: 0,
//         ),
//         body: Padding(
//           padding: const EdgeInsets.all(32),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.all(25),
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(50),
//                   child: SizedBox.fromSize(
//                     size: Size.fromRadius(120), // Image radius
//                     child: Image.asset(
//                       "assets/images/parking_app.jpg",
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 ),
//               ),
//               const Text('A verification email has been sent to your email',
//                 textAlign: TextAlign.center,
//                 style: TextStyle(fontSize: 24),
//               ),
//               const SizedBox(height: 24,),
//               MainButton(
//                 onTap: () {
//                   if(canResendEmail){
//                     sendVerificationEmail();
//                   }
//                 },
//                 child: Stack(
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       crossAxisAlignment: CrossAxisAlignment.stretch,
//                       children: [
//                         SvgPicture.asset("assets/icons/email.svg", color: Colors.white, width: 20, height: 20,),
//                         const SizedBox(width: 10,),
//                         const Center(
//                           child: Text("Resend Verification Email",
//                             style: TextStyle(
//                               color: onSurfaceTextColor,
//                               fontWeight: FontWeight.bold,
//                               fontSize: 18,
//                             ),
//                           ),
//                         )
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 10,),
//               TextButton(
//                 style: ElevatedButton.styleFrom(
//                   minimumSize: const Size.fromHeight(50),
//                 ),
//                 child: const Text('Cancel',
//                   style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
//                 ),
//                 onPressed: () {
//                   FirebaseAuth.instance.signOut();
//                 },
//               )
//             ],
//           ),
//         ),
//       );
//     }
//   }
// }


