// ...existing code...

// ignore_for_file: must_be_immutable // allow non-final fields in this widget (silence lint)

import 'package:flutter/material.dart'; // Flutter material widgets
import 'package:flutter_screenutil/flutter_screenutil.dart'; // responsive sizing utils (w, h, r)
import 'package:foodly_app/common/app_style.dart'; // app-specific text style helper
import 'package:foodly_app/common/reusable_text.dart'; // reusable text widget used by the app
import 'package:foodly_app/constants/constants.dart'; // shared constants (colors, widths, etc.)
import 'package:foodly_app/controller/category_controller.dart'; // controller that manages category state
import 'package:foodly_app/views/category/all_categories.dart'; // screen showing all categories
import 'package:get/get.dart'; // GetX for state management and navigation

class CategoryWidget extends StatelessWidget { // stateless widget representing a single category tile
  CategoryWidget({ // constructor for the widget
    super.key, // forward the key to the base class
    this.category, // accept a category data map (optional)
  });

  var category; // holds the category data passed into this widget (dynamic / Map)

  @override
  Widget build(BuildContext context) { // build method returns the widget tree for this component

    final controller = Get.find<CategoryController>(); // obtain the CategoryController instance registered in GetX
    
    return GestureDetector( // makes the tile tappable
      onTap: () { // handler invoked when user taps the tile
        // If the tapped category is already selected, clear selection
        if(controller.categoryValue == category['_id']) {
          controller.updateCategory = ''; // clear selected category id in controller
          controller.updateTitle = ''; // clear selected title in controller
        } else if (category['title'] == 'More') { // if the tile is the "More" option
          Get.to(() => AllCategories(), // navigate to AllCategories screen
            transition: Transition.fadeIn, // apply a fade-in transition
            duration: const Duration(milliseconds: 900) // animation duration
          );
        } else { // select this category
          controller.updateCategory = category['_id']; // set selected category id
          controller.updateTitle = category['title']; // set selected category title
        }
      },
      child: Obx(() => Container( // Obx rebuilds this subtree when observed controller values change
        width: width * 0.19, // tile width as a fraction of shared global width
        margin: EdgeInsets.only(right: 5.w), // right spacing between tiles (responsive)
        padding: EdgeInsets.only(top: 4.h), // top padding inside the tile (responsive)
        decoration: BoxDecoration( // visual decoration for the tile
          borderRadius: BorderRadius.circular(10.r), // rounded corners (responsive radius)
          border: Border.all( // border around the tile
            color: controller.categoryValue == category['_id'] ? kSecondary : kOffWhite, // highlight border color if selected, otherwise neutral
            width: 0.5.w // border thickness (responsive)
          )
        ),
        child: Column( // vertical layout: image above, title below
          children: [
            SizedBox( // fixed-height box to contain the image
              height: 40.h, // responsive height for the image container
              child: Image.network(category['imageUrl'], fit: BoxFit.contain), // load category image from network and contain within box
            ),
            ReusableText( // display category title using the app's reusable text widget
              text: category['title'],
              style: appStyle(12, kDark, FontWeight.normal) // text style from appStyle helper
            )
          ],
        )
      )),
    );
  }
}