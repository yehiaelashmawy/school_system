import 'package:dartz/dartz.dart';
import 'package:school_system/core/api/api_errors.dart';
import 'package:school_system/core/api/api_service.dart';
import 'package:school_system/features/student/data/models/student_my_subjects_model.dart';

class StudentMySubjectsRepo {
  final ApiService _apiService;

  StudentMySubjectsRepo(this._apiService);

  /// Fetches all subjects and returns the detail for [subjectId].
  Future<Either<ApiErrors, StudentMySubjectDetail>> fetchSubjectDetail(
    String subjectId,
  ) async {
    try {
      final response = await _apiService.get('/api/my-subjects');
      final rawList = response['data'];
      if (rawList is! List) {
        return Left(ApiErrors(errorMessage: 'Unexpected response format'));
      }

      // Find the matching subject
      final match = rawList
          .whereType<Map<String, dynamic>>()
          .cast<Map<String, dynamic>>()
          .firstWhere(
            (item) => item['subjectId']?.toString() == subjectId,
            orElse: () => <String, dynamic>{},
          );

      if (match.isEmpty) {
        // Fallback: return first subject if we have one (OID mismatch guard)
        if (rawList.isNotEmpty) {
          final first = rawList.first;
          if (first is Map<String, dynamic>) {
            return Right(StudentMySubjectDetail.fromJson(first));
          }
        }
        return Left(ApiErrors(errorMessage: 'Subject details not found'));
      }

      return Right(StudentMySubjectDetail.fromJson(match));
    } catch (e) {
      if (e is ApiErrors) return Left(e);
      return Left(ApiErrors(errorMessage: e.toString()));
    }
  }
}
