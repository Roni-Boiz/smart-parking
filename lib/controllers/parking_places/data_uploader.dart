import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_app/Models/parking_place_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobile_app/firebase_ref/loading_status.dart';
import 'package:mobile_app/firebase_ref/references.dart';
//import 'package:project/firebase_ref/loading_status.dart';


class DataUploader extends GetxController {
  @override
  void onReady() {
     uploadData();
    super.onReady();
  }

  final loadingStatus = LoadingStatus.loading.obs;

  Future<void> uploadData() async {
    loadingStatus.value = LoadingStatus.loading;

    final fireStore = FirebaseFirestore.instance;
    final manifestContent = await DefaultAssetBundle.of(Get.context!).loadString("AssetManifest.json");
    final Map<String, dynamic> manifestMap = json.decode(manifestContent);
    final placesInAssets = manifestMap.keys
        .where((path) =>
    path.startsWith("assets/DB/places") && path.contains(".json")).toList();
    List<ParkingPlaceModel> parkingPlaces = [];

    for(var place in placesInAssets) {
      String stringParkingPlaceContent = await rootBundle.loadString(place);
      parkingPlaces.add(ParkingPlaceModel.fromJson(json.decode(stringParkingPlaceContent)));
    }

    var batch = fireStore.batch();

    for(var place in parkingPlaces) {

      Map<String, dynamic> location = {
        "address": place.location.address,
        "latitude": place.location.latitude,
        "longitude": place.location.longitude,
        "url": place.location.url
      };

      batch.set(parkingPlacesRF.doc(place.id), {
        "name":place.name,
        "type":place.type,
        "image_url":place.imageUrl,
        "description":place.description,
        "location": location,
        "total_no_of_slots":place.totalNoOfSlots,
        "slots_on_each_floor":place.slotsOnEachFloor.toList(),
      });

      for(var slot in place.slots) {
        final slotPath = slotRF(placeId: place.id, slotNo: slot.no.toString());
        batch.set(slotPath, {
          "types" : slot.types,
          "occupy" : slot.occupy
        });
      }
    }
    loadingStatus.value = LoadingStatus.uploading;
    await batch.commit();
    loadingStatus.value = LoadingStatus.completed;

  }

}