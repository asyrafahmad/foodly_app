// ignore_for_file: prefer_const_constructors_in_immutables, must_be_immutable

// Required Flutter and third-party package imports
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart'; // For custom icons
import 'package:foodly_app/constants/constants.dart'; // App-wide constants (colors, etc.)
import 'package:foodly_app/controller/tab_index_controller.dart'; // Controls bottom navigation state
import 'package:foodly_app/views/cart/cart_page.dart'; // Shopping cart view
import 'package:foodly_app/views/home/home_page.dart'; // Main home view
import 'package:foodly_app/views/profile/profile_page.dart'; // User profile view
import 'package:foodly_app/views/search/search_page.dart'; // Search functionality view
import 'package:get/get.dart'; // State management with GetX

/// MainScreen is the root widget that manages the bottom navigation and page switching
/// This screen contains the bottom navigation bar and handles switching between different pages
class MainScreen extends StatelessWidget {
  MainScreen({super.key});

  // Initialize the tab controller using GetX for state management
  final controller = Get.put(TabIndexController());

  // List of all pages that can be navigated to from the bottom navigation bar
  // The index of each page corresponds to its tab index in the bottom navigation bar
  List<Widget> pageList = const [
    HomePage(),     // Index 0: Main home page with food listings
    SearchPage(),   // Index 1: Search functionality
    CartPage(),     // Index 2: Shopping cart with order items
    ProfilePage(),  // Index 3: User profile and settings
  ];

  @override
  Widget build(BuildContext context) {
    // Wrap with Obx for reactive state management - will rebuild when tab index changes
    return Obx(() =>  Scaffold(
        body: Stack(
          children: [
            // Display the current page based on selected tab index
            pageList[controller.tabIndex],
            // Position the bottom navigation bar at the bottom of the screen
            Align(
              alignment: Alignment.bottomCenter,
              child: Theme(
                // Set the background color of the bottom navigation bar
                data: Theme.of(context).copyWith(canvasColor: kPrimary),
                child: BottomNavigationBar(
                  showSelectedLabels: true,      // Show labels for selected tabs
                  showUnselectedLabels: false,   // Hide labels for unselected tabs
                  // Style for unselected icons
                  unselectedIconTheme: const IconThemeData(
                    color: kDark,  // Dark color for unselected icons
                  ),
                  // Style for selected icons
                  selectedIconTheme: const IconThemeData(
                    color: kWhite, // White color for selected icons
                  ),
                  // Handle tab selection
                  onTap: (value) {
                    // Update the current tab index when a tab is tapped
                    controller.setTabIndex = value;
                  },
                  // Current selected tab index from the controller
                  currentIndex: controller.tabIndex,
                  items: [
                    // Home tab - Changes icon based on selection state
                    BottomNavigationBarItem(
                      icon: controller.tabIndex == 0 
                        ? Icon(AntDesign.appstore1)    // Selected home icon
                        : Icon(AntDesign.appstore_o),  // Unselected home icon
                      label: 'Home',
                    ),
                    // Search tab
                    const BottomNavigationBarItem(
                      icon: Icon(Icons.search),
                      label: 'Search',
                    ),
                    // Cart tab with badge showing number of items
                    const BottomNavigationBarItem(
                      icon: Badge(
                        label: Text('1'),  // Number of items in cart
                        child: Icon(FontAwesome.opencart)
                      ),
                      label: 'Cart',
                    ),
                    // Profile tab - Changes icon based on selection state
                    BottomNavigationBarItem(
                      icon: controller.tabIndex == 3 
                        ? Icon(FontAwesome.user_circle)    // Selected profile icon
                        : Icon(FontAwesome.user_circle_o), // Unselected profile icon
                      label: 'Profile',
                    ),
                  ]
                ),
              ),
            )
            ],
        ),
      )
    );
  }
}