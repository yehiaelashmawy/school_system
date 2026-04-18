import 'package:dartz/dartz.dart';
import 'package:school_system/core/api/api_errors.dart';
import 'package:school_system/core/api/api_service.dart';
import 'package:school_system/features/teacher/data/models/teacher_exam_model.dart';

class TeacherExamsRepo {
  final ApiService apiService;

  TeacherExamsRepo(this.apiService);

  Future<Either<ApiErrors, List<TeacherExamModel>>> getTeacherExams() async {
    try {
      final response = await apiService.get('/api/Exams/teacher');
      final data = response['data'] as List;
      final exams = data.map((e) => TeacherExamModel.fromJson(e)).toList();
      return Right(exams);
    } catch (e) {
      if (e is ApiErrors) {
        return Left(e);
      }
      return Left(ApiErrors(errorMessage: e.toString()));
    }
  }
}
