import 'package:dio/dio.dart';
import 'package:school_system/core/api/api_exceptions.dart';
import 'package:school_system/core/api/dio_client.dart';

class ApiService {
  final DioClient _dioClient = DioClient();

  //get
  Future<dynamic> get(String endPoint) async {
    try {
      final response = await _dioClient.dio.get(endPoint);
      return response.data;
    } catch (e) {
      throw ApiExceptions.handleException(e as DioException);
    }
  }

  //post
  Future<dynamic> post(String endPoint, {dynamic data}) async {
    try {
      final response = await _dioClient.dio.post(endPoint, data: data);
      return response.data;
    } catch (e) {
      throw ApiExceptions.handleException(e as DioException);
    }
  }

  //put
  Future<dynamic> put(String endPoint, {dynamic data}) async {
    try {
      final response = await _dioClient.dio.put(endPoint, data: data);
      return response.data;
    } catch (e) {
      throw ApiExceptions.handleException(e as DioException);
    }
  }

  //delete
  Future<dynamic> delete(String endPoint) async {
    try {
      final response = await _dioClient.dio.delete(endPoint);
      return response.data;
    } catch (e) {
      throw ApiExceptions.handleException(e as DioException);
    }
  }
}
