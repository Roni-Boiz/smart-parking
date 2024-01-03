import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:mobile_app/configs/themes/app_colors.dart';
import 'package:mobile_app/configs/themes/custom_text_styles.dart';
import 'package:mobile_app/controllers/parking_places/parking_place_controller.dart';
import 'package:mobile_app/controllers/zoom_drawer_controller.dart';
import 'package:mobile_app/screens/home/menu_screen.dart';
import 'package:mobile_app/screens/home/place_card.dart';
import 'package:mobile_app/services/google_maps.dart';
import 'package:mobile_app/widgets/app_circle_button.dart';
import 'package:mobile_app/widgets/common/main_button.dart';
import 'package:mobile_app/widgets/content_area.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ReserveParking extends GetView<ParkingPlaceController> {
  const ReserveParking({Key? key,
    this.displayName,
    this.email,
    this.profilePic,
  }) : super(key: key);

  final String? displayName;
  final String? email;
  final String? profilePic;
  static const String routeName = "/reserveParking";

  @override
  Widget build(BuildContext context) {
    ParkingPlaceController parkingPlaceController = Get.find();
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: mainGradientDark),
        child: SafeArea(
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Reserve a Parking Space",
                          style: headerText.copyWith(
                              color: onSurfaceTextColor
                          ),
                        ),

                      ],
                    ),
                  ),
                ]
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: ContentArea(
                    child: Obx(() =>
                        ListView.separated(
                            itemBuilder: (BuildContext context, int index) {
                              return PlaceCard(model: parkingPlaceController.allPlaces[index]);
                            },
                            separatorBuilder: (BuildContext context, int index) {
                              return const SizedBox(height: 10, width: 10,);
                            },
                            itemCount: parkingPlaceController.allPlaces.length
                        )
                    ),
                  ),
                ),
              )
            ],
          )
        ),
      ),
    );
  }
}