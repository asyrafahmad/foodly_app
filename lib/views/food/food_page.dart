import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodly_app/constants/constants.dart';
import 'package:foodly_app/controller/food_controller.dart';
import 'package:foodly_app/models/foods.dart';
import 'package:get/get.dart';

class FoodPage extends StatefulWidget {
  const FoodPage({super.key, required this.food});
  
  final FoodsModel food;

  @override
  State<FoodPage> createState() => _FoodPageState();
}

class _FoodPageState extends State<FoodPage> {

  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {

    // print(widget.food.description);
    // print(widget.food.imageUrl);

    final controller = Get.put(FoodController());

    return Scaffold(
      body: ListView(
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(bottomRight: Radius.circular(20.r)),
                child: Stack(
                  children: [
                    SizedBox(
                      height: 230.h,
                      child: PageView.builder(
                        controller: _pageController,
                        onPageChanged: (i) {
                          controller.changePage(i);
                        },
                        itemCount: widget.food.imageUrl.length,
                        itemBuilder: (context, i) {
                          // print(widget.food.imageUrl.length);
                          final image = widget.food.imageUrl[i];
                          return Container(
                            height: 230.h,
                            width: width,
                            color: kLightWhite,
                            child: CachedNetworkImage(
                              imageUrl: image,
                              fit: BoxFit.cover,
                            ),
                          );
                        },
                      ),
                    ),

                    Positioned(
                      bottom: 10,
                      child: Padding(
                        padding: EdgeInsets.only(left: 12.0),
                        child: Obx(() => Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(widget.food.imageUrl.length, (index) {
                            return Container(
                              margin: EdgeInsets.all(4.h),
                              width: 10.w,
                              height: 10.h,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: controller.currentPage == index ? kSecondary : kGrayLight,
                              ),
                            );
                          }),
                        )),
                      )
                    ),


                  ]
                )
              )
            ],
          )
        ],
      ),
    );
  }
}