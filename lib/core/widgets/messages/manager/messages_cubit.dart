import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_system/core/widgets/messages/data/messages_repo.dart';
import 'messages_state.dart';

class MessagesCubit extends Cubit<MessagesState> {
  final MessagesRepo messagesRepo;

  MessagesCubit(this.messagesRepo) : super(MessagesInitial());

  Future<void> fetchMessagesConversations() async {
    emit(MessagesLoading());
    try {
      final messages = await messagesRepo.fetchMessagesConversations();
      emit(MessagesSuccess(messages: messages));
    } catch (e) {
      String errMessage = e.toString();
      if (errMessage.startsWith('Exception: ')) {
        errMessage = errMessage.replaceFirst('Exception: ', '');
      }
      emit(MessagesFailure(errMessage: errMessage));
    }
  }
}
