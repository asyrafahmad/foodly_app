// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodly_app/common/app_style.dart';
import 'package:foodly_app/common/reusable_text.dart';
import 'package:foodly_app/constants/constants.dart';
import 'package:foodly_app/controller/category_controller.dart';
import 'package:foodly_app/views/category/all_categories.dart';
import 'package:get/get.dart';

class CategoryWidget extends StatelessWidget {
  CategoryWidget({
    super.key,
    this.category,
  });

  var category;

  @override
  Widget build(BuildContext context) {

    final controller = Get.find<CategoryController>();
    
    return GestureDetector(
      onTap: () {
        // Handle category tap
        if(controller.categoryValue == category['_id']) {
          controller.updateCategory = '';
          controller.updateTitle = '';
        } else if (category['title'] == 'More') {
          Get.to(() => AllCategories(),
            transition: Transition.fadeIn,
            duration: const Duration(milliseconds: 900)
          );
        } else {
          controller.updateCategory = category['_id'];
          controller.updateTitle = category['title'];
        }
      },
      child: Obx(() => Container(
        width: width * 0.19,
        margin: EdgeInsets.only(right: 5.w),
        padding: EdgeInsets.only(top: 4.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(
            color: controller.categoryValue == category['_id'] ? kSecondary : kOffWhite, 
            width: 0.5.w
          )
        ),
        child: Column(
          children: [
            SizedBox(
              height: 40.h,
              child: Image.network(category['imageUrl'], fit: BoxFit.contain),
            ),
            ReusableText(text: category['title'], style: appStyle(12, kDark, FontWeight.normal))
          ],
        )
      )),
    );
  }
}