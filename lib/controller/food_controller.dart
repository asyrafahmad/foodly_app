// Import the AdditiveObs model for observable additive items
import 'package:foodly_app/models/additive_obs.dart';

// Import the Foods model containing Additive class definition
import 'package:foodly_app/models/foods.dart';

// Import GetX package for state management and reactive programming
import 'package:get/get.dart';

// Controller class for managing food-related state and operations
// Extends GetxController to enable reactive state management
class FoodController extends GetxController {

  // Observable integer to track the current page/tab in the food details view
  // Initialized to 0 (first page), .obs makes it reactive
  RxInt currentPage = 0.obs;
  
  // Boolean flag to set the initial checked state for additives
  // Set to false so additives are unchecked by default
  bool initialCheckValue = false;
  
  // Observable list to store all available additives for the current food item
  // Empty list initialized as observable to track changes reactively
  var additivesList = <AdditiveObs>[].obs;

  // Method to change the current page/tab index
  // Takes an integer page number as parameter
  void changePage(int page) {
    // Update the currentPage observable value with the new page number
    currentPage.value = page;
    // Debug print statement (commented out) to log page changes
    // print(currentPage.value);
  }

  // Observable integer to track the quantity/count of food items to order
  // Initialized to 1 (minimum order quantity)
  RxInt count = 1.obs;

  // Method to increase the food item quantity by 1
  void increment() {
    // Increment the count value by 1
    count.value++;
  }

  // Method to decrease the food item quantity by 1
  void decrement() {
    // Check if count is greater than 1 to prevent going below minimum
    if (count.value > 1) {
      // Decrement the count value by 1
      count.value--;
    }
  }

  // Method to load and initialize additives from a list of Additive objects
  // Takes a List<Additive> as parameter (from the food item data)
  void loadAdditives(List<Additive> additives) {
    // Clear any existing additives from the list to start fresh
    additivesList.clear();

    // Loop through each additive in the provided list
    for (var additiveInfo in additives) {
      // Create a new AdditiveObs object (observable version of Additive)
      var additive = AdditiveObs(
        // Copy the id from the original additive
        id: additiveInfo.id, 
        // Copy the title/name from the original additive
        title: additiveInfo.title, 
        // Copy the price from the original additive
        price: additiveInfo.price,
        // Set the initial checked state (false by default)
        checked: initialCheckValue
      );

      // Check if the additives list is already full (prevents duplicates)
      if(additives.length == additivesList.length) {
        // Do nothing if list is already complete (empty block)
      } else {
        // Add the new observable additive to the list
        additivesList.add(additive);
        // Print the current length of the additives list for debugging
        print(additivesList.length);
      }
    }
  }

  // Method to get a list of titles of all checked/selected additives
  // Returns a List<String> containing the names of selected additives
  List<String> getList() {
    // Initialize an empty list to store selected additive titles
    List<String> ads = [];

    // Loop through each additive in the additives list
    for (var additive in additivesList) {
      // Check if the additive is checked AND not already in the list
      if (additive.isChecked.value && !ads.contains(additive.title)) {
        // Add the additive title to the list
        ads.add(additive.title);
      }
      // Check if the additive is unchecked BUT is in the list
      else if (!additive.isChecked.value && ads.contains(additive.title)) {
        // Remove the additive title from the list
        ads.remove(additive.title);
      }
    }
    // Return the final list of selected additive titles
    return ads;
  }

  
  // Private observable double to store the total price of selected additives
  // Initialized to 0.0, .obs makes it reactive
  RxDouble _totalPrice = 0.0.obs; 
  
  // Getter to access the total additive price value
  // Returns the current value of _totalPrice as a double
  double get additivePrice  => _totalPrice.value;

  // Setter to update the total price with a new value
  // Takes a double newPrice as parameter
  set setTotalPrice(double newPrice) {
    // Update the _totalPrice observable value with the new price
    _totalPrice.value = newPrice;
  }

  // Method to calculate and return the total price of all selected additives
  // Returns a double representing the sum of all checked additive prices
  double getTotalPrice() {
    // Initialize a local variable to accumulate the total price
    double totalPrice = 0.0;

    // Loop through each additive in the additives list
    for (var additive in additivesList) {
      // Check if the current additive is selected/checked
      if (additive.isChecked.value) {
        // Parse the price string to double and add to total
        // Use tryParse with null coalescing (?? 0.0) to handle invalid prices
        totalPrice += double.tryParse(additive.price) ?? 0.0;
      }
    }

    // Update the _totalPrice observable using the setter
    setTotalPrice = totalPrice;
    // Debug print statement (commented out) to log the total price
    // print(additivePrice);
    // Return the calculated total price
    return totalPrice;
  }
}