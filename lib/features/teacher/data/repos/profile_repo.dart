import 'package:dio/dio.dart';
import '../../../../core/api/api_exceptions.dart';
import '../../../../core/api/api_service.dart';
import '../models/profile_model.dart';

class ProfileRepo {
  Future<ProfileModel> getProfile() async {
    try {
      final response = await ApiService().get(
        '/api/Profile',
      );

      if (response['success'] == true && response['data'] != null) {
        return ProfileModel.fromJson(response['data']);
      } else {
        String errMsg = 'Failed to fetch profile';
        if (response is Map) {
          final errors = response['errors'];
          if (errors is List && errors.isNotEmpty) {
            errMsg = errors.first.toString();
          } else if (response['messages'] is Map) {
            final msgs = response['messages'] as Map;
            if (msgs['EN'] != null) {
              errMsg = msgs['EN'].toString();
            } else if (msgs['error'] != null) {
              errMsg = msgs['error'].toString();
            } else if (msgs.isNotEmpty) {
              errMsg = msgs.values.first.toString();
            }
          }
        }
        throw Exception(errMsg);
      }
    } on DioException catch (e) {
      throw ApiExceptions.handleException(e);
    } catch (e) {
      rethrow;
    }
  }

  Future<String> updateProfile({
    required String fullName,
    required String phone,
    required String department,
    required String position,
    String? avatar,
  }) async {
    try {
      final response = await ApiService().put(
        '/api/Profile',
        data: {
          "profileData": {
            "fullName": fullName,
            "phone": phone,
            "department": department,
            "position": position,
            "avatar": avatar ?? "",
          }
        },
      );

      if (response['success'] == true) {
        String successMsg = 'Profile updated successfully';
        if (response is Map) {
          if (response['messages'] is Map) {
            final msgs = response['messages'] as Map;
            if (msgs['EN'] != null) {
              successMsg = msgs['EN'].toString();
            }
          }
        }
        return successMsg;
      } else {
        String errMsg = 'Failed to update profile';
        if (response is Map) {
          final errors = response['errors'];
          if (errors is List && errors.isNotEmpty) {
            errMsg = errors.first.toString();
          } else if (response['messages'] is Map) {
            final msgs = response['messages'] as Map;
            if (msgs['EN'] != null) {
              errMsg = msgs['EN'].toString();
            } else if (msgs['error'] != null) {
              errMsg = msgs['error'].toString();
            } else if (msgs.isNotEmpty) {
              errMsg = msgs.values.first.toString();
            }
          }
        }
        throw Exception(errMsg);
      }
    } on DioException catch (e) {
      throw ApiExceptions.handleException(e);
    } catch (e) {
      rethrow;
    }
  }
}
