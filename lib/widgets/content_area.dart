import 'package:flutter/material.dart';
import 'package:mobile_app/configs/themes/app_colors.dart';

class ContentArea extends StatelessWidget {
  final bool addPadding;
  final Widget child;
  const ContentArea({Key? key,
    required this.child,
    this.addPadding = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: const BorderRadius.vertical(top:Radius.circular(20)),
      clipBehavior: Clip.hardEdge,
      type: MaterialType.transparency,
      child: Ink(
        decoration: BoxDecoration(
          color: customScaffoldColor(context),
        ),
        padding: addPadding? const EdgeInsets.only(
          top: 10,
          left: 10,
          right: 10,
        ):EdgeInsets.zero,
        child: child,
      ),
    );
  }
}
