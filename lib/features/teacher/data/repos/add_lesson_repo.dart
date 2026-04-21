import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:school_system/core/api/api_errors.dart';
import 'package:school_system/core/api/api_service.dart';

class AddLessonRepo {
  final ApiService apiService;

  AddLessonRepo(this.apiService);

  /// Creates a lesson and returns the new lesson OID on success.
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
          "materials": [],
          "resourceLinks": [],
          "homework": null,
          "teacherNotes": "",
        },
      );

      if (response != null && response['success'] == true) {
        final dataField = response['data'];
        String? lessonOid;

        // 🔥 FIX: دعم كل أشكال الـ API
        if (dataField is String) {
          lessonOid = dataField;
        } else if (dataField is Map<String, dynamic>) {
          lessonOid =
              dataField['oid']?.toString() ?? dataField['id']?.toString();
        } else if (dataField is List &&
            dataField.isNotEmpty &&
            dataField.first is Map) {
          final first = dataField.first as Map<String, dynamic>;
          lessonOid = first['oid']?.toString() ?? first['id']?.toString();
        }

        if (lessonOid != null && lessonOid.isNotEmpty) {
          return Right(lessonOid);
        }

        // ❌ بدل ما نكمل بغلط
        return Left(
          ApiErrors(errorMessage: 'Lesson created but no ID returned'),
        );
      }

      return Left(ApiErrors(errorMessage: 'Failed to create lesson'));
    } catch (e) {
      if (e is ApiErrors) return Left(e);
      return Left(ApiErrors(errorMessage: e.toString()));
    }
  }

  /// Uploads one file → POST /api/Files/upload/lessons/{lessonId}
  Future<Either<ApiErrors, void>> _uploadSingleFile({
    required String lessonId,
    required PlatformFile file,
  }) async {
    final endpoint = '/api/Files/upload/lessons/$lessonId';

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

  /// Uploads multiple files in one request
  Future<Either<ApiErrors, void>> _uploadMultipleFiles({
    required String lessonId,
    required List<PlatformFile> files,
  }) async {
    final endpoint = '/api/Files/upload-multiple/lessons/$lessonId';

    try {
      final multipartFiles = <MapEntry<String, MultipartFile>>[];

      for (final file in files) {
        if (file.path != null && File(file.path!).existsSync()) {
          multipartFiles.add(
            MapEntry(
              'Files', // 🔥 FIX هنا
              await MultipartFile.fromFile(file.path!, filename: file.name),
            ),
          );
        } else if (file.bytes != null) {
          multipartFiles.add(
            MapEntry(
              'Files', // 🔥 FIX هنا
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
  Future<Either<ApiErrors, void>> uploadLessonFiles({
    required String lessonId,
    required List<PlatformFile> files,
  }) async {
    if (files.isEmpty) return const Right(null);

    if (files.length == 1) {
      return _uploadSingleFile(lessonId: lessonId, file: files.first);
    }

    return _uploadMultipleFiles(lessonId: lessonId, files: files);
  }
}
