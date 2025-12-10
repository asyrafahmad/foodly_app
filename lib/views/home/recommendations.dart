import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodly_app/common/app_style.dart';
import 'package:foodly_app/common/background_container.dart';
import 'package:foodly_app/common/reusable_text.dart';
import 'package:foodly_app/common/shimmers/foodlist_shimmer.dart';
import 'package:foodly_app/constants/constants.dart';
import 'package:foodly_app/hooks/fetch_all_foods.dart';
import 'package:foodly_app/models/foods.dart';
import 'package:foodly_app/views/home/widgets/food_tile.dart';

class RecommendationsPage extends HookWidget {
  const RecommendationsPage({super.key});

  @override
  Widget build(BuildContext context) {

    final hookResults = useFetchAllFoods('1', '1');
    List<FoodsModel>? foodsList = hookResults.data;
    final isLoading = hookResults.isLoading;
    final error = hookResults.error;

    return Scaffold(
      appBar: AppBar(
        elevation: 0.3,
        backgroundColor: kOffWhite,
        title: ReusableText(
          text: 'Recommendations',
          style: appStyle(13, kGray, FontWeight.w600),  
        ),
      ),
      body: BackgroundContainer(
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.all(12.h),
          child: isLoading 
            ? const FoodsListShimmer() 
            : Padding(
                padding: EdgeInsets.fromLTRB(12.w, 12.h, 12.w, 12.h),
                child: ListView(
                  children: List.generate(foodsList!.length, (i) {
                    FoodsModel food = foodsList[i];
                    return FoodTile(
                      food: food,
                    );
                  }),
                ),
              ),
        ),
      )
    );
  }
}