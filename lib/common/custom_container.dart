// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodly_app/constants/constants.dart';

/// Reusable container widget used across the app to present main content areas.
/// - Provides a fixed height (75% of screen height) and uses a shared `width` constant.
/// - Clips the bottom corners with a rounded radius for a stylized look.
/// - Sets a background color (`kOffWhite`) and wraps content in a scroll view.
class CustomContainer extends StatelessWidget {
  /// Constructor requires the widget that will be displayed inside this container.
  /// `super.key` forwards the widget key to the StatelessWidget base class.
  CustomContainer({super.key, required this.containerContent, this.color});

  /// The child content shown inside the container.
  /// Made mutable and `must_be_immutable` is ignored to allow easy composition.
  Widget containerContent;
  Color? color;

  @override
  Widget build(BuildContext context) {
    // Overall box that controls this widget's size.
    // Height is set to 75% of device height so the layout is predictable.
    // Width uses a shared `width` value imported from constants.
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.75,
      width: width,
      child: ClipRRect(
        // ClipRRect applies rounded corners to its child widget.
        borderRadius: BorderRadius.only(
          // Use responsive radius provided by flutter_screenutil (30.r).
          bottomLeft: Radius.circular(30.r),
          bottomRight: Radius.circular(30.r),
        ),
        child: Container(
          // Container sets the actual background color and enforces width.
          width: width,
          color: kOffWhite,
          child: SingleChildScrollView(
            // Allows the provided content to scroll when it overflows the available space.
            child: containerContent,
          ),
        )
      ),
    );
  }
}