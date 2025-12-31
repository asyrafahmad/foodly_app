import 'package:get/get.dart';

class FoodController extends GetxController {

  RxInt currentPage = 0.obs;

  void changePage(int page) {
    currentPage.value = page;
    // print(currentPage.value);
  }
}