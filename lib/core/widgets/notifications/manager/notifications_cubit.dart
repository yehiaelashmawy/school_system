import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_system/core/widgets/notifications/data/notifications_repo.dart';
import 'package:school_system/core/widgets/notifications/manager/notifications_state.dart';

class NotificationsCubit extends Cubit<NotificationsState> {
  final NotificationsRepo notificationsRepo;

  NotificationsCubit(this.notificationsRepo) : super(NotificationsInitial());

  Future<void> fetchNotifications() async {
    emit(NotificationsLoading());
    try {
      final notifications = await notificationsRepo.fetchNotificationsSummary();
      emit(NotificationsSuccess(notifications));
    } catch (e) {
      String errorMsg = e.toString();
      if (errorMsg.startsWith('Exception: ')) {
        errorMsg = errorMsg.substring('Exception: '.length);
      }
      emit(NotificationsFailure(errorMsg));
    }
  }
}
