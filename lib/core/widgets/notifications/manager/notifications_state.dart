import 'package:flutter/foundation.dart';
import 'package:school_system/core/widgets/notifications/notification_model.dart';

@immutable
abstract class NotificationsState {}

class NotificationsInitial extends NotificationsState {}

class NotificationsLoading extends NotificationsState {}

class NotificationsSuccess extends NotificationsState {
  final List<NotificationModel> notifications;

  NotificationsSuccess(this.notifications);
}

class NotificationsFailure extends NotificationsState {
  final String errMessage;

  NotificationsFailure(this.errMessage);
}
