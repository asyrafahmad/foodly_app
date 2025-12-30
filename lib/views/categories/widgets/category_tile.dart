// Core Flutter Material Design package

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodly_app/common/app_style.dart';
import 'package:foodly_app/common/reusable_text.dart';
import 'package:foodly_app/constants/constants.dart';
import 'package:foodly_app/controller/category_controller.dart';
import 'package:foodly_app/models/categories.dart';
import 'package:foodly_app/views/categories/category_page.dart';
import 'package:get/get.dart';

class CategoryTile extends StatelessWidget {
  CategoryTile({
    super.key,
    required this.category,
  });

  CategoriesModel category;

  @override
  Widget build(BuildContext context) {

    final controller = Get.put(CategoryController());

    return ListTile(
      onTap: () {
        controller.updateCategory = ''; // clear selected category id in controller
        controller.updateTitle = ''; // clear selected title in controller

        Get.to(() => const CategoryPage(),
          transition: Transition.fadeIn,
          duration: const Duration(milliseconds: 300),
        );
      },
      // Leading circular avatar with category image
      leading: CircleAvatar(
        radius: 30.r,  // Responsive radius using ScreenUtil
        backgroundColor: kGrayLight,  // Light gray background
        child: Image.network(
          category.imageUrl, 
          fit: BoxFit.contain
        ),  // Category image
      ),
      // Category title using reusable text component
      title: ReusableText(
        text: category.title, 
        style: appStyle(12, kGray, FontWeight.normal)
      ),
      // Arrow icon indicating the tile is tappable
      trailing: Icon(Icons.arrow_forward_ios_rounded, size: 15.r, color: kGray),
    );
  }
}