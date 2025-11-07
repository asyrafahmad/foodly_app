import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodly_app/common/custom_appbar.dart';
import 'package:foodly_app/common/custom_container.dart';
import 'package:foodly_app/common/heading.dart';
import 'package:foodly_app/constants/constants.dart';
import 'package:foodly_app/views/home/all_fastest_food.dart';
import 'package:foodly_app/views/home/all_nearby_restaurants.dart';
import 'package:foodly_app/views/home/recommendations.dart';
import 'package:foodly_app/views/home/widgets/category_list.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimary,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(130.h), 
          child: const CustomAppBar()),
      body: SafeArea(
        child: CustomContainer(
          containerContent: Column(
            children: [
              // Add your content here
              const CategoryList(),
              Heading(
                text: 'Nearby Restaurants', 
                onTap: () {
                  Get.to(() => const AllNearbyRestaurantsPage(),
                    transition: Transition.cupertino,
                    duration: const Duration(milliseconds: 300),
                  );  
                }),
              Heading(
                text: 'Try Something New', 
                onTap: () {
                  Get.to(() => const RecommendationsPage(),
                    transition: Transition.cupertino,
                    duration: const Duration(milliseconds: 300),
                  );  
              }),
              Heading(
                text: 'Food closer to you', 
                onTap: () {
                  Get.to(() => const AllFastestFoodPage(),
                    transition: Transition.cupertino,
                    duration: const Duration(milliseconds: 300),
                  );  
              }),
            ],
          )
        ),
      ),
    );
  }
}
