import 'package:flutter/foundation.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:foodly_app/constants/constants.dart';
import 'package:foodly_app/models/apiError.dart';
import 'package:foodly_app/models/foods.dart';
import 'package:foodly_app/models/hook_models/hook_result.dart';
import 'package:http/http.dart' as http;

FetchHook useFetchFoods(String code) {

  final foodsItem = useState<List<FoodsModel>?>(null);
  final isLoading = useState<bool>(false);
  final error = useState<Exception?>(null);
  final apiError = useState<ApiError?>(null);

  Future<void> fetchData() async {
    isLoading.value = true;

    try {
      print("fetchData called /api/foods/recommendation/$code");

      Uri url = Uri.parse('$appLocalBaseUrl/api/foods/recommendation/$code');
      print("URL!! = $url");

      final response = await http.get(url);
      print("RESPONSE!! = $response");
      print (response.body);

      if (response.statusCode == 200) {

        foodsItem.value = foodsModelFromJson(response.body);

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
      debugPrint(e.toString());
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
    data: foodsItem.value,
    isLoading: isLoading.value,
    error: error.value?.toString(),
    refetch: refetch,
  );

}

  