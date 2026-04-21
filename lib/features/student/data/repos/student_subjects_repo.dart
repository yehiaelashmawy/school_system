import 'package:dartz/dartz.dart';
import 'package:school_system/core/api/api_errors.dart';
import 'package:school_system/core/api/api_service.dart';
import 'package:school_system/features/student/data/models/student_subject_model.dart';

class StudentSubjectsRepo {
  final ApiService apiService;

  StudentSubjectsRepo(this.apiService);

  Future<Either<ApiErrors, List<StudentSubjectModel>>> getStudentSubjects() async {
    try {
      final response = await apiService.get('/api/Subjects');
      final data = response is Map<String, dynamic> ? response['data'] : null;
      final subjects = data is List
          ? data
                .whereType<Map>()
                .map(
                  (item) =>
                      StudentSubjectModel.fromApiJson(item.cast<String, dynamic>()),
                )
                .toList()
          : <StudentSubjectModel>[];

      return Right(subjects);
    } catch (e) {
      if (e is ApiErrors) return Left(e);
      return Left(ApiErrors(errorMessage: e.toString()));
    }
  }
}
