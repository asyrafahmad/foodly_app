import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:foodly_app/common/shimmers/foodlist_shimmer.dart';
import 'package:foodly_app/constants/constants.dart';
import 'package:foodly_app/hooks/fetch_all_foods.dart';
import 'package:foodly_app/hooks/fetch_category_foods.dart';
import 'package:foodly_app/models/foods.dart';
import 'package:foodly_app/views/home/widgets/food_tile.dart';

class CategoryFoodsList extends HookWidget {
  const CategoryFoodsList({super.key});

  @override
  Widget build(BuildContext context) {

    final hookResult = useFetchFoodsByCategory("41007428");
    List<FoodsModel>? foods= hookResult.data;
    final isLoading = hookResult.isLoading;

    return Container(
      width: width,
      height: height,
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
    );
  }
}