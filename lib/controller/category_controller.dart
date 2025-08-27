// ignore_for_file: prefer_final_fields

import 'package:get/get.dart';

/// Controller that holds and updates category-related state for the app.
/// Extends GetxController so it can be used with GetX reactive state management.
class CategoryController extends GetxController {

  /// Observable string that stores the current category value.
  /// `.obs` converts the plain String into an RxString so listeners update when it changes.
  RxString _category = ''.obs;

  /// Public getter that returns the current category as a plain `String`.
  /// Use this to read the category value from outside the controller.
  String get categoryValue => _category.value;

  /// Setter that updates the `_category` observable.
  /// Writing to this triggers reactive updates for any widgets or listeners bound to `_category`.
  set updateCategory(String value) {
    _category.value = value;
  }

  /// Observable string that stores the current title (related to category or UI).
  /// Made reactive with `.obs` so changes propagate automatically.
  RxString _title = ''.obs;

  /// Public getter that returns the current title as a plain `String`.
  String get titleValue => _title.value;

  /// Setter that updates the `_title` observable.
  /// Use this to change the title and notify listeners.
  set updateTitle(String value) {
    _title.value = value;
  }
}