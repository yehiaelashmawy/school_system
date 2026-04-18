import 'package:dio/dio.dart';
import 'package:school_system/core/api/api_exceptions.dart';
import 'package:school_system/core/api/api_service.dart';
import 'package:school_system/core/widgets/notifications/notification_model.dart';

class NotificationsRepo {
  Future<List<NotificationModel>> fetchNotificationsSummary() async {
    try {
      final response = await ApiService().get('/api/Notifications/summary');

      if (response['success'] == true && response['data'] != null) {
        final data = response['data']['recentNotifications'] as List;
        return data.map((e) => NotificationModel.fromJson(e)).toList();
      } else {
        String errMsg = 'Failed to fetch notifications';
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

  Future<String> deleteNotification(String oid) async {
    try {
      final response = await ApiService().delete('/api/Notifications/$oid');

      if (response['success'] == true) {
        String successMsg = 'Notification deleted successfully';
        if (response is Map && response['messages'] is Map) {
          final msgs = response['messages'] as Map;
          if (msgs['EN'] != null) {
            successMsg = msgs['EN'].toString();
          }
        }
        return successMsg;
      } else {
        String errMsg = 'Failed to delete notification';
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
