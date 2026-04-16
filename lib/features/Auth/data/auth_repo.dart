import 'package:dio/dio.dart';
import 'package:school_system/features/Auth/data/user_model.dart';

import '../../../core/api/api_exceptions.dart';
import '../../../core/api/api_service.dart';

class AuthRepo {
  //login
  Future<UserModel> login(String email, String password, int role) async {
    try {
      final response = await ApiService().post(
        '/api/Auth/login',
        data: {
          'email': email, 
          'password': password,
          'role': role,
        },
      );
      
      // Since ApiService().post returns response.data directly, it is already a decoded map.
      if (response['success'] == true && response['data'] != null) {
        return UserModel.fromJson(response['data']);
      } else {
        String errMsg = 'Invalid email or password';
        if (response.containsKey('errors') && response['errors'] != null) {
          final errorsData = response['errors'];
           if (errorsData is List && errorsData.isNotEmpty) {
               errMsg = errorsData.first.toString();
           } else if (errorsData is Map && errorsData.isNotEmpty) {
               final firstKey = errorsData.keys.first;
               final firstError = errorsData[firstKey];
               if (firstError is List && firstError.isNotEmpty) {
                   errMsg = firstError.first.toString();
               } else {
                   errMsg = firstError.toString();
               }
           }
        } else if (response.containsKey('messages') && response['messages'] is Map) {
          final msgs = response['messages'] as Map;
          if (msgs.containsKey('EN')) {
            errMsg = msgs['EN'].toString();
          } else if (msgs.containsKey('Error') && msgs['Error'] != "Message not found.") {
            errMsg = msgs['Error'].toString();
          } else if (msgs.isNotEmpty && msgs.values.first.toString() != "Message not found.") {
            errMsg = msgs.values.first.toString();
          }
        } else if (response.containsKey('message') && response['message'] != null) {
          errMsg = response['message'].toString();
        }
        throw Exception(errMsg);
      }
    } on DioException catch (e) {
      throw ApiExceptions.handleException(e);
    } catch (e) {
      throw e;
    }
  }
}
