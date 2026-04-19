import 'package:dartz/dartz.dart';
import 'package:school_system/core/api/api_errors.dart';
import 'package:school_system/core/api/api_service.dart';
import 'package:school_system/features/teacher/data/models/teacher_timetable_entry_model.dart';

class TeacherTimetableRepo {
  final ApiService apiService;

  TeacherTimetableRepo(this.apiService);

  Future<Either<ApiErrors, List<TeacherTimetableEntryModel>>>
  getTodayClassesForTeacher(String teacherOid) async {
    try {
      if (teacherOid.trim().isEmpty) {
        return Left(
          ApiErrors(
            errorMessage: 'Teacher id is missing. Please login again.',
          ),
        );
      }

      final response = await apiService.get('/api/Timetable/teacher/$teacherOid');
      final data = response['data'] as Map<String, dynamic>? ?? {};
      final weeklySchedule = data['weeklySchedule'] as Map<String, dynamic>? ?? {};

      final todayKey = _weekdayKey(DateTime.now().weekday);
      final todayRaw = weeklySchedule[todayKey] as List<dynamic>? ?? [];

      final classes = todayRaw
          .map((item) => TeacherTimetableEntryModel.fromJson(item as Map<String, dynamic>))
          .toList();

      return Right(classes);
    } catch (e) {
      if (e is ApiErrors) {
        return Left(e);
      }
      return Left(ApiErrors(errorMessage: e.toString()));
    }
  }

  String _weekdayKey(int weekday) {
    switch (weekday) {
      case DateTime.monday:
        return 'Monday';
      case DateTime.tuesday:
        return 'Tuesday';
      case DateTime.wednesday:
        return 'Wednesday';
      case DateTime.thursday:
        return 'Thursday';
      case DateTime.friday:
        return 'Friday';
      case DateTime.saturday:
        return 'Saturday';
      case DateTime.sunday:
        return 'Sunday';
      default:
        return 'Sunday';
    }
  }
}
