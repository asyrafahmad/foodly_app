import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodly_app/common/app_style.dart';
import 'package:foodly_app/common/background_container.dart';
import 'package:foodly_app/common/reusable_text.dart';
import 'package:foodly_app/common/shimmers/foodlist_shimmer.dart';
import 'package:foodly_app/constants/constants.dart';
import 'package:foodly_app/constants/uidata.dart';
import 'package:foodly_app/hooks/fetch_all_restaurants.dart';
import 'package:foodly_app/models/restaurant.dart';
import 'package:foodly_app/views/home/widgets/restaurant_tile.dart';

class AllNearbyRestaurantsPage extends HookWidget {
  const AllNearbyRestaurantsPage({super.key});


  @override
  Widget build(BuildContext context) {

    final hookResults = useFetchAllRestaurants("fg43gf43r3f4");
    List<RestaurantsModel>? restaurantsList = hookResults.data;
    final isLoading = hookResults.isLoading;

    return Scaffold(
      appBar: AppBar(
        elevation: 0.3,
        backgroundColor: kOffWhite,
        title: ReusableText(
          text: 'All Nearby Restaurants',
          style: appStyle(13, kGray, FontWeight.w600),  
        ),
      ),
      body: BackgroundContainer(
        color: Colors.white,
        child: isLoading 
            ? const FoodsListShimmer() 
            :  Padding(
                padding: EdgeInsets.fromLTRB(12.w, 12.h, 12.w, 12.h),
                child: ListView(
                  children: List.generate(restaurantsList!.length, (i) {
                    RestaurantsModel restaurant = restaurantsList[i];
                    return RestaurantTile(
                      restaurant: restaurant,
                    );
                  }),
                ),
              ),
      ),
    );
  }
}