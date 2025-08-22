import 'package:get/get.dart';

class TabIndexController extends GetxController {
 
  // Observable variable to hold the current tab index (RxInt must have observable - obs)
  RxInt _tabIndex = 0.obs;

  int get tabIndex => _tabIndex.value;

  set setTabIndex(int newValue) {
    _tabIndex.value = newValue;
  }
}