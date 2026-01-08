// Import for caching and displaying network images efficiently
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:foodly_app/common/app_style.dart';
import 'package:foodly_app/common/custom_button.dart';
import 'package:foodly_app/common/custom_text_field.dart';
import 'package:foodly_app/common/reusable_text.dart';
import 'package:foodly_app/constants/constants.dart';
import 'package:foodly_app/controller/food_controller.dart';
import 'package:foodly_app/hooks/fetch_restaurant.dart';
import 'package:foodly_app/models/foods.dart';
import 'package:foodly_app/views/auth/phone_verification.dart';
import 'package:foodly_app/views/restaurant/restaurant_page.dart';
import 'package:get/get.dart';

// StatefulHookWidget that displays detailed food item information
// Combines StatefulWidget with Flutter Hooks functionality
class FoodPage extends StatefulHookWidget {
  // Constructor requiring a FoodsModel object
  const FoodPage({super.key, required this.food});
  
  // The food item to display details for
  final FoodsModel food;

  // Create the mutable state for this widget
  @override
  State<FoodPage> createState() => _FoodPageState();
}

// Private state class for FoodPage
class _FoodPageState extends State<FoodPage> {

  // Text controller for managing user's food preferences/notes input
  final TextEditingController _preferencesController = TextEditingController();
  
  // Page controller for managing the image carousel/PageView
  final PageController _pageController = PageController();

  // Build method to construct the widget tree
  @override
  Widget build(BuildContext context) {

    // Debug print statements (commented out) for food description and images
    // print(widget.food.description);
    // print(widget.food.imageUrl);

    // Fetch restaurant data using custom hook based on restaurant ID
    final hookResult = useFetchRestaurant(widget.food.restaurant);
    
    // Initialize FoodController using GetX dependency injection
    final controller = Get.put(FoodController());
    
    // Load the food's additives into the controller
    controller.loadAdditives(widget.food.additives);
    
    // Debug print to display food tags
    print(widget.food.foodTags);

    // Return the main scaffold structure
    return Scaffold(
      // Body contains a scrollable list view
      body: ListView(
        // Remove default padding
        padding: EdgeInsets.zero,
        // List of child widgets
        children: [
          // ClipRRect to create rounded bottom-right corner for the image section
          ClipRRect(
            // Apply border radius only to bottom-right corner
            borderRadius: BorderRadius.only(bottomRight: Radius.circular(20.r)),
            // Stack allows overlaying multiple widgets (images, buttons, indicators)
            child: Stack(
              children: [
          
                // SECTION: Image Carousel (PageView)
                // SizedBox to constrain the height of the image carousel
                SizedBox(
                  height: 230.h,
                  // PageView.builder creates a swipeable image carousel
                  child: PageView.builder(
                    // Controller to manage page changes programmatically
                    controller: _pageController,
                    // Callback when user swipes to a different page
                    onPageChanged: (i) {
                      // Update the current page in the controller
                      controller.changePage(i);
                    },
                    // Number of images to display in the carousel
                    itemCount: widget.food.imageUrl.length,
                    // Builder function to create each page/image
                    itemBuilder: (context, i) {
                      // Debug print (commented out) for image count
                      // print(widget.food.imageUrl.length);
                      // Get the image URL at current index
                      final image = widget.food.imageUrl[i];
                      // Return a container with the image
                      return Container(
                        height: 230.h,
                        width: width,
                        // Background color while image loads
                        color: kLightWhite,
                        // CachedNetworkImage for efficient image loading and caching
                        child: CachedNetworkImage(
                          imageUrl: image,
                          // Cover the entire container while maintaining aspect ratio
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                  ),
                ),
          
                // SECTION: Page Indicators (dots showing current image)
                // Positioned widget to place indicators at bottom of stack
                Positioned(
                  bottom: 10,
                  child: Padding(
                    padding: EdgeInsets.only(left: 12.0),
                    // Obx makes this widget reactive to controller changes
                    child: Obx(
                      () => Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        // Generate indicator dots based on number of images
                        children: List.generate(widget.food.imageUrl.length, (index) {
                          // Each dot is a circular container
                          return Container(
                            margin: EdgeInsets.all(4.h),
                            width: 10.w,
                            height: 10.h,
                            decoration: BoxDecoration(
                              // Circular shape
                              shape: BoxShape.circle,
                              // Active page is kSecondary color, others are gray
                              color: controller.currentPage == index ? kSecondary : kGrayLight,
                            ),
                          );
                        }),
                      )
                    ),
                  )
                ),
          
                // SECTION: Back Button (top-left)
                // Positioned widget to place back button at top-left
                Positioned(
                  top: 40.h,
                  left: 12.w,
                  // GestureDetector to handle tap events
                  child: GestureDetector(
                    onTap: () {
                      // Navigate back to previous screen
                      Get.back();
                    },
                    // Back arrow icon
                    child: const Icon(
                      Ionicons.chevron_back_circle,
                      color: kPrimary,
                      size: 30,
                    )
                  ),
                ),
          
                // SECTION: Open Restaurant Button (bottom-right)
                // Positioned widget to place button at bottom-right
                Positioned(
                  bottom: 10,
                  right: 12.w,
                  // Custom button widget
                  child: CustomButton(
                    btnWidth: 120.w,
                    text: "Open Restaurant",
                    // Navigate to restaurant page when tapped
                    onTap: () {
                      Get.to(() => RestaurantPage(restaurant: hookResult.data));
                    },
                  ),
                ),
              ]
            )
          ),

          // SECTION: Food Details (Title, Price, Description, Tags)
          // Padding widget to add horizontal spacing
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            // Column to stack food details vertically
            child: Column(
              // Align children to the start (left)
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                // Row for food title and dynamic price
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Display food title
                    ReusableText(text: widget.food.title, style: appStyle(18, kDark, FontWeight.w600)),
                    // Obx makes price reactive to quantity and additive changes
                    Obx(() => ReusableText(
                      // Calculate total: (base price + additives) * quantity
                      text: "RM ${((widget.food.price + controller.additivePrice) * controller.count.value)}", 
                      style: appStyle(18, kPrimary, FontWeight.w600)
                    )),
                  ],
                ),
            
                SizedBox(height: 5.h),
                // Display food description with justified text alignment
                Text(
                  widget.food.description, 
                  textAlign: TextAlign.justify,
                  style: appStyle(14, kGray, FontWeight.w400)
                ),
            
                SizedBox(height: 5.h),
                // Horizontal scrollable list of food tags
                SizedBox(
                  height: 18.h,
                  child: ListView(
                    // Enable horizontal scrolling
                    scrollDirection: Axis.horizontal,
                    // Generate tag widgets based on food tags
                    children: List.generate(widget.food.foodTags.length, (i) {
            
                      // Get the tag at current index
                      final tag = widget.food.foodTags[i];
            
                      // Return a styled container for each tag
                      return Container(
                        height: 15.h,
                        width: 50.w,
                        // Add spacing between tags
                        margin: EdgeInsets.only(right: 5.w),
                        // Rounded pill-shaped decoration
                        decoration: BoxDecoration(
                          color: kPrimary,
                          borderRadius: BorderRadius.all(Radius.circular(15.r)),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 6.w),
                          // Display tag text in white
                          child: ReusableText(
                            text: tag, 
                            style: appStyle(11, kWhite, FontWeight.w400)
                          ),
                        ),
                      );
                    }),
                  ),
                ),
            
                SizedBox(height: 15.h),
                // SECTION: Additives and Toppings
                // Section title
                ReusableText(text: "Additives and Toppings", style: appStyle(18, kDark, FontWeight.w600)),
                
                SizedBox(height: 10.h),
                // Obx makes the list reactive to checkbox state changes
                Obx(() => Column(
                  // Generate checkbox list items for each additive
                  children: List.generate(controller.additivesList.length, (i) {
                    // Get the additive at current index
                    final additive = controller.additivesList[i];
            
                    // CheckboxListTile for each additive option
                    return CheckboxListTile(
                      // Remove default padding
                      contentPadding: EdgeInsets.zero,
                      // Compact visual density for tighter spacing
                      visualDensity: VisualDensity.compact,
                      // Dense layout
                      dense: true,
                      // Color when checkbox is checked
                      activeColor: kSecondary,
                      // Current checked state from observable
                      value: additive.isChecked.value,
                      // Disable indeterminate state
                      tristate: false,
                      // Callback when checkbox state changes
                      onChanged: (bool? value) {
                        // Toggle the checked state
                        additive.toggleChecked();
                        // Recalculate total price with new selection
                        controller.getTotalPrice();
                      },
                      // Row displaying additive name and price
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Additive name
                          ReusableText(
                            text: additive.title,
                            style: appStyle(
                              11, 
                              kDark, 
                              FontWeight.w400
                            )
                          ),
                          SizedBox(
                            width: 5.w,
                          ),
                          // Additive price
                          ReusableText(
                            text: "RM ${additive.price}",
                            style: appStyle(
                              11, 
                              kPrimary, 
                              FontWeight.w600
                            )
                          ),
                        ],
                      ),
                    );
                  })
                ),),
                
                SizedBox(height: 20.h),
                // SECTION: Quantity Controls
                // Row for quantity label and increment/decrement buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // "Quantity" label
                    ReusableText(
                      text: "Quantity",
                      style: appStyle(
                        18, 
                        kDark, 
                        FontWeight.bold
                      )
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    // Row containing increment, count display, and decrement buttons
                    Row(
                      children: [
                        // Increment button (+)
                        GestureDetector(
                          onTap: () {
                            // Increase quantity by 1
                            controller.increment();
                          },
                          child: const Icon(
                            AntDesign.pluscircleo,
                            color: kPrimary,
                            size: 20,
                          ),
                        ),
            
                        // Display current quantity count
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          // Obx makes count reactive to changes
                          child: Obx(() => ReusableText(
                            text: "${controller.count.value}", 
                            style: appStyle(14, kDark, FontWeight.w600)
                          )),
                        ),
            
                        // Decrement button (-)
                        GestureDetector(
                          onTap: () {
                            // Decrease quantity by 1 (minimum 1)
                            controller.decrement();
                          },
                          child: const Icon(
                            AntDesign.minuscircleo,
                            color: kPrimary,
                            size: 20,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
            
                SizedBox(height: 20.h),
                // SECTION: Preferences/Notes
                // Section title
                ReusableText(text: "Preferences", style: appStyle(18, kDark, FontWeight.bold)),
            
                SizedBox(height: 5.h),
                // Text field for user to add custom preferences/notes
                SizedBox(
                  height: 65.h,
                  child: CustomTextWidget(
                    controller: _preferencesController,
                    hintText: "Add a note with your preferences",
                    // Allow 3 lines of text
                    maxLines: 3,
                  )
                ),

                SizedBox(
                  height: 15.h,
                ),
                // SECTION: Place Order Button
                // Container with rounded corners for order button
                Container(
                  height: 40.h,
                  decoration: BoxDecoration(
                    color: kLightWhite,
                    borderRadius: BorderRadius.circular(30.r),
                  ),
                  // Row containing "Place Order" text and cart icon
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      
                      // "Place Order" button
                      GestureDetector(
                        onTap: () {
                          // Show phone verification bottom sheet
                          _showVerificationSheet(context);
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12.w),
                          child: ReusableText(
                            text: "Place Order", 
                            style: appStyle(18, kLightWhite, FontWeight.w600)
                          ),
                        ),
                      ),

                      // Cart icon button (currently no action)
                      GestureDetector(
                        onTap: () {
                          // TODO: Add to cart functionality
                        },
                        child: CircleAvatar(
                          backgroundColor: kSecondary,
                          radius: 20.r,
                          child: const Icon(
                            Ionicons.cart,
                            color: kLightWhite,
                            size: 20,
                          ),
                        ),
                      ),
                      
                    ],
                  )
                )
              ],
            )
          )
          
        ],
      ),
    );
  }

  // Method to display a modal bottom sheet for phone verification
  // Returns a Future<dynamic> representing the bottom sheet result
  Future<dynamic> _showVerificationSheet(BuildContext context) {
    // Show modal bottom sheet with custom styling
    return  showModalBottomSheet(
      context: context,
      // Transparent background to show custom decoration
      backgroundColor: Colors.transparent,
      // Show drag handle at top of sheet
      showDragHandle: true,
      // Builder function to create the sheet content
      builder: (context) {
        // Container for the bottom sheet content
        return Container(
          height: 500.h,
          width: width,
          // Decoration with background image and rounded corners
          decoration: const BoxDecoration(
            // Background image for visual appeal
            image: DecorationImage(
              image: AssetImage("assets/images/restaurant_bk.png"),
              fit: BoxFit.fill
            ),
            color: kLightWhite,
            // Rounded top corners for modal appearance
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ) 
          ),
          // Padding around the content
          child: Padding(
            padding: EdgeInsets.all(8.h),
            // Column to stack verification UI elements vertically
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 10.h
                ),

                // Title text for the verification sheet
                ReusableText(
                  text: "Verify Your Number", 
                  style: appStyle(18, kPrimary, FontWeight.w600)
                ),

                // Container for the list of verification reasons
                SizedBox(
                  height: 250.h,
                  child: Column(
                    // Generate list tiles for each verification reason
                    children: List.generate(verificationReasons.length, (index) {
                      // ListTile with checkmark icon and reason text
                      return ListTile(
                        // Checkmark icon on the left
                        leading: Icon(
                          Icons.check_circle_outline, 
                          color: kPrimary
                        ),
                        // Verification reason text
                        title: Text(
                          verificationReasons[index], 
                          textAlign: TextAlign.justify,
                          style: appStyle(11, kGrayLight, FontWeight.normal)
                        )
                      );
                    })
                  )
                ),

                SizedBox(
                  height: 10.h
                ),

                // Button to navigate to phone verification page
                CustomButton(
                  text: "Verify Phone Number",
                  btnHeight: 35.h,
                  // Navigate to PhoneVerificationPage when tapped
                  onTap: () {
                    Get.to(() => const PhoneVerificationPage());
                  },
                ),

                
              ],
            ),
          ),
        );
      }
    );
  }
}