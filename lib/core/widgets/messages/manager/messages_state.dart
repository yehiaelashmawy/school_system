import 'package:school_system/core/widgets/messages/message_model.dart';

abstract class MessagesState {}

class MessagesInitial extends MessagesState {}

class MessagesLoading extends MessagesState {}

class MessagesSuccess extends MessagesState {
  final List<MessageModel> messages;
  MessagesSuccess({required this.messages});
}

class MessagesFailure extends MessagesState {
  final String errMessage;
  MessagesFailure({required this.errMessage});
}
