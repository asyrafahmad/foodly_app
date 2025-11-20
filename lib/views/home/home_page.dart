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
import 'package:foodly_app/views/home/widgets/food_list.dart';
import 'package:foodly_app/views/home/widgets/nearby_restaurant_list.dart';
import 'package:get/get.dart';

/// HomePage Widget
/// 
/// This is the main home page of the Foodly application. It displays a list of nearby restaurants,
/// recommended foods, and fastest food delivery options. The page is designed as a StatelessWidget
/// for performance optimization as it doesn't maintain internal state.
/// 
/// Features:
/// - Custom app bar with 130.h height
/// - Scrollable content to prevent overflow
/// - Three main sections: Nearby Restaurants, Recommendations, and Fast Food
/// - Navigation to detailed pages for each section
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimary,
      
      /// AppBar Configuration
      /// - PreferredSize: Sets the app bar height to 130.h using responsive sizing
      /// - CustomAppBar: Displays the custom app bar widget at the top of the page
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(130.h), 
          child: const CustomAppBar()),
      
      /// Body Section
      /// - SafeArea: Ensures content doesn't overflow into system UI areas (notch, navigation bar)
      /// - CustomContainer: Wraps content with custom styling and padding
      body: SafeArea(
        child: CustomContainer(
          containerContent: SingleChildScrollView(
            /// SingleChildScrollView: Enables vertical scrolling for content that exceeds screen height.
            /// This prevents overflow errors and allows Hot Reload without requiring Hot Restart.
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Placeholder for future category list implementation
                const CategoryList(),
                
                /// Section 1: Nearby Restaurants
                /// Heading widget with tap navigation to view all nearby restaurants.
                /// When tapped, navigates to AllNearbyRestaurantsPage using GetX navigation
                /// with Cupertino transition animation (300ms duration).
                Heading(
                  text: 'Nearby Restaurants', 
                  onTap: () {
                    Get.to(() => const AllNearbyRestaurantsPage(),
                      transition: Transition.cupertino,
                      duration: const Duration(milliseconds: 300),
                    );  
                  }
                ),
                /// Displays a horizontal list of nearby restaurants
                const NearbyRestaurantsList(),
                
                /// Section 2: Recommendations
                /// Heading widget with tap navigation to view all food recommendations.
                /// This section suggests new food items for users to try.
                /// Navigates to RecommendationsPage with Cupertino transition animation.
                Heading(
                  text: 'Try Something New', 
                  onTap: () {
                    Get.to(() => const RecommendationsPage(),
                      transition: Transition.cupertino,
                      duration: const Duration(milliseconds: 300),
                    );  
                  }
                ),
                /// Displays a horizontal list of recommended food items
                const FoodList(),
                
                /// Section 3: Fast Food Delivery
                /// Heading widget with tap navigation to view all fast food options.
                /// This section showcases food items available for quick delivery.
                /// Navigates to AllFastestFoodPage with Cupertino transition animation.
                Heading(
                  text: 'Food closer to you', 
                  onTap: () {
                    Get.to(() => const AllFastestFoodPage(),
                      transition: Transition.cupertino,
                      duration: const Duration(milliseconds: 300),
                    );  
                  }
                ),
                /// Displays a horizontal list of fast food items available for quick delivery
                const FoodList(),
              ],
            )
          )
        ),
      ),
    );
  }
}
