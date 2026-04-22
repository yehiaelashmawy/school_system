import 'package:dartz/dartz.dart';
import 'package:school_system/core/api/api_errors.dart';
import 'package:school_system/core/api/api_service.dart';
import 'package:school_system/features/student/data/models/student_grades_model.dart';

class StudentGradesRepo {
  final ApiService _apiService;

  StudentGradesRepo(this._apiService);

  Future<Either<ApiErrors, StudentGradesDataModel>> fetchGradesDashboard() async {
    try {
      final response = await _apiService.get('/api/student/grades/dashboard');
      final data = StudentGradesDataModel.fromJson(response['data']);
      return Right(data);
    } catch (e) {
      if (e is ApiErrors) return Left(e);
      return Left(ApiErrors(errorMessage: e.toString()));
    }
  }
}
