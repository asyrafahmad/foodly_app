// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:foodly_app/constants/constants.dart';
import 'package:foodly_app/controller/tab_index_controller.dart';
import 'package:foodly_app/views/cart/cart_page.dart';
import 'package:foodly_app/views/home/home_page.dart';
import 'package:foodly_app/views/profile/profile_page.dart';
import 'package:foodly_app/views/search/search_page.dart';
import 'package:get/get.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key});

  final controller = Get.put(TabIndexController());

  List<Widget> pageList = const [
    // Add your pages here
    // Example: HomePage(), SearchPage(), CartPage(), ProfilePage()
    HomePage(),
    SearchPage(),
    CartPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {

    return Obx(() =>  Scaffold(
        body: Stack(
          children: [
            pageList[controller.tabIndex],
            Align(
              alignment: Alignment.bottomCenter,
              child: Theme(
                data: Theme.of(context).copyWith(canvasColor: kPrimary),
                child: BottomNavigationBar(
                  showSelectedLabels: true,
                  showUnselectedLabels: false,
                  unselectedIconTheme: const IconThemeData(
                    color: kDark,
                  ),
                  selectedIconTheme: const IconThemeData(
                    color: kWhite,
                  ),
                  onTap: (value) {
                    // Handle navigation logic here
                    controller.setTabIndex = value;
                  },
                  currentIndex: controller.tabIndex,
                  items: [
                    BottomNavigationBarItem(
                      icon: controller.tabIndex == 0 ? Icon(AntDesign.appstore1) : Icon(AntDesign.appstore_o),
                      label: 'Home',
                    ),
                    const BottomNavigationBarItem(
                      icon: Icon(Icons.search),
                      label: 'Search',
                    ),
                    const BottomNavigationBarItem(
                      icon: Badge(
                        label: Text('1'),
                        child: Icon(FontAwesome.opencart)
                      ),
                      label: 'Cart',
                    ),
                    BottomNavigationBarItem(
                      icon: controller.tabIndex == 3 ? Icon(FontAwesome.user_circle) : Icon(FontAwesome.user_circle_o),
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