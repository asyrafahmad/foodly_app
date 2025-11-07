import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodly_app/common/app_style.dart';
import 'package:foodly_app/common/reusable_text.dart';
import 'package:foodly_app/constants/constants.dart';

class FoodWidget extends StatelessWidget {
  const FoodWidget({super.key, required this.image, required this.title, required this.time, required this.price, this.onTap });

  final String image;
  final String title;
  final String time;
  final String price;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(right: 12),
        child: Container(
          width: width * 0.7,
          height: 192.h,
          decoration: BoxDecoration(
            color: kLightWhite,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: ListView(
            physics: const NeverScrollableScrollPhysics(),
            children: [
              Padding(
                padding: EdgeInsets.all(8.0.r),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.r),
                  child: SizedBox(
                    height: 112.h,
                    width: width * 0.8,
                    // child: Image.network(
                    //   image,
                    //   fit: BoxFit.fitWidth,
                    // ),
                    child: Image.asset(
                      'assets/foodly/${image}',
                      fit: BoxFit.fitWidth,
                    )
                  ),
                )
              ),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ReusableText(
                          text: title, 
                          style: appStyle(12, kDark, FontWeight.w500)
                        ),
                        ReusableText(
                          text: "\$ $price" , 
                          style: appStyle(12, kPrimary, FontWeight.w600)
                        ),
                      ],
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ReusableText(
                          text: 'Delivery Time', 
                          style: appStyle(12, kGray, FontWeight.w500)
                        ),
                        ReusableText(
                          text: time, 
                          style: appStyle(12, kDark, FontWeight.w500)
                        )
                      ]
                    ),

                  ],
                ),
              )
            ],
          )
        ),
      ),
    );
  }
}