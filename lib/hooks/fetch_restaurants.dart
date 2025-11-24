import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:foodly_app/constants/constants.dart';
import 'package:foodly_app/models/apiError.dart';
import 'package:foodly_app/models/categories.dart';
import 'package:foodly_app/models/hook_models/hook_result.dart';
import 'package:foodly_app/models/restaurant.dart';
import 'package:http/http.dart' as http;

FetchHook useFetchRestaurants(String code) {

  final restaurantItems = useState<List<RestaurantsModel>?>(null);
  final isLoading = useState<bool>(false);
  final error = useState<Exception?>(null);
  final apiError = useState<ApiError?>(null);

  Future<void> fetchData() async {
    isLoading.value = true;

    try {
      print("fetchData called /api/restaurant/$code");

      Uri url = Uri.parse('$appLocalBaseUrl/api/restaurant');
      print("URL = $url");

      final response = await http.get(url);
      print("RESPONSE = $response");
      print (response);

      if (response.statusCode == 200) {

        final List<RestaurantsModel> restaurants = restaurantModelFromJson(response.body);
        restaurantItems.value = restaurants;

      } else {

        final List<ApiError> apiErrors = apiErrorFromJson(response.body);

        if (apiErrors.isNotEmpty) {
          apiError.value = apiErrors[0];
          error.value = Exception('API Error: ${apiErrors[0].message}');
        } else {
          error.value = Exception('Unknown API error occurred');
        }
      }

    } catch (e) {
      error.value = Exception('Failed to fetch categories: $e');
    } finally {
      isLoading.value = false;
    }
  }

  useEffect(() {
    fetchData();
    return null;
  }, []);

  void refetch() {
    isLoading.value = true;
    fetchData();
  }

  return FetchHook(
    data: restaurantItems.value,
    isLoading: isLoading.value,
    error: error.value?.toString(),
    refetch: refetch,
  );

}

  