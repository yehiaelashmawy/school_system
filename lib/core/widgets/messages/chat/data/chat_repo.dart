import 'package:dio/dio.dart';
import 'package:school_system/core/api/api_exceptions.dart';
import 'package:school_system/core/api/api_service.dart';
import 'package:school_system/core/widgets/messages/message_model.dart';

class ChatRepo {
  Future<List<MessageModel>> fetchThread({
    required String currentUserOid,
    required String otherUserOid,
  }) async {
    try {
      final inboxResponse = await ApiService().get('/api/Messages/inbox');
      final sentResponse = await ApiService().get('/api/Messages/sent');

      final inboxData = (inboxResponse['data'] as List<dynamic>? ?? [])
          .map((e) => MessageModel.fromJson(e as Map<String, dynamic>))
          .toList();
      final sentData = (sentResponse['data'] as List<dynamic>? ?? [])
          .map((e) => MessageModel.fromJson(e as Map<String, dynamic>))
          .toList();

      final all = [...inboxData, ...sentData];
      final thread = all.where((message) {
        final isCurrentToOther =
            message.senderOid == currentUserOid &&
            message.receiverOid == otherUserOid;
        final isOtherToCurrent =
            message.senderOid == otherUserOid &&
            message.receiverOid == currentUserOid;
        return isCurrentToOther || isOtherToCurrent;
      }).toList();

      thread.sort((a, b) {
        final aTime = a.sentAt ?? DateTime.fromMillisecondsSinceEpoch(0);
        final bTime = b.sentAt ?? DateTime.fromMillisecondsSinceEpoch(0);
        return aTime.compareTo(bTime);
      });

      return thread;
    } on DioException catch (e) {
      throw ApiExceptions.handleException(e);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> sendMessage({
    required String receiverOid,
    required String subject,
    required String content,
  }) async {
    try {
      await ApiService().post(
        '/api/Messages',
        data: {
          'subject': subject,
          'content': content,
          'receiverOid': receiverOid,
          'isGroupMessage': false,
          'targetRole': null,
          'parentMessageOid': null,
        },
      );
    } on DioException catch (e) {
      throw ApiExceptions.handleException(e);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteMessage(String oid) async {
    try {
      await ApiService().delete('/api/Messages/$oid');
    } on DioException catch (e) {
      throw ApiExceptions.handleException(e);
    } catch (e) {
      rethrow;
    }
  }
}
