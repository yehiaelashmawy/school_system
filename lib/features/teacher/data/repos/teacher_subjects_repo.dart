import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:school_system/core/api/api_errors.dart';
import 'package:school_system/core/api/api_service.dart';
import 'package:school_system/features/teacher/data/models/teacher_subject_model.dart';
import 'package:school_system/core/helper/shared_prefs_helper.dart';

class TeacherSubjectsRepo {
  final ApiService apiService;

  TeacherSubjectsRepo(this.apiService);

  String? _getEmailFromToken(String? token) {
    if (token == null || token.isEmpty) return null;
    try {
      final parts = token.split('.');
      if (parts.length != 3) return null;
      String payload = parts[1];
      while (payload.length % 4 != 0) {
        payload += '=';
      }
      final decoded = utf8.decode(base64Url.decode(payload));
      final data = json.decode(decoded);
      return data['http://schemas.xmlsoap.org/ws/2005/05/identity/claims/emailaddress'];
    } catch (_) {
      return null;
    }
  }

  Future<Either<ApiErrors, List<TeacherSubjectModel>>> getTeacherSubjects() async {
    try {
      final response = await apiService.get('/api/Subjects');

      final data = response['data'] as List;
      
      List<TeacherSubjectModel> subjects = data.map((e) => TeacherSubjectModel.fromJson(e)).toList();

      final String? token = SharedPrefsHelper.token;
      final String? currentUserEmail = _getEmailFromToken(token);

      if (currentUserEmail != null && currentUserEmail.isNotEmpty) {
        subjects = subjects.where((subject) {
          return subject.teachers.any(
            (teacher) => teacher.email.toLowerCase() == currentUserEmail.toLowerCase(),
          );
        }).toList();
      }

      return Right(subjects);
    } catch (e) {
      if (e is ApiErrors) {
        return Left(e);
      }
      return Left(ApiErrors(errorMessage: e.toString()));
    }
  }
}
