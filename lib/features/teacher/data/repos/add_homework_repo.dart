import 'package:dartz/dartz.dart';
import 'package:school_system/core/api/api_errors.dart';
import 'package:school_system/core/api/api_service.dart';

class AddHomeworkRepo {
  final ApiService apiService;

  AddHomeworkRepo(this.apiService);

  Future<Either<ApiErrors, String>> createHomework({
    required String title,
    required String description,
    required String instructions,
    required String dueDate,
    required int totalMarks,
    required String classId,
    required String subjectId,
    required String submissionType,
    required bool allowLateSubmissions,
    required bool notifyParents,
    List<Map<String, dynamic>> attachments = const [],
  }) async {
    try {
      final response = await apiService.post(
        '/api/Homeworks',
        data: {
          "title": title,
          "description": description,
          "instructions": instructions,
          "dueDate": dueDate,
          "totalMarks": totalMarks,
          "submissionType": submissionType,
          "allowLateSubmissions": allowLateSubmissions,
          "notifyParents": notifyParents,
          "classId": classId,
          "subjectId": subjectId,
          "attachments": attachments,
        },
      );

      // The API response depends on the design, for example if it returns success boolean
      if (response['success'] == true) {
        return Right("Homework created successfully.");
      } else {
        return Left(ApiErrors(errorMessage: "Failed to create homework."));
      }
    } catch (e) {
      if (e is ApiErrors) {
        return Left(e);
      }
      return Left(ApiErrors(errorMessage: e.toString()));
    }
  }
}
