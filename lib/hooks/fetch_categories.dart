import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:foodly_app/constants/constants.dart';
import 'package:foodly_app/models/apiError.dart';
import 'package:foodly_app/models/categories.dart';
import 'package:foodly_app/models/hook_models/hook_result.dart';
import 'package:http/http.dart' as http;

FetchHook useFetchCategories() {

  final categoriesItems = useState<List<CategoriesModel>?>(null);
  final isLoading = useState<bool>(false);
  final error = useState<Exception?>(null);
  final apiError = useState<ApiError?>(null);

  Future<void> fetchData() async {
    isLoading.value = true;

    try {
      print("fetchData CALLED");

      Uri url = Uri.parse('$appLocalBaseUrl/api/category');
      print("URL = $url");

      final response = await http.get(url);
      print("RESPONSE = $response");

      // if(response.statusCode == 200) {
      //   categoriesItems.value = categoriesModelFromJson(response.body);
      // } else {
      //   apiError.value = apiErrorFromJson(response.body);
      // }
      
      print (response);

      if (response.statusCode == 200) {

        final List<CategoriesModel> categories = categoriesModelFromJson(response.body);
        categoriesItems.value = categories;

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
    data: categoriesItems.value,
    isLoading: isLoading.value,
    error: error.value?.toString(),
    refetch: refetch,
  );

}

  