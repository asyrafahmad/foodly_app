// Core Flutter Material Design package
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
// Package for responsive UI and screen adaptation
import 'package:flutter_screenutil/flutter_screenutil.dart';
// Custom app-wide text styles
import 'package:foodly_app/common/app_style.dart';
import 'package:foodly_app/common/background_container.dart';
// Reusable text widget for consistent text styling
import 'package:foodly_app/common/reusable_text.dart';
import 'package:foodly_app/common/shimmers/foodlist_shimmer.dart';
// App-wide constants like colors and dimensions
import 'package:foodly_app/constants/constants.dart';
// UI data including category information
import 'package:foodly_app/constants/uidata.dart';
import 'package:foodly_app/hooks/fetch_all_categories.dart';
import 'package:foodly_app/models/categories.dart';
import 'package:foodly_app/views/categories/widgets/category_tile.dart';


/// Screen that shows all categories.
/// - Stateless because it does not hold mutable state itself (state comes from controllers or parent widgets).
/// - Expand this file to include lists, grids, or other UI for displaying categories.
class AllCategories extends HookWidget {
  /// Const constructor for this stateless widget.
  /// Using `const` helps Flutter optimize rebuilds when possible.
  const AllCategories({super.key});

  @override
  Widget build(BuildContext context) {

    final hookResults = useFetchAllCategories();
    List<CategoriesModel>? categories = hookResults.data;
    final isLoading = hookResults.isLoading;

    // Builds the visual structure for the screen.
    return Scaffold(
      // Top app bar following Material Design.
      appBar: AppBar(
        elevation: 0, // No shadow under the app bar.
        backgroundColor: kOffWhite, // White background for the app bar.
        // Title displayed in the app bar.
        title: ReusableText(
          text: "Categories", 
          style: appStyle(12, kGray, FontWeight.w600)),
      ),

      // Main content area containing the list of categories
      body: BackgroundContainer(
        color: Colors.white,
        child: Container(
          // Add padding for better spacing and visual appeal
          padding: EdgeInsets.only(left: 12.w, top:10.h),
          height: height,  // Full screen height for the container
          // Horizontal scrolling list of categories
          child: isLoading 
            ? const FoodsListShimmer()
            : ListView(
            scrollDirection: Axis.horizontal,
            // Dynamically generate list items based on categories data
            children: List.generate(categories!.length, (i) {
              // Get the current category data
              CategoriesModel category = categories[i];
          
              // Each category is displayed as a ListTile
              return CategoryTile(category: category);
          
            }),
          ),
        ),
      )
      // Body is intentionally left empty for now; replace with category list/grid.
    );
  }
}
