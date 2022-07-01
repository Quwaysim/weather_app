import 'package:dio/dio.dart';

class ApiUtils {
  static ApiResponse toApiResponse(Response res) {
    return ApiResponse(
      statusCode: res.statusCode,
      statusMessage: res.statusMessage,
      data: res.data,
    );
  }
}

class ApiResponse {
  final int? statusCode;
  final String? statusMessage;
  final dynamic data;

  ApiResponse({this.statusCode, this.statusMessage, this.data});

  @override
  String toString() {
    return '$data';
  }
}
