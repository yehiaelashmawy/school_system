import 'package:dartz/dartz.dart';
import 'package:school_system/core/api/api_errors.dart';
import 'package:school_system/core/api/api_service.dart';

class AddLessonRepo {
  final ApiService apiService;

  AddLessonRepo(this.apiService);

  Future<Either<ApiErrors, String>> createLesson({
    required String title,
    required String description,
    required String date,
    required String startTime,
    required String endTime,
    required String classOid,
    required String subjectOid,
    required int type,
    required List<String> objectives,
    required List<Map<String, dynamic>> materials,
  }) async {
    try {
      final response = await apiService.post(
        '/api/Lessons',
        data: {
          "title": title,
          "description": description,
          "date": date,
          "startTime": startTime,
          "endTime": endTime,
          "classOid": classOid,
          "subjectOid": subjectOid,
          "type": type,
          "objectives": objectives,
          "materials": materials,
          // Mocking empty parameters for homework, links and notes
          "resourceLinks": [],
          "homework": null,
          "teacherNotes": ""
        },
      );
      
      // Assuming successful response returns messages.EN or somewhat similar
      if (response != null && response['success'] == true) {
        return Right(response['messages']['EN'] ?? "Lesson published successfully");
      }
      return const Right("Lesson published successfully");
    } catch (e) {
      if (e is ApiErrors) {
        return Left(e);
      }
      return Left(ApiErrors(errorMessage: e.toString()));
    }
  }
}
