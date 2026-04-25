import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:school_system/core/api/api_errors.dart';
import 'package:school_system/core/api/api_service.dart';
import 'package:school_system/features/teacher/data/models/teacher_exam_model.dart';
import 'package:school_system/features/teacher/data/models/add_exam_request.dart';

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

  Future<Either<ApiErrors, String>> addExam(AddExamRequest request) async {
    try {
      final response = await apiService.post(
        '/api/Exams',
        data: request.toJson(),
      );
      return Right(response['data'] as String);
    } catch (e) {
      if (e is ApiErrors) {
        return Left(e);
      }
      return Left(ApiErrors(errorMessage: e.toString()));
    }
  }

  /// Upload one file
  Future<Either<ApiErrors, void>> _uploadSingleFile({
    required String examId,
    required PlatformFile file,
  }) async {
    final endpoint = '/api/Files/upload/exam/$examId';

    try {
      dynamic response;

      if (file.path != null && File(file.path!).existsSync()) {
        response = await apiService.postMultipart(
          endpoint,
          filePath: file.path!,
          fileName: file.name,
        );
      } else if (file.bytes != null) {
        response = await apiService.postMultipartBytes(
          endpoint,
          bytes: file.bytes!,
          fileName: file.name,
        );
      } else {
        return Left(ApiErrors(errorMessage: 'Cannot read file: ${file.name}'));
      }

      if (response != null && response['success'] == true) {
        return const Right(null);
      }

      return Left(ApiErrors(errorMessage: 'Upload failed for: ${file.name}'));
    } catch (e) {
      if (e is ApiErrors) return Left(e);
      return Left(ApiErrors(errorMessage: e.toString()));
    }
  }

  /// Upload multiple files
  Future<Either<ApiErrors, void>> _uploadMultipleFiles({
    required String examId,
    required List<PlatformFile> files,
  }) async {
    final endpoint = '/api/Files/upload/exam/$examId';

    try {
      final multipartFiles = <MapEntry<String, MultipartFile>>[];

      for (final file in files) {
        if (file.path != null && File(file.path!).existsSync()) {
          multipartFiles.add(
            MapEntry(
              'Files',
              await MultipartFile.fromFile(file.path!, filename: file.name),
            ),
          );
        } else if (file.bytes != null) {
          multipartFiles.add(
            MapEntry(
              'Files',
              MultipartFile.fromBytes(file.bytes!, filename: file.name),
            ),
          );
        } else {
          return Left(
            ApiErrors(errorMessage: 'Cannot read file: ${file.name}'),
          );
        }
      }

      final response = await apiService.postMultipartMultiple(
        endpoint,
        files: multipartFiles,
      );

      if (response != null && response['success'] == true) {
        return const Right(null);
      }

      return Left(
        ApiErrors(errorMessage: 'Upload failed for one or more files'),
      );
    } catch (e) {
      if (e is ApiErrors) return Left(e);
      return Left(ApiErrors(errorMessage: e.toString()));
    }
  }

  /// Upload router
  Future<Either<ApiErrors, void>> uploadExamFiles({
    required String examId,
    required List<PlatformFile> files,
  }) async {
    if (files.isEmpty) return const Right(null);

    if (files.length == 1) {
      return _uploadSingleFile(examId: examId, file: files.first);
    }

    return _uploadMultipleFiles(examId: examId, files: files);
  }
}

