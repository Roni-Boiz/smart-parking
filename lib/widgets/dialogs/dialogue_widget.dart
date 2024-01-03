import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Dialogs{
  static final Dialogs _singleton = Dialogs._internal();

  Dialogs._internal();

  factory Dialogs(){
    return _singleton;
  }

  static Widget questionStartDialogue({required VoidCallback onTap}){
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Please login...",
            style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold
            ),
          ),
          SizedBox(height: 5,),
          const Text(
            "You have to login to your account to get full access to all the resources and services",
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold
            ),
          ),
          const SizedBox(height: 10,),
          ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: SizedBox.fromSize(
              size: const Size.fromRadius(40), // Image radius
              child: Image.asset(
                "assets/images/parking_app.jpg",
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(onPressed: onTap,
            child: Text("Continue to Login",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold
              ),))
      ],
    );
  }
}
