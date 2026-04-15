import 'package:dio/dio.dart';
import 'package:school_system/core/api/api_errors.dart';

class ApiExceptions {
  static ApiErrors handleException(DioException e) {
    switch (e.type) {
      case DioExceptionType.cancel:
        return ApiErrors(errorMessage: 'Request cancelled');
      case DioExceptionType.connectionTimeout:
        return ApiErrors(errorMessage: 'Connection timeout');
      case DioExceptionType.receiveTimeout:
        return ApiErrors(errorMessage: 'Receive timeout');
      case DioExceptionType.sendTimeout:
        return ApiErrors(errorMessage: 'Send timeout');
      case DioExceptionType.badCertificate:
        return ApiErrors(errorMessage: 'Bad certificate');
      case DioExceptionType.badResponse:
        return ApiErrors(errorMessage: 'Bad response');
      case DioExceptionType.connectionError:
        return ApiErrors(errorMessage: 'Connection error');
      case DioExceptionType.unknown:
        return ApiErrors(errorMessage: 'Unknown error');

      // ignore: unreachable_switch_default
      default:
        return ApiErrors(errorMessage: 'Unknown error');
    }
  }
}
