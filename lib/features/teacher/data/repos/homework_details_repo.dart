import 'package:dartz/dartz.dart';
import 'package:school_system/core/api/api_errors.dart';
import 'package:school_system/core/api/api_service.dart';
import 'package:school_system/features/teacher/data/models/teacher_class_model.dart';

class HomeworkDetailsRepo {
  final ApiService apiService;

  HomeworkDetailsRepo(this.apiService);

  Future<Either<ApiErrors, TeacherHomeworkModel>> getHomeworkDetails(
    String homeworkId,
  ) async {
    try {
      final response = await apiService.get('/api/Homeworks/$homeworkId');

      if (response != null && response['success'] == true) {
        final data = response['data'] as Map<String, dynamic>;
        return Right(TeacherHomeworkModel.fromJson(data));
      }

      return Left(ApiErrors(errorMessage: 'Failed to fetch homework details'));
    } catch (e) {
      if (e is ApiErrors) return Left(e);
      return Left(ApiErrors(errorMessage: e.toString()));
    }
  }

  Future<Either<ApiErrors, String>> deleteHomework(String homeworkId) async {
    try {
      final response = await apiService.delete('/api/Homeworks/$homeworkId');

      if (response != null && response['success'] == true) {
        final msg = response['messages']?['EN']?.toString() ??
            'Homework deleted successfully';
        return Right(msg);
      }

      return Left(ApiErrors(errorMessage: 'Failed to delete homework'));
    } catch (e) {
      if (e is ApiErrors) return Left(e);
      return Left(ApiErrors(errorMessage: e.toString()));
    }
  }
}
