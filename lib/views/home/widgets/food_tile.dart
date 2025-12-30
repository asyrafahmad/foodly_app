// Core Flutter material widgets
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
// ScreenUtil for responsive sizing (w, h, r helpers)
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:foodly_app/common/app_style.dart';
import 'package:foodly_app/common/reusable_text.dart';
import 'package:foodly_app/common/shimmers/nearby_shimmer.dart';
import 'package:foodly_app/constants/constants.dart';
import 'package:foodly_app/hooks/fetch_foods.dart';
import 'package:foodly_app/models/foods.dart';
// Reusable FoodWidget that renders a single food card/item
import 'package:foodly_app/views/home/widgets/food_widget.dart';

class FoodTile extends HookWidget {
  // Stateless list of food items shown horizontally.
  // If you need to react to user interaction or selection state, convert
  // this to a StatefulWidget or use a state-management solution (GetX, Provider, etc.).
  const FoodTile({super.key, required this.food, this.color});

  final FoodsModel food;
  final Color? color;

  @override
  Widget build(BuildContext context) {


    // Container gives a fixed height for the horizontal list and padding
    // so the cards align with other horizontal content on the screen.
    return GestureDetector(
      onTap: () {},
      child: Stack(
        clipBehavior: Clip.hardEdge,
        children: [
          Container(
            margin: EdgeInsets.only(right: 12.w),
            height: 70 .h,
            width: width,
            decoration: BoxDecoration(
              color: color ?? kOffWhite ,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Container(
              padding: EdgeInsets.all(4.r),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(12.r)),
                    child: Stack(
                      children: [
                        SizedBox(
                          width: 70.w,
                          height: 70.h,
                          child: Image.network(
                            food.imageUrl[0],
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          child: Container(
                            padding:
                                const EdgeInsets.only(left: 6, bottom: 2),
                            color: kGray.withOpacity(0.6),
                            height: 16,
                            width: width,
                            child: RatingBarIndicator(
                              rating: 5,
                              itemBuilder: (context, index) => const Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              itemCount: 5,
                              itemSize: 15.0,
                              direction: Axis.horizontal,
                            ),
                          )
                        ),
                      ]
                    )
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 5,
                      ),
                      ReusableText(
                          text: food.title,
                          style: appStyle(11, kDark, FontWeight.w400)),
                      ReusableText(
                          text: "Delivery time: ${food.time}",
                          style: appStyle(9, kGray, FontWeight.w400)),
                      const SizedBox(
                        height: 5,
                      ),
                      SizedBox(
                        height: 18,
                        width: width * 0.67,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: food.additives.length,
                            itemBuilder: (context, i) {
                              final addittives = food.additives[i];
                              return Container(
                                margin: const EdgeInsets.only(right: 5),
                                decoration: const BoxDecoration(
                                    color: kSecondaryLight,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(9))),
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: ReusableText(
                                        text: addittives.title,
                                        style: appStyle(
                                            8, kGray, FontWeight.w400)),
                                  ),
                                ),
                              );
                            }),
                      ),
                    ],
                  )
                ]
              ),
            ),
          ),
          Positioned(
            right: 5,
            top: 6.h,
            child: Container(
              width: 60.h,
              height: 19.h,
              decoration: const BoxDecoration(
                  color: kPrimary,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  )),
              child: Center(
                child: ReusableText(
                  text: "\$ ${food.price.toString()}",
                  style: appStyle(12, kLightWhite, FontWeight.bold),
                ),
              ),
            ),
          ),
          Positioned(
            right: 70.h,
            top: 6.h,
            child: Container(
              width: 19.h,
              height: 19.h,
              decoration: const BoxDecoration(
                  color: kSecondary,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: GestureDetector(
                onTap: () {},
                child: const Center(
                  child: Icon(
                    MaterialCommunityIcons.cart_plus,
                    size: 15,
                    color: kLightWhite,
                  ),
                ),
              ),
            )
          )
        ]
      )
    );
  }
} 