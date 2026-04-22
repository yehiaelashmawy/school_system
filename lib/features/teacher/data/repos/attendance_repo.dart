import 'package:dartz/dartz.dart';
import 'package:school_system/core/api/api_errors.dart';
import 'package:school_system/core/api/api_service.dart';
import 'package:school_system/features/teacher/data/models/attendance_session_model.dart';

class AttendanceRepo {
  final ApiService _apiService;

  AttendanceRepo(this._apiService);

  Future<Either<ApiErrors, AttendanceSessionModel>> startSession({
    required String classOid,
    required int method,
    String? lessonOid,
  }) async {
    try {
      final response = await _apiService.post(
        '/api/Attendance/start-session',
        data: {
          'classOid': classOid,
          'method': method,
          if (lessonOid != null) 'lessonOid': lessonOid,
        },
      );

      if (response['success'] == true) {
        final data = response['data'];
        if (data == null) {
          return Left(ApiErrors(errorMessage: 'No data returned from server'));
        }
        return Right(AttendanceSessionModel.fromJson(
          (data as Map).cast<String, dynamic>(),
        ));
      } else {
        return Left(ApiErrors(
          errorMessage:
              response['messages']?['Error'] ?? 'Failed to start session',
        ));
      }
    } catch (e) {
      if (e is ApiErrors) return Left(e);
      return Left(ApiErrors(errorMessage: e.toString()));
    }
  }
}
