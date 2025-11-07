// Core Flutter material widgets
import 'package:flutter/material.dart';
// ScreenUtil for responsive sizing (w, h, r helpers)
import 'package:flutter_screenutil/flutter_screenutil.dart';
// Local dataset for foods used to populate the list (example data in uidata)
import 'package:foodly_app/constants/uidata.dart';
// Reusable FoodWidget that renders a single food card/item
import 'package:foodly_app/views/home/widgets/food_widget.dart';

class FoodList extends StatelessWidget {
  // Stateless list of food items shown horizontally.
  // If you need to react to user interaction or selection state, convert
  // this to a StatefulWidget or use a state-management solution (GetX, Provider, etc.).
  const FoodList({super.key});

  @override
  Widget build(BuildContext context) {
    // Container gives a fixed height for the horizontal list and padding
    // so the cards align with other horizontal content on the screen.
    return Container(
      height: 184.h,
      padding: EdgeInsets.only(left: 12.w, top: 10.h),
      child: ListView(
        // Horizontal scrolling list of food cards
        scrollDirection: Axis.horizontal,
        // Build list items from the `foods` list in uidata.dart
        children: List.generate(foods.length, (i) {
          var food = foods[i];

          // FoodWidget is a reusable card widget that expects the following named args:
          // - image: String (URL or asset path depending on how FoodWidget uses it)
          // - title: String (food name)
          // - time: String/int (preparation or delivery time)
          // - price: String (formatted price)
          // NOTE: If you want to use local assets instead of network images, update
          // `food['imageUrl']` to contain the asset path (e.g. 'assets/foodly/food.png')
          // and ensure the asset is declared in pubspec.yaml. Alternatively, change
          // FoodWidget to accept a flag and call Image.asset vs Image.network accordingly.
          return FoodWidget(
            image: food['imageAsset'],
            title: food['title'],
            time: food['time'],
            price: food['price'].toStringAsFixed(2),
          );

        }),
      ),
    );
  }
}