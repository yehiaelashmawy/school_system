import 'package:dartz/dartz.dart';
import 'package:school_system/core/api/api_errors.dart';
import 'package:school_system/core/api/api_service.dart';
import 'package:school_system/features/student/data/models/student_lesson_detail_model.dart';

class StudentLessonsRepo {
  final ApiService apiService;

  StudentLessonsRepo(this.apiService);

  Future<Either<ApiErrors, StudentLessonDetailModel>> fetchLessonDetails(
    String lessonId,
  ) async {
    try {
      final response = await apiService.get('/api/student/lessons');

      if (response['success'] == true) {
        final data = response['data'];
        if (data is List) {
          final lessonData = data.firstWhere(
            (element) => element['oid'] == lessonId,
            orElse: () => null,
          );
          if (lessonData != null) {
            return Right(StudentLessonDetailModel.fromJson(lessonData));
          } else {
            return Left(ApiErrors(errorMessage: 'Lesson not found.'));
          }
        } else if (data is Map<String, dynamic>) {
          return Right(StudentLessonDetailModel.fromJson(data));
        } else {
          return Left(ApiErrors(errorMessage: 'Unexpected data format.'));
        }
      } else {
        return Left(ApiErrors(errorMessage: 'Failed to fetch lesson details.'));
      }
    } catch (e) {
      if (e is ApiErrors) {
        return Left(e);
      }
      return Left(ApiErrors(errorMessage: e.toString()));
    }
  }
}
