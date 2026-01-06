import 'package:flutter/material.dart';
import 'package:foodly_app/models/restaurant.dart';

class RestaurantPage extends StatefulWidget {
  const RestaurantPage({super.key, required this.restaurant});

  final RestaurantsModel? restaurant;

  @override
  State<RestaurantPage> createState() => _RestaurantPageState();
}

class _RestaurantPageState extends State<RestaurantPage> {
  @override
  Widget build(BuildContext context) {

    // print(widget.restaurant!.pickup);

    return Scaffold(
      appBar: AppBar(),
      body: Container(),
    );
  }
}