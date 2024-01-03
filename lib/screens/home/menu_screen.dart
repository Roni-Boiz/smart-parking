import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:mobile_app/controllers/zoom_drawer_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_app/configs/themes/app_colors.dart';

class MenuScreen extends GetView<MyZoomDrawerController> {
   MenuScreen({Key? key,
    this.displayName,
    this.email,
    this.profilePic,
  }) : super(key: key);

  final pageController = PageController(initialPage: 1);

  final String? displayName;
  final String? email;
  final String? profilePic;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      decoration: BoxDecoration(gradient: mainGradient()),
      child: Theme(
        data: ThemeData(
            textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(primary: onSurfaceTextColor)
            )
        ),
        child: SafeArea(
          child: Stack(
            children: [
              Positioned(
                  top: 0,
                  right: 36,
                  child: BackButton(
                    color: Colors.white,
                    onPressed: () {
                      controller.
                      toggleDrawer();
                    },
                  )),
              Padding(
                padding: EdgeInsets.only(
                    right: MediaQuery.of(context).size.width*0.3
                ),
                child: Column(
                  children: [
                    Obx(() => controller.user.value == null
                        ? const SizedBox()
                        : Text(controller.user.value!.displayName??'User Name',
                      style: const TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 18,
                        color: onSurfaceTextColor,
                      ),
                    ),
                    ),
                    Obx(() => controller.user.value == null
                        ? const SizedBox()
                        : Text(controller.user.value!.email??'example@email.com',
                      style: const TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 14,
                        color: onSurfaceTextColor,
                      ),
                    ),
                    ),
                    const Spacer(flex: 1,),
                    _DrawerButton(icon: Icons.dashboard, label: "Home", onPressed: () => controller.home(), ),
                    _DrawerButton(icon: Icons.account_circle, label: "Profile", onPressed: () => controller.profile(),),
                    _DrawerButton(icon: Icons.settings, label: "Settings", onPressed: () => controller.settings(),),
                    _DrawerButton(icon: Icons.contact_phone_sharp, label: "Contact Us", onPressed: () => controller.contactus(),),
                    _DrawerButton(icon: Icons.location_on, label: "About Us", onPressed: () => controller.aboutus(),),
                    _DrawerButton(icon: Icons.attach_money, label: "Donate", onPressed: () => controller.donateus(),),
                    const Spacer(flex: 4,),
                    _DrawerButton(icon: Icons.logout, label: "Signout", onPressed: () => controller.signOut(),),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _DrawerButton extends StatelessWidget {
  const _DrawerButton({Key? key,
    required this.icon,
    required this.label,
    this.onPressed,
  }) : super(key: key);

  final IconData icon;
  final String label;
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: onPressed,
      icon: Icon(
        icon,
        size: 15,
      ),
      label: Text(label),
    );
  }
}