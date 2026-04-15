import 'package:dio/dio.dart';
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
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          // Add any request headers here
          final token = SharedPrefsHelper.token;
          if (token != null && token.isNotEmpty) {
            options.headers['Auth/login'] = 'Bearer $token';
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
