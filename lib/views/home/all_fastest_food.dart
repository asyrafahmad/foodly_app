import 'package:flutter/material.dart';
import 'package:foodly_app/common/reusable_text.dart';
import 'package:foodly_app/constants/constants.dart';

class AllFastestFoodPage extends StatelessWidget {
  const AllFastestFoodPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.3,
        backgroundColor: kOffWhite,
        title: ReusableText(
          text: 'All Fastest Food',
          style: appStyle(13, kGray, FontWeight.w600),  
        ),
      ),
      body: const Center(
        child: Text('All of fastest food items will be shown here.'),
      ),
    );
  }
}