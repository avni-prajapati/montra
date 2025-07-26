import 'package:dio/dio.dart';

class ApiClient {
  static final ApiClient instance = ApiClient.internal();
  factory ApiClient() => instance;
  ApiClient.internal();

  Future<dynamic> callApi(String link) async {
    final response = await Dio().get(link);
    if (response.statusCode == 200) {
      return response.data;
    }
  }
}
