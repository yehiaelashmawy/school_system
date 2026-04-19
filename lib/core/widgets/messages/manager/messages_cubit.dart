import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_system/core/widgets/messages/data/messages_repo.dart';
import 'messages_state.dart';

class MessagesCubit extends Cubit<MessagesState> {
  final MessagesRepo messagesRepo;
  final Set<String> _locallyReadConversationOids = {};

  MessagesCubit(this.messagesRepo) : super(MessagesInitial());

  Future<void> fetchMessagesConversations() async {
    emit(MessagesLoading());
    try {
      final messages = await messagesRepo.fetchMessagesConversations();
      final mergedMessages = messages.map((message) {
        if (_locallyReadConversationOids.contains(message.senderOid)) {
          return message.copyWith(unreadCount: 0);
        }
        return message;
      }).toList();
      emit(MessagesSuccess(messages: mergedMessages));
    } catch (e) {
      String errMessage = e.toString();
      if (errMessage.startsWith('Exception: ')) {
        errMessage = errMessage.replaceFirst('Exception: ', '');
      }
      emit(MessagesFailure(errMessage: errMessage));
    }
  }

  void markConversationAsRead(String conversationUserOid) {
    if (conversationUserOid.isEmpty) return;
    _locallyReadConversationOids.add(conversationUserOid);

    final current = state;
    if (current is! MessagesSuccess) return;

    final updated = current.messages.map((message) {
      if (message.senderOid == conversationUserOid) {
        return message.copyWith(unreadCount: 0);
      }
      return message;
    }).toList();

    emit(MessagesSuccess(messages: updated));
  }
}
