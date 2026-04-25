import 'package:dartz/dartz.dart';
import 'package:school_system/core/api/api_errors.dart';
import 'package:school_system/core/api/api_service.dart';
import 'package:school_system/features/teacher/data/models/announcement_model.dart';

class AnnouncementsRepo {
  final ApiService apiService;

  AnnouncementsRepo(this.apiService);

  Future<Either<ApiErrors, List<AnnouncementModel>>>
  getHighPriorityAnnouncements({int take = 1}) async {
    try {
      final response = await apiService.get(
        '/api/Announcements/priority/High?take=$take',
      );
      final data = response['data'] as List;
      final announcements = data
          .map((e) => AnnouncementModel.fromJson(e))
          .toList();
      return Right(announcements);
    } catch (e) {
      if (e is ApiErrors) {
        return Left(e);
      }
      return Left(ApiErrors(errorMessage: e.toString()));
    }
  }
}
