import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodly_app/constants/constants.dart';
import 'package:foodly_app/controller/search_food_controller.dart';
import 'package:foodly_app/models/foods.dart';
import 'package:get/get.dart';

import '../home/widgets/food_tile.dart';

class SearchResults extends StatelessWidget {
  const SearchResults({super.key});

  @override
  Widget build(BuildContext context) {

    final controller = Get.put(SearchFoodController());
    return Container(
      padding: EdgeInsets.fromLTRB(12.w, 12.h, 12.w, 12.h),
      height: height,
      child: ListView.builder(
        itemCount: controller.searchResults!.length,
        itemBuilder: (context, index) {
          FoodsModel food = controller.searchResults![index];
          return FoodTile(food: food);
        }
      )
    );
  }
}