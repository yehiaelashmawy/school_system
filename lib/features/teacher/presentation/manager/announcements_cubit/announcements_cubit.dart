import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_system/features/teacher/data/repos/announcements_repo.dart';
import 'package:school_system/features/teacher/presentation/manager/announcements_cubit/announcements_state.dart';

class AnnouncementsCubit extends Cubit<AnnouncementsState> {
  final AnnouncementsRepo repo;

  AnnouncementsCubit(this.repo) : super(AnnouncementsInitial());

  Future<void> fetchHighPriorityAnnouncements({int take = 2}) async {
    emit(AnnouncementsLoading());
    final result = await repo.getHighPriorityAnnouncements(take: take);
    result.fold(
      (error) => emit(AnnouncementsFailure(error)),
      (announcements) => emit(AnnouncementsSuccess(announcements)),
    );
  }
}
