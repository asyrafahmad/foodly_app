import 'package:flutter/material.dart';
import 'package:foodly_app/common/app_style.dart';
import 'package:foodly_app/common/reusable_text.dart';
import 'package:foodly_app/constants/constants.dart';

class RecommendationsPage extends StatelessWidget {
  const RecommendationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.3,
        backgroundColor: kOffWhite,
        title: ReusableText(
          text: 'Recommendations',
          style: appStyle(13, kGray, FontWeight.w600),  
        ),
      ),
      body: const Center(
        child: Text('List of recommended food items will be shown here.'),
      ),
    );
  }
}