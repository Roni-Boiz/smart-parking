import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:mobile_app/configs/themes/app_colors.dart';
import 'package:mobile_app/configs/themes/custom_text_styles.dart';
import 'package:mobile_app/controllers/parking_places/parking_place_controller.dart';
import 'package:mobile_app/controllers/zoom_drawer_controller.dart';
import 'package:mobile_app/services/google_maps.dart';
import 'package:mobile_app/screens/home/menu_screen.dart';
import 'package:mobile_app/screens/home/place_card.dart';
import 'package:mobile_app/widgets/app_circle_button.dart';
import 'package:mobile_app/widgets/common/main_button.dart';
import 'package:mobile_app/widgets/content_area.dart';
import 'package:mobile_app/widgets/qr/qr_scan_page.dart';
import 'package:qr_flutter/qr_flutter.dart';



class HomeScreen extends GetView<MyZoomDrawerController> {
  const HomeScreen({Key? key,
    this.displayName,
    this.email,
    this.profilePic,
  }) : super(key: key);

  final String? displayName;
  final String? email;
  final String? profilePic;

  static const String routeName = "/home";

  @override
  Widget build(BuildContext context) {
    ParkingPlaceController parkingPlaceController = Get.find();
    return Scaffold(
      body: GetBuilder<MyZoomDrawerController>(builder: (_) {
        return ZoomDrawer(
          borderRadius: 50.0,
          controller: _.zoomDrawerController,
          showShadow: true,
          angle: 0.0,
          style: DrawerStyle.Style1,
          backgroundColor: Colors.white.withOpacity(0.5),
          slideWidth: MediaQuery.of(context).size.width*0.7,
          openCurve: Curves.easeInOut,
          closeCurve: Curves.bounceIn,
          menuScreen: MenuScreen(),
          mainScreen: PageView(
            scrollDirection: Axis.horizontal,
            onPageChanged: (index) {
              print(index);
            },
            children: [
              Container(
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Stack(
                                    children: [
                                      AppCircleButton(
                                        child: Icon(Icons.menu),
                                        onTap: controller.toggleDrawer,
                                      ),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: Column(
                                          children: [
                                            Text("Wallet",
                                              style: headerText.copyWith(
                                                  color: onSurfaceTextColor
                                              ),
                                            ),
                                            Text("Rs. 2000.00",
                                              style: headerText.copyWith(
                                                  color: onSurfaceTextColor
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  const SizedBox(height: 1,),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 10),
                                    child: Row(
                                      children: [
                                        const Icon(Icons.account_circle, size: 24,),
                                        Obx(() => controller.user.value == null
                                            ? Text('Hello ${displayName??'User'}',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w900,
                                            fontSize: 18,
                                            color: onSurfaceTextColor,
                                          ),
                                        )
                                            : Text(
                                          'Hello ${controller.user.value!.displayName??'Display_Name'}',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w900,
                                            fontSize: 18,
                                            color: onSurfaceTextColor,
                                          ),
                                        ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    "Where you want to go today?",
                                    style: headerText.copyWith(
                                        color: onSurfaceTextColor
                                    ),
                                  ),
                                  Container(
                                    width: 400,
                                    height: 250.0,
                                    color: Colors.green,
                                    margin: const EdgeInsets.only(top: 10),
                                    alignment: Alignment.topLeft,
                                    child: GoogleMaps(allPlaces: parkingPlaceController.allPlaces),
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
              if(controller.user.value != null)...[
                Container(
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
                                      const SizedBox(height: 10,),
                                      Text(
                                        "Your QR Code",
                                        style: headerText.copyWith(
                                            color: onSurfaceTextColor
                                        ),
                                      ),
                                      const SizedBox(height: 40,),
                                      QrImage(
                                        data: controller.user.value!.uid,
                                        size: 300,
                                        backgroundColor: Colors.white,
                                      ),
                                      const SizedBox(height: 40,),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                margin: EdgeInsets.only(bottom: 20),
                                                height: 70,
                                                width: 150,
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.all(Radius.circular(100)),
                                                    color: Color.fromRGBO(255, 144, 39, 1)
                                                ),
                                                child: MainButton(
                                                  onTap: () {

                                                  },
                                                  child: Stack(
                                                    children: [
                                                      const Center(
                                                        child: Text(
                                                          "Generate QR",
                                                          style: TextStyle(
                                                            color: onSurfaceTextColor,
                                                            fontWeight: FontWeight.bold,
                                                            fontSize: 18,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 15,
                                              ),
                                              Container(
                                                margin: EdgeInsets.only(bottom: 20),
                                                height: 70,
                                                width: 150,
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.all(Radius.circular(100)),
                                                    color: Color.fromRGBO(255, 144, 39, 1)
                                                ),
                                                child: MainButton(
                                                  onTap: () {

                                                  },
                                                  child: Stack(
                                                    children: [
                                                      const Center(
                                                        child: Text(
                                                          "Save QR",
                                                          style: TextStyle(
                                                            color: onSurfaceTextColor,
                                                            fontWeight: FontWeight.bold,
                                                            fontSize: 18,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(bottom: 50),
                                            height: 70,
                                            width: MediaQuery. of(context). size. width,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(Radius.circular(100)),
                                                color: Color.fromRGBO(255, 144, 39, 1)
                                            ),
                                            child: MainButton(
                                              onTap: () {
                                                Get.offAndToNamed("/qrScan");
                                              },
                                              child: Stack(
                                                children: [
                                                  const Center(
                                                    child: Text(
                                                      "Scan QR",
                                                      style: TextStyle(
                                                        color: onSurfaceTextColor,
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 18,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),

                                    ],
                                  ),
                                ),

                              ]
                          ),
                        ],
                      )
                  ),
                ),
              ]
            ]
          )

        );
      },),
    );
  }
}