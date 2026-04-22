import 'package:dartz/dartz.dart';
import 'package:school_system/core/api/api_errors.dart';
import 'package:school_system/core/api/api_service.dart';
import 'package:school_system/features/student/data/models/student_homework_model.dart';

class StudentHomeworkRepo {
  final ApiService apiService;

  StudentHomeworkRepo(this.apiService);

  Future<Either<ApiErrors, StudentHomeworkDataModel>> fetchHomeworks() async {
    try {
      final response = await apiService.get('/api/student/homework');

      final data = StudentHomeworkDataModel.fromJson(response['data']);
      return Right(data);
    } catch (e) {
      if (e is ApiErrors) {
        return Left(e);
      }
      return Left(ApiErrors(errorMessage: e.toString()));
    }
  }
}
