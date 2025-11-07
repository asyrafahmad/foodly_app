import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:foodly_app/common/reusable_text.dart';
import 'package:foodly_app/constants/constants.dart';

class Heading extends StatelessWidget {
  const Heading({super.key, required this.text, this.onTap});

  final String text;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 12.w
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsetsGeometry.only(top: 10.h),
            child: ReusableText(text: text, style: 
              TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: kDark
              )
            ),
          ),
          GestureDetector(
            onTap: onTap,
            child: Padding(
              padding: EdgeInsetsGeometry.only(top: 10.h),
              child: Icon(
                AntDesign.appstore1,
                color: kSecondary,
                size: 20.sp,
              ),
            ),
          )
        ],
      ),
    );
  }
}