import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mobile_app/controllers/parking_places/data_uploader.dart';
import 'package:get/get.dart';
import 'package:mobile_app/firebase_ref/loading_status.dart';
//import 'package:project/firebase_ref/loading_status.dart';

class DataUploaderScreen extends StatelessWidget {

  DataUploaderScreen({Key? key}) : super(key: key);
  DataUploader controller = Get.put(DataUploader());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Obx(() => Text(controller.loadingStatus.value == LoadingStatus.loading ? "Preparing Files" : controller.loadingStatus.value == LoadingStatus.uploading ? "Uploading Files..."
            : controller.loadingStatus.value == LoadingStatus.completed ? "Uploading Completed" : "Error", style: TextStyle(fontSize: 24)),
        ),
      ),
    );
  }
}