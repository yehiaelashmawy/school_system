import 'package:dartz/dartz.dart';
import 'package:school_system/core/api/api_errors.dart';
import 'package:school_system/core/api/api_service.dart';
import 'package:school_system/features/student/data/models/student_weekly_schedule_model.dart';

class StudentWeeklyScheduleRepo {
  final ApiService _apiService;

  StudentWeeklyScheduleRepo(this._apiService);

  Future<Either<ApiErrors, StudentWeeklyScheduleData>> fetchWeeklySchedule() async {
    try {
      final response = await _apiService.get('/api/student/timetable/weekly');
      final data = StudentWeeklyScheduleData.fromJson(response['data']);
      return Right(data);
    } catch (e) {
      if (e is ApiErrors) return Left(e);
      return Left(ApiErrors(errorMessage: e.toString()));
    }
  }
}
