import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:mobile_app/Models/parking_place_model.dart';
import 'package:mobile_app/controllers/auth_controller.dart';
import 'package:mobile_app/firebase_ref/references.dart';
import 'package:mobile_app/screens/Places/reserve_parking.dart';
import 'package:mobile_app/services/firebase_storage_service.dart';

class ParkingPlaceController extends GetxController{

  final allPlacesImages = <String?>[].obs;
  final allPlaces = <ParkingPlaceModel>[].obs;
  @override
  void onReady(){
    getAllParkingPlaces();
    super.onReady();
  }

  Future<void> getAllParkingPlaces() async {
    List<String> imageName = [
      "super_market",
      "hospital",
      "shopping_complex",
      "other"
    ];
    try{
      QuerySnapshot<Map<String, dynamic>> data = await parkingPlacesRF.get();
      final parkingList = data.docs.map((place) => ParkingPlaceModel.fromSnapshot(place)).toList();
      allPlaces.assignAll(parkingList);

      for(var parking in parkingList) {
        final imgUrl = await Get.find<FirebaseStorageService>().getImage(parking.name);
        parking.imageUrl = imgUrl;
        if(imgUrl == null) {
          final imgUrl = await Get.find<FirebaseStorageService>().getImage(parking.type);
          print("imgUri1234" + imgUrl.toString());
          parking.imageUrl = imgUrl;
        }
      }
      allPlaces.assignAll(parkingList);

    }catch(e){
      print(e);
    }
  }

  void navigateToPlaces({required ParkingPlaceModel place, bool tryAgain = false}){
    AuthController _authController = Get.find();
    if(_authController.isLoggedIn()){
      if(tryAgain){
        Get.back();
        Get.toNamed(ReserveParking.routeName, arguments: place, preventDuplicates: false);
      }else{
        Get.toNamed(ReserveParking.routeName, arguments: place);
      }
    }else{
      _authController.showLoginAlertDialog();
    }
  }

}