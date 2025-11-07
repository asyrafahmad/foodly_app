import 'package:flutter/material.dart';
import 'package:foodly_app/constants/constants.dart';

class BackgroundContainer extends StatelessWidget {
  const BackgroundContainer({super.key, required this.child, required this.color});

  final Widget child;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: const BoxDecoration(
        color: kPrimary,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        image:DecorationImage(
          image: AssetImage('assets/images/restaurant_bk.png'),
          fit: BoxFit.cover,
          opacity: .7,
        ),
      ),

      child: child,
    );
  }
}