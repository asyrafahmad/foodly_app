import 'package:flutter/material.dart';
import 'package:foodly_app/models/restaurant.dart';

class FetchRestaurantHook {
  final RestaurantsModel? data;
  final bool isLoading;
  final String? error;
  final VoidCallback refetch;

  FetchRestaurantHook({
    required this.data,
    required this.isLoading,
    required this.error,
    required this.refetch,
  });
}