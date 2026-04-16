import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:school_system/core/utils/app_constants.dart';
import 'package:school_system/core/helper/shared_prefs_helper.dart';

class DioClient {
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: AppConstants.apiBaseUrl,
      headers: {'Accept': '*/*', 'Content-Type': 'application/json'},
    ),
  );

  DioClient() {
    dio.httpClientAdapter = IOHttpClientAdapter(
      createHttpClient: () {
        final client = HttpClient();
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
        return client;
      },
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          // Add any request headers here
          final token = SharedPrefsHelper.token;
          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
      ),
    );
  }
  Dio getDio() {
    return dio;
  }
}
