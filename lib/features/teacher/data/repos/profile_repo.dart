import 'package:dio/dio.dart';
import 'dart:io';
import '../../../../core/api/api_exceptions.dart';
import '../../../../core/api/api_service.dart';
import '../../../../core/utils/app_constants.dart';
import '../models/profile_model.dart';

class ProfileRepo {
  Future<String> _resolveAvatarForUpdate(String? avatar) async {
    if (avatar == null || avatar.trim().isEmpty) return '';

    // Already server path or absolute URL.
    if (avatar.startsWith('/uploads/') || avatar.startsWith('http')) {
      return avatar;
    }

    // Local file path -> upload first, then use returned avatarUrl.
    final file = File(avatar);
    if (!file.existsSync()) return '';

    final formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(
        avatar,
        filename: avatar.split(Platform.pathSeparator).last,
      ),
    });

    final uploadResponse = await ApiService().post(
      '/api/Profile/upload-avatar',
      data: formData,
    );

    if (uploadResponse['success'] == true && uploadResponse['data'] is Map) {
      final avatarUrl = (uploadResponse['data']['avatarUrl'] ?? '').toString();
      if (avatarUrl.isNotEmpty) return avatarUrl;
    }

    throw Exception('Failed to upload avatar');
  }

  Future<ProfileModel> getProfile() async {
    try {
      final response = await ApiService().get('/api/Profile');

      if (response['success'] == true && response['data'] != null) {
        final raw = Map<String, dynamic>.from(response['data'] as Map);
        final avatar = raw['avatar']?.toString() ?? '';
        if (avatar.isNotEmpty && !avatar.startsWith('http')) {
          raw['avatar'] = '${AppConstants.apiBaseUrl}$avatar';
        }
        return ProfileModel.fromJson(raw);
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
    required String email,
    required String phone,
    required String department,
    required String position,
    required String employeeId,
    String? avatar,
  }) async {
    try {
      final resolvedAvatar = await _resolveAvatarForUpdate(avatar);
      final response = await ApiService().put(
        '/api/Profile',
        data: {
          "profileData": {
            "fullName": fullName,
            "email": email,
            "phone": phone,
            "department": department,
            "position": position,
            "employeeId": employeeId,
            "avatar": resolvedAvatar,
          },
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

  Future<String> changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    try {
      final response = await ApiService().post(
        '/api/Profile/change-password',
        data: {
          "currentPassword": currentPassword,
          "newPassword": newPassword,
          "confirmPassword": confirmPassword,
        },
      );

      if (response['success'] == true) {
        String successMsg = 'Password changed successfully';
        if (response is Map && response['messages'] is Map) {
          final msgs = response['messages'] as Map;
          if (msgs['EN'] != null) {
            successMsg = msgs['EN'].toString();
          }
        }
        return successMsg;
      } else {
        String errMsg = 'Failed to change password';
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
