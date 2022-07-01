import 'dart:io';

import 'package:dio/dio.dart';
import 'package:weather_app/app/app.logger.dart';
import 'package:weather_app/utils/api_response_util.dart';
import 'package:weather_app/utils/apikey.dart';
import 'package:weather_app/utils/constants.dart';
import 'package:weather_app/utils/dio_interceptors.dart';

class ApiService {
  final log = getLogger('ApiService');
  final dio = Dio();

  ApiService() {
    dio.interceptors.add(DioInterceptor());
    dio.options.sendTimeout = 30000;
    dio.options.receiveTimeout = 30000;
    dio.options.baseUrl = apiUrl;
    log.i('API constructed and DIO setup registered');
  }

  Future<dynamic> get(
    String string, {
    Map<String, dynamic>? queryParameters,
    String? token,
  }) async {
    log.i('Making request to $string');
    log.d('With payload $queryParameters');
    try {
      final response = await dio.get(
        string,
        queryParameters: queryParameters,
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );

      log.i('Response from $string \n${response.data}');
      final parsedResponse = ApiUtils.toApiResponse(response);
      return parsedResponse;
    } on DioError catch (e) {
      log.wtf('From $string  - ${e.response?.data?.toString()}');
      return e.toString();
    } on SocketException catch (e) {
      log.wtf('From $string  - ${e.message.toString()}');
      throw 'No internet connection';
    }
  }

  Future<dynamic> getWeatherData(double lon, double lat) async {
    return await get(
      apiUrl,
      queryParameters: {
        'lat': lat,
        'lon': lon,
        'units': 'metric',
        'appid': apiKey,
      },
    );
  }
}
