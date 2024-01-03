import 'package:get/get.dart';
import 'package:mobile_app/controllers/parking_places/parking_place_controller.dart';
import 'package:mobile_app/controllers/zoom_drawer_controller.dart';
import 'package:mobile_app/introduction/introduction.dart';
import 'package:mobile_app/screens/Places/reserve_parking.dart';
import 'package:mobile_app/screens/home/home_screen.dart';
import 'package:mobile_app/screens/login/forgot_password_page.dart';
import 'package:mobile_app/screens/login/login_screen.dart';
import 'package:mobile_app/screens/login/signin_page.dart';
import 'package:mobile_app/screens/signup/signup_page.dart';
import 'package:mobile_app/screens/signup/verify_email_page.dart';
import 'package:mobile_app/screens/splash/splash_screen.dart';
import 'package:mobile_app/widgets/qr/qr_scan_page.dart';

class AppRoutes{
  static List<GetPage> routes()=>[
    GetPage(name: "/", page: () => SplashScreen()),
    GetPage(name: "/introduction", page: () => AppIntroduction()),
    GetPage(name: "/home", page: () => HomeScreen(), binding: BindingsBuilder(() {
      Get.put(ParkingPlaceController());
      Get.put(MyZoomDrawerController());
    })),
    GetPage(name: "/login", page: () => LoginScreen()),
    GetPage(name: "/emailSignIn", page: () => SignInPage()),
    GetPage(name: "/emailSignUp", page: () => SignUpPage()),
    GetPage(name: "/forgotPassword", page: () => ForgotPasswordPage()),
    GetPage(name: "/verifyAccount", page: () => VerifyEmailPage()),
    GetPage(name: "/reserveParking", page: () => ReserveParking()),
    GetPage(name: "/qrScan", page: () => QRScan()),
  ];
}