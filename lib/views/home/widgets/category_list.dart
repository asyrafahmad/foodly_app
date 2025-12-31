import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodly_app/common/shimmers/categories_shimmer.dart';
import 'package:foodly_app/hooks/fetch_all_categories.dart';
import 'package:foodly_app/models/categories.dart';
import 'package:foodly_app/views/home/widgets/category_widget.dart';

class CategoryList extends HookWidget {
  const CategoryList({super.key});

  @override
  Widget build(BuildContext context) {

    final hookResult = useFetchAllCategories();
    List<CategoriesModel>? categoriesList = hookResult.data;
    // final categories = categoriesList ?? <CategoriesModel>[];
    final isLoading = hookResult.isLoading;
    // final error = hookResult.error;

    return isLoading 
    // return isLoading || categoriesList == null
        ? const CatergoriesShimmer() 
        : SizedBox(
          height: 80.h,
          child:  ListView(
            scrollDirection: Axis.horizontal,
            children: List.generate(categoriesList!.length, (i) {
            // children: List.generate(categoriesList.length, (i) {
              CategoriesModel category = categoriesList[i];

              return CategoryWidget(category: category);

            }),
          ),
        );
  }
}
