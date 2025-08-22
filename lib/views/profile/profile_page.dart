import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodly_app/common/custom_container.dart';
import 'package:foodly_app/constants/constants.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimary,
      appBar: AppBar(
        title: PreferredSize(
          preferredSize: Size.fromHeight(130.h), 
          child: Container(
            height: 130.h
          )
        ),
      ),
      body: SafeArea(
        child: CustomContainer(
          containerContent: Container(

          )
        )
      ),
    );
  }
}