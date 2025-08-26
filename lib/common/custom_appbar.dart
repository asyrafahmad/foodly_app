import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodly_app/common/app_style.dart';
import 'package:foodly_app/common/reusable_text.dart';
import 'package:foodly_app/constants/constants.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      height: 1110.h,
      width: width,
      color: kOffWhite,
      child: Container(
        margin: EdgeInsets.only(top: 12.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircleAvatar(
              radius: 25.r,
              backgroundColor: kSecondary,
              backgroundImage: NetworkImage("https://i.pravatar.cc/300"),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 6.h, left: 8.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ReusableText(
                    text: "Deliver to", 
                    style: appStyle(12, kSecondary, FontWeight.w600)
                  ),
                  SizedBox(
                    width: width * 0.65,
                    child: Container(
                      child: Text("No 1, Jalan D'Belsa 4", 
                        overflow: TextOverflow.ellipsis,
                        style: appStyle(11, kGrayLight, FontWeight.normal)
                      )
                    )
                  ),
                  const Text("❄️", style: TextStyle(fontSize:35))
                ],
              ),
            ),
          ],
        ),
      )
    );
  }
}