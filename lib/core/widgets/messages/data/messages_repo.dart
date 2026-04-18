import 'package:dio/dio.dart';
import 'package:school_system/core/api/api_exceptions.dart';
import 'package:school_system/core/api/api_service.dart';
import 'package:school_system/core/widgets/messages/message_model.dart';

class MessagesRepo {
  Future<List<MessageModel>> fetchMessagesConversations() async {
    try {
      final response = await ApiService().get('/api/Messages/conversations');

      if (response['success'] == true && response['data'] != null) {
        final data = response['data'] as List;
        return data.map((e) => MessageModel.fromJson(e)).toList();
      } else {
        String errMsg = 'Failed to fetch conversations';
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
