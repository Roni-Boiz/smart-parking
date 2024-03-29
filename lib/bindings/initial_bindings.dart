import 'package:get/get.dart';
import 'package:mobile_app/controllers/auth_controller.dart';
import 'package:mobile_app/controllers/theme_controller.dart';
import 'package:mobile_app/services/firebase_storage_service.dart';

class InitialBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(ThemeController());
    Get.put(AuthController(), permanent: true);
    // Get.put(NotificationService());
    // Get.put(FirebaseStorageService());
    Get.lazyPut(() =>  FirebaseStorageService());
  }
}