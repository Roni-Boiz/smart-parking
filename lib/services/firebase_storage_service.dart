import 'package:get/get.dart';
import 'package:mobile_app/firebase_ref/references.dart';

class FirebaseStorageService extends GetxService {
  Future<String?> getImage(String? imgName) async {
    if(imgName == null){
      return null;
    }
    try{
      var urlRef = firebaseStorage.child("parking_place_images")
          .child('${imgName.toLowerCase()}.png');
      var imgUrl = await urlRef.getDownloadURL();
      return imgUrl;
    }catch(e){
      print(e);
      return null;
    }
  }
}