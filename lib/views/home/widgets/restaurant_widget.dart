import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodly_app/constants/constants.dart';

class RestaurantWidget extends StatelessWidget {
  const RestaurantWidget({super.key, required this.image, required this.logo, required this.title, required this.time, required this.rating, this.onTap});

  final String image;
  final String logo;
  final String title;
  final String time;
  final String rating;  
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(right: 12),
        child: Container(
          width: width* 0.7,
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
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12.r),
                      child: SizedBox(
                        height: 112.h,
                        width: width * 0.8,
                        child: Image.network(
                          image,
                          fit: BoxFit.fitWidth,
                        )
                      ),
                    ),
                    Positioned(
                      right: 10.w,
                      top: 10.h,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20.r),
                        child: Container(
                          color: kLightWhite,
                          child: Padding(
                            padding: EdgeInsets.all(2.0.r),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50.r),
                              child: Image.network(
                                logo,
                                height: 20.h,
                                width: 20.w,
                                fit: BoxFit.cover,
                              )
                            ),
                          ),
                        )
                      )
                    )
                  ],
                )
              ),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    
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