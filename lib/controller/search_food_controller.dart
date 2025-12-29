
import 'package:flutter/material.dart';
import 'package:foodly_app/constants/constants.dart';
import 'package:foodly_app/models/apiError.dart';
import 'package:foodly_app/models/foods.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class SearchFoodController extends GetxController{

  /* isLoading - State management for loading indicator */
  
  // Private reactive boolean variable to track loading state (observable)
  RxBool _isLoading = false.obs;

  // Getter to access the current loading state value
  bool get isLoading => _isLoading.value;

  // Setter to update the loading state value
  set setLoading(bool value) {
    _isLoading.value = value;
  }
  /* End of isLoading */

  /* isTriggered - State management for search trigger status */
  
  // Private reactive boolean variable to track if search has been triggered (observable)
  RxBool _isTriggered = false.obs;

  // Getter to access the current triggered state value
  bool get isTriggered => _isTriggered.value;

  // Setter to update the triggered state value
  set setTrigger(bool value) {
    _isTriggered.value = value;
  }
  /* End of isTriggered */

  // Nullable list to store the search results (list of FoodsModel objects)
  List<FoodsModel>? searchResults;

  // Async method to search for foods based on a search key/query
  void searchFoods(String key) async {
    // Set loading state to true to show loading indicator
    setLoading = true;

    // Construct the API endpoint URL by combining base URL with search endpoint and key
    Uri url = Uri.parse("$appLocalBaseUrl/api/foods/search/$key");

    // Try-catch block to handle potential errors during HTTP request
    try {
      // Make an asynchronous GET request to the API endpoint and wait for response
      var response = await http.get(url);
      
      // Commented out: Debug print to display the raw response body
      // print(response.body);

      // Check if the HTTP response status code is 200 (OK/Success)
      if(response.statusCode == 200) {
        // Parse the JSON response body and convert it to a list of FoodsModel objects
        searchResults = foodsModelFromJson(response.body);
        
        // Set loading state to false as data has been successfully loaded
        setLoading = false;
      } else{
        // Set loading state to false as request completed (but failed)
        setLoading = false;
        
        // Parse the error response body and convert it to an ApiError object
        var error = apiErrorFromJson(response.body);
      }
    } catch (e) {
      // If any exception occurs during the request, set loading to false
      setLoading = false;
      
      // Print the error message to the debug console for debugging purposes
      debugPrint(e.toString());
    }
  }

}