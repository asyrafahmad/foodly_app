import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodly_app/common/app_style.dart';
import 'package:foodly_app/common/reusable_text.dart';
import 'package:foodly_app/constants/constants.dart';
import 'package:foodly_app/constants/uidata.dart';

/// Screen that shows all categories.
/// - Stateless because it does not hold mutable state itself (state comes from controllers or parent widgets).
/// - Expand this file to include lists, grids, or other UI for displaying categories.
class AllCategories extends StatelessWidget {
  /// Const constructor for this stateless widget.
  /// Using `const` helps Flutter optimize rebuilds when possible.
  const AllCategories({super.key});

  @override
  Widget build(BuildContext context) {
    // Builds the visual structure for the screen.
    return Scaffold(
      // Top app bar following Material Design.
      appBar: AppBar(
        elevation: 0, // No shadow under the app bar.
        backgroundColor: kOffWhite, // White background for the app bar.
        // Title displayed in the app bar.
        title: ReusableText(
          text: "All Categories", 
          style: appStyle(12, kGray, FontWeight.w600)),
      ),

      body: Container(
        padding: EdgeInsets.only(left: 12.w, top:10.h),
        height: height,
        child: ListView(
        scrollDirection: Axis.horizontal,
        children: List.generate(categories.length, (i) {
          var category = categories[i];

          return ListTile(
            leading: CircleAvatar(
              radius: 30.r,
              backgroundColor: kGrayLight,
              child: Image.network(category['imageUrl'], fit: BoxFit.contain),
            ),
            title: ReusableText(text: category['title'],
            style: appStyle(12, kGray, FontWeight.normal)),
            trailing: Icon(Icons.arrow_forward_ios_rounded, size: 15.r, color: kGray),
          );

        }),
      ),
      )
      // Body is intentionally left empty for now; replace with category list/grid.
    );
  }
}