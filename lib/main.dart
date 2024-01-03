import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mobile_app/configs/themes/app_dark_theme.dart';
import 'package:mobile_app/configs/themes/app_light_theme.dart';
import 'package:mobile_app/controllers/theme_controller.dart';
import 'package:mobile_app/data_uploader_screen.dart';
import 'package:mobile_app/introduction/introduction.dart';
import 'package:mobile_app/routes/app_routes.dart';
import 'firebase_options.dart';
import 'package:mobile_app/bindings/initial_bindings.dart';
import 'package:get/get.dart';
import 'dart:async';
import 'package:mobile_app/screens/splash/splash_screen.dart';

// For Uploading old database to firebase firestore
// Future<void> main() async{
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
//   await Firebase.initializeApp();
//   runApp(GetMaterialApp(home: DataUploaderScreen()));
// }

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  InitialBindings().dependencies();
  runApp(MyApp());
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      // theme: Get.find<ThemeController>().lightTheme,
      theme: DarkTheme().buildDarkTheme(),
      getPages: AppRoutes.routes(),
    );
  }
}
