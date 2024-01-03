import 'package:cached_network_image/cached_network_image.dart';
import 'package:mobile_app/Models/parking_place_model.dart';
import 'package:mobile_app/configs/themes/custom_text_styles.dart';
import 'package:mobile_app/configs/themes/ui_parameters.dart';
import 'package:mobile_app/controllers/parking_places/parking_place_controller.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app/widgets/app_icon_text.dart';

class PlaceCard extends GetView<ParkingPlaceController> {
  const PlaceCard({Key? key, required this.model}) : super(key: key);

  final ParkingPlaceModel model;

  @override
  Widget build(BuildContext context) {
    const double _padding = 10.0;
    return Container(
      decoration: BoxDecoration(
        borderRadius: UIParaqmeters.cardBorderRadius,
        color: Theme.of(context).cardColor,
      ),
      child: InkWell(
        onTap: (){
          controller.navigateToPlaces(place: model, tryAgain: false,);
        },
        child: Padding(
          padding: const EdgeInsets.all(_padding),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      color: Theme.of(context).primaryColor.withOpacity(0.2),
                      padding: const EdgeInsets.all(5.0),
                      child: SizedBox(
                        height: Get.width*0.2,
                        width: Get.width*0.2,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: SizedBox.fromSize(
                            size: const Size.fromRadius(100), // Image radius
                            child: CachedNetworkImage(
                              imageUrl: model.imageUrl!,
                              placeholder : (context, url) => Container(
                                alignment: Alignment.center,
                                child: const CircularProgressIndicator(),
                              ),
                              errorWidget: (context, url, error) => ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: SizedBox.fromSize(
                                  size: const Size.fromRadius(100), // Image radius
                                  child: Image.asset(
                                    "assets/images/parking_app.jpg",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12,),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          model.name,
                          style: cardTitles(context) ,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 15),
                          child: Text(
                            model.description!,
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            AppIconText(
                                icon: Icon(Icons.car_repair,
                                  size: 24,
                                  color: Get.isDarkMode?Colors.white:Theme.of(context).primaryColor.withOpacity(0.8),
                                ),
                                text: Text(model.availableSlots(),
                                  style: detailText.copyWith(
                                      color: Get.isDarkMode?Colors.white:Theme.of(context).primaryColor.withOpacity(0.8)
                                  ),
                                )
                            ),
                            const SizedBox(width: 20,),
                            AppIconText(
                                icon: Icon(Icons.monetization_on,
                                  size: 24,
                                  color: Get.isDarkMode?Colors.white:Theme.of(context).primaryColor.withOpacity(0.8),
                                ),
                                text: Text(model.totalNoOfSlots.toString(),
                                  style: detailText.copyWith(
                                      color: Get.isDarkMode?Colors.white:Theme.of(context).primaryColor.withOpacity(0.8)
                                  ),
                                )
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
              Positioned(
                  bottom: -_padding,
                  right: -_padding,
                  child: GestureDetector(
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      child: Icon(Icons.star, size: 24,),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(cardBorderRadius),
                            bottomRight: Radius.circular(cardBorderRadius),
                          ),
                          color: Theme.of(context).primaryColor
                      ),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}