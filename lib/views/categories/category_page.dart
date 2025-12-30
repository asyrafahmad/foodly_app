import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodly_app/common/app_style.dart';
import 'package:foodly_app/common/background_container.dart';
import 'package:foodly_app/common/reusable_text.dart';
import 'package:foodly_app/common/shimmers/foodlist_shimmer.dart';
import 'package:foodly_app/constants/constants.dart';
import 'package:foodly_app/controller/category_controller.dart';
import 'package:foodly_app/hooks/fetch_category_foods.dart';
import 'package:foodly_app/models/foods.dart';
import 'package:foodly_app/views/home/widgets/food_tile.dart';
import 'package:get/get.dart';
 
/// Page to display details of a specific category.
/// This page shows all food items belonging to a selected category.

class CategoryPage extends HookWidget {
  const CategoryPage({super.key});

  @override
  Widget build(BuildContext context) {

    // Initialize and inject the CategoryController using GetX dependency injection
    final controller = Get.put(CategoryController());
    // Call the custom hook to fetch foods for category ID "41007428"
    // This hook handles the API call and returns the result with loading state
    final hookResult = useFetchFoodsByCategory("41007428");
    // Extract the list of food items from the hook result
    // The data can be null if the fetch hasn't completed or failed
    List<FoodsModel>? foods= hookResult.data;
    // Extract the loading state to show shimmer effect while data is being fetched
    final isLoading = hookResult.isLoading;

    // Return a Scaffold widget which provides the basic material design layout structure
    return Scaffold(
      // Define the app bar at the top of the screen
      appBar: AppBar(
        // Remove shadow below the app bar for a flat design
        elevation: 0,
        // Set the app bar background color to off-white
        backgroundColor: kOffWhite,
        // Leading widget in the app bar, typically a back button
        leading: IconButton(
          // Callback function when the back button is pressed
          onPressed: () {
            // Reset the category and title values in the controller
            controller.updateCategory = "";
            controller.updateTitle = "";
            // Navigate back to the previous screen
            Get.back();
          },
          // Icon for the back button
          icon: const Icon(Icons.arrow_back_ios, color: kDark),
          // Color of the icon (redundant as it's also in the icon itself)
          color: kGray
        ),
        // Display the category title in the app bar
        title: ReusableText(
          // Concatenate the category name with " Category" text
          text: "${controller.titleValue} Category",
          // Apply custom text style: 16px font size, gray color, semi-bold weight
          style: appStyle(16, kGray, FontWeight.w600),
        ),
      ),
      // Define the main body of the page
      body: BackgroundContainer(
        // Set the background color to white
        color: Colors.white,
        // Container to hold the main content with specific dimensions and padding
        child: Container(
          // Add padding for better spacing and visual appeal
          // 12 width units on left, 10 height units on top (responsive values)
          padding: EdgeInsets.only(left: 12.w, top:10.h),
          // Set container height to full screen height using constant value
          height: height,  // Full screen height for the container
          // Horizontal scrolling list of categories
          // Conditionally render shimmer or actual content based on loading state
          child: isLoading 
            // Show shimmer loading effect while data is being fetched
            ? const FoodsListShimmer()
            // Show actual food list when data is loaded
            : Padding (
                // Add padding around the ListView for better spacing
                // 12 height units on all sides (responsive value)
                padding: EdgeInsets.all(12.h),
                // Create a scrollable list view to display food items
                child: ListView(
                  // Generate a list of FoodTile widgets based on the foods array
                  children: List.generate(foods!.length, (i) {
                    // Extract individual food item at index i from the foods list
                    FoodsModel food = foods[i];
                    // Return a FoodTile widget for each food item
                    return FoodTile(
                      // Pass the food model to the FoodTile widget
                      food: food,
                    );
                  })
                ),          
              )
        ),
      )
    );
  }
}