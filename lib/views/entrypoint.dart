import 'package:flutter/material.dart';
import 'package:foodly_app/constants/constants.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image or color
          Container(
            height: height,
            width: width,
            color: kOffWhite,
          ),
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
                  print("Selected index: $value");
                },
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.search),
                    label: 'Search',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.shopping_cart),
                    label: 'Cart',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.person),
                    label: 'Profile',
                  ),
                ]
              ),
            ),
          )
        ],
      ),
    );
  }
}