import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodly_app/common/shimmers/nearby_shimmer.dart';
import 'package:foodly_app/hooks/fetch_restaurants.dart';
import 'package:foodly_app/models/restaurant.dart';
import 'package:foodly_app/views/home/widgets/restaurant_widget.dart';

class NearbyRestaurantsList extends HookWidget {
  const NearbyRestaurantsList({super.key});

  @override
  Widget build(BuildContext context) {
    final hookResults = useFetchRestaurants("fg43gf43r3f4");
    List<RestaurantsModel>? restaurantsList = hookResults.data;
    final isLoading = hookResults.isLoading;

    // return isLoading  // FIX ERROR ASYRAF
    return isLoading || restaurantsList == null
      ? const NearbyShimmer() 
      : Container(
        height: 190.h,
        padding: EdgeInsets.only(left: 12.w, top: 10.h),
        child:  ListView(
          scrollDirection: Axis.horizontal,
          // children: List.generate(restaurantsList!.length, (i) {   // FIX ERROR ASYRAF
          children: List.generate(restaurantsList.length, (i) {
            RestaurantsModel restaurant = restaurantsList[i];

            return RestaurantWidget(
              image: restaurant.imageUrl, 
              logo: restaurant.logoUrl, 
              title: restaurant.title, 
              time: restaurant.time, 
              rating: "324324",
            );
          }),
        ),
      );
  }
}