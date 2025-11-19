import 'dart:convert';

List<ApiError> apiErrorFromJson(String str) => List<ApiError>.from(json.decode(str).map((x) => ApiError.fromJson(x)));

String apiErrorToJson(List<ApiError> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ApiError {
    final bool status;
    final String message;

    ApiError({
        required this.status,
        required this.message,
    });

    factory ApiError.fromJson(Map<String, dynamic> json) => ApiError(
        status: json["status"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
    };
}
