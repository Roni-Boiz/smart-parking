import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/file.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:logger/logger.dart';
import 'package:mobile_app/firebase_ref/references.dart';
import 'package:mobile_app/main.dart';
import 'package:mobile_app/screens/home/home_screen.dart';
import 'package:mobile_app/screens/login/forgot_password_page.dart';
import 'package:mobile_app/screens/login/login_screen.dart';
import 'package:mobile_app/screens/login/signin_page.dart';
import 'package:mobile_app/screens/signup/signup_page.dart';
import 'package:mobile_app/screens/signup/verify_email_page.dart';
import 'package:mobile_app/widgets/dialogs/dialogue_widget.dart';

import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class AuthController extends GetxController{

  @override
  void onReady(){
    initAuth();
    super.onReady();
  }

  var AppLogger = Logger();

  late FirebaseAuth _auth;
  final _user = Rxn<User>(); // email password name profile_pic
  late Stream<User?> _authStateChanges;

  void initAuth() async{
    await Future.delayed(const Duration(seconds: 2));
    _auth = FirebaseAuth.instance;
    setAuthChanges();
    navigateToIntroduction();
  }

  void setAuthChanges(){
    _authStateChanges = _auth.authStateChanges();
    _authStateChanges.listen((User? user) {
      _user.value = user;
    });
  }

  User? getUser(){
    _auth.currentUser!.reload();
    _user.value = _auth.currentUser;
    return _user.value;
  }

  saveUser(GoogleSignInAccount account){
    userRF.doc(account.email).set({
      "email":account.email,
      "displayName":account.displayName,
      "accountType":"Customer Only",
      "profilePic":account.photoUrl
    });
  }

  storeNewUser(user, context, name) async {
    File qr;
    var uri = (Uri.parse("https://pierre2106j-qrcode.p.rapidapi.com/api")
    );
    var response;
    response = await http.get(uri.replace(queryParameters: <String, String>{
      "backcolor": "ffffff",
      "pixel": "9",
      "ecl": "L %7C M%7C Q %7C H",
      "forecolor": "000000",
      "type": "text %7C url %7C tel %7C sms %7C email",
      "text": user.uid,

    },), headers: {
      "x-rapidapi-host": "pierre2106j-qrcode.p.rapidapi.com",
      "x-rapidapi-key": "f9f7a1b65fmsh8040df99eaf90e5p164474jsn2ed53a118bcd"
    });


    print("response.body mother: ${response.body}");


    File file = await DefaultCacheManager().getSingleFile(response.body);
    var time = DateTime.now();
    // StorageUploadTask task;
    print("File: ${file}");
  }

  signInWithGoogle() async{
    final GoogleSignIn _googleSignIn= GoogleSignIn();
    try{
      GoogleSignInAccount? account = await _googleSignIn.signIn();
      if(account != null) {
        final _authAccount = await account.authentication;
        final _credentials = GoogleAuthProvider.credential(
          idToken: _authAccount.idToken,
          accessToken: _authAccount.accessToken,
        );
        await _auth.signInWithCredential(_credentials);
        await saveUser(account);
        navigateToHomePage();
      }
    }on Exception catch(error){
      navigatorKey.currentState!.pop();
      print(error);
    }
  }

  void register(String displayName, String email, String password, String accountType) async {
    try{
      await _auth.createUserWithEmailAndPassword(email: email, password: password).then((value) => setAuthChanges());
      await _auth.currentUser!.updateDisplayName(displayName).then((value) => navigateToVerifyEmailPage(email, displayName));
      await userRF.doc(email).set({
        "email":email,
        "displayName":displayName,
        "accountType":accountType,
        "profilePic":"https://picsum.photos/100",
      });

      // _auth.currentUser!.updateDisplayName(displayName).then((value) => navigateToHomePage());
    }on Exception catch(error){
      navigatorKey.currentState!.pop();
      Get.snackbar("About User", "User message",
          backgroundColor: Colors.redAccent,
          snackPosition: SnackPosition.TOP,
          titleText: const Text(
            "Account creation failed",
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

  void login(String email, String password) async {

    try{
      await _auth.signInWithEmailAndPassword(email: email, password: password).then((value) => setAuthChanges());
      if(!_auth.currentUser!.emailVerified){
        navigateToVerifyEmailPage(email,_auth.currentUser!.displayName.toString());
      } else {
        navigateToHomePage();
      }
    }on Exception catch(error){
      // navigatorKey.currentState!.popUntil((route) => route.isFirst);
      navigatorKey.currentState!.pop();
      Get.snackbar("About Login", "Login message",
          backgroundColor: Colors.redAccent,
          snackPosition: SnackPosition.TOP,
          titleText: const Text(
            "Login failed",
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

  Future verifyEmail(String email) async {
    try{
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email.trim());
      Get.snackbar("Reset Password", "Reset message",
          backgroundColor: Colors.greenAccent,
          snackPosition: SnackPosition.TOP,
          icon: const Icon(Icons.send, size: 32),
          titleText: const Text(
            "Reset Password Email Send",
            style: TextStyle(
                color: Colors.white
            ),
          ),
          messageText: Text(
            'Reset link send to ${email.toString()}',
            style: const TextStyle(
                color: Colors.white
            ),
          )
      );
      navigatorKey.currentState!.pop();
    }on Exception catch(error){
      navigatorKey.currentState!.pop();
      Get.snackbar("Reset Password", "Reset message",
          backgroundColor: Colors.redAccent,
          snackPosition: SnackPosition.TOP,
          icon: const Icon(Icons.error_outline, size: 32),
          titleText: const Text(
            "Reset Password failed",
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

  Future<void> signOut() async{
    AppLogger.d("Sign out");
    try{
      await _auth.signOut();
      navigateToHomePage();
    } on FirebaseAuthException catch(e) {
      AppLogger.e(e);
    }
  }

  void navigateToIntroduction(){
    Get.offAllNamed("/introduction");
  }

  navigateToHomePage(){
    Get.offAllNamed(HomeScreen.routeName);
  }

  void showLoginAlertDialog(){
    Get.dialog(Dialogs.questionStartDialogue(onTap: (){
      Get.back();
      navigateToLoginPage();
      // Login Page
    }),
        barrierDismissible: false
    );
  }

  void navigateToLoginPage(){
    Get.toNamed(LoginScreen.routeName);
  }

  void navigateToEmailSignInPage(){
    Get.toNamed(SignInPage.routeName);
  }

  void navigateToEmailSignUpPage(){
    Get.offAndToNamed(SignUpPage.routeName);
  }

  void navigateToForgotPasswordPage(){
    Get.offAndToNamed(ForgotPasswordPage.routeName);
  }

  void navigateToVerifyEmailPage(String email, String displayName){
    Get.offAndToNamed(VerifyEmailPage.routeName, arguments: {"email":email, "displayName":displayName});
  }

  bool isLoggedIn(){
    return _auth.currentUser != null;
  }
}