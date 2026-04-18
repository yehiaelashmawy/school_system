import 'package:dartz/dartz.dart';
import 'package:school_system/core/api/api_errors.dart';
import 'package:school_system/core/api/api_service.dart';
import 'package:school_system/features/teacher/data/models/teacher_class_model.dart';

class TeacherClassesRepo {
  final ApiService apiService;

  TeacherClassesRepo(this.apiService);

  Future<Either<ApiErrors, List<TeacherClassModel>>> getTeacherClasses() async {
    try {
      final response = await apiService.get('/api/Classes/teacher');

      final data = response['data'] as List;
      final classes = data.map((e) => TeacherClassModel.fromJson(e)).toList();
      return Right(classes);
    } catch (e) {
      if (e is ApiErrors) {
        return Left(e);
      }
      return Left(ApiErrors(errorMessage: e.toString()));
    }
  }
}
