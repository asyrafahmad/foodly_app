import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodly_app/common/app_style.dart';
import 'package:foodly_app/common/background_container.dart';
import 'package:foodly_app/common/reusable_text.dart';
import 'package:foodly_app/common/shimmers/foodlist_shimmer.dart';
import 'package:foodly_app/constants/constants.dart';
import 'package:foodly_app/constants/uidata.dart';
import 'package:foodly_app/hooks/fetch_all_foods.dart';
import 'package:foodly_app/models/foods.dart';
import 'package:foodly_app/views/home/widgets/food_tile.dart';

class AllFastestFoodPage extends HookWidget {
  const AllFastestFoodPage({super.key});

  @override
  Widget build(BuildContext context) {

    final hookResult = useFetchAllFoods("fg43gf43r3f4","dummy");
    List<FoodsModel>? foods= hookResult.data;
    final isLoading = hookResult.isLoading;

    return Scaffold(
      backgroundColor: kSecondary,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kSecondary,
        title: ReusableText(
          text: 'All Fastest Food',
          style: appStyle(13, kLightWhite, FontWeight.w600),  
        ),
      ),
      body: BackgroundContainer(
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.all(12.h),
          child: isLoading 
            ? const FoodsListShimmer() 
            : ListView(
              children: List.generate(foods!.length, (i) {
                var food = foods[i];
                return FoodTile(
                  food: food,
                );
              })
            ),
        ), 
      ),
    );
  }
}