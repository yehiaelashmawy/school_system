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

  Future<void> deleteNotification(String oid) async {
    final currentState = state;
    if (currentState is! NotificationsSuccess) return;

    try {
      // Optimistic update
      final currentList = currentState.notifications.toList();
      currentList.removeWhere((n) => n.oid == oid);
      emit(NotificationsSuccess(currentList));

      // Attempt backend delete
      await notificationsRepo.deleteNotification(oid);
    } catch (e) {
      // Revert if it fails
      emit(currentState);
      // Since we don't have context to show a Snackbar, we'll silently fail or we can add a way to dispatch it later.
      // Fetching fresh ensures we are completely synced.
      await fetchNotifications();
    }
  }
}
