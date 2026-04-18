import 'package:school_system/core/api/api_errors.dart';
import 'package:school_system/features/teacher/data/models/announcement_model.dart';

abstract class AnnouncementsState {}

class AnnouncementsInitial extends AnnouncementsState {}

class AnnouncementsLoading extends AnnouncementsState {}

class AnnouncementsSuccess extends AnnouncementsState {
  final List<AnnouncementModel> announcements;

  AnnouncementsSuccess(this.announcements);
}

class AnnouncementsFailure extends AnnouncementsState {
  final ApiErrors error;

  AnnouncementsFailure(this.error);
}
