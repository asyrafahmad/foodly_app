import 'package:get/get.dart';

class FoodController extends GetxController {

  RxInt currentPage = 0.obs;

  void changePage(int page) {
    currentPage.value = page;
    // print(currentPage.value);
  }

  RxInt count = 1.obs;

  void increment() {
    count.value++;
  }

  void decrement() {
    if (count.value > 1) {
      count.value--;
    }
  }
}