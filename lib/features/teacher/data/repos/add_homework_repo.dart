import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
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
        final dataField = response['data'];
        String? homeworkId;

        if (dataField is String) {
          homeworkId = dataField;
        } else if (dataField is Map<String, dynamic>) {
          homeworkId =
              dataField['oid']?.toString() ?? dataField['id']?.toString();
        } else if (dataField is List &&
            dataField.isNotEmpty &&
            dataField.first is Map) {
          final first = dataField.first as Map<String, dynamic>;
          homeworkId = first['oid']?.toString() ?? first['id']?.toString();
        }

        if (homeworkId != null && homeworkId.isNotEmpty) {
          return Right(homeworkId);
        }

        return Left(
          ApiErrors(errorMessage: 'Homework created but no ID returned'),
        );
      }

      return Left(ApiErrors(errorMessage: "Failed to create homework."));
    } catch (e) {
      if (e is ApiErrors) {
        return Left(e);
      }
      return Left(ApiErrors(errorMessage: e.toString()));
    }
  }

  Future<Either<ApiErrors, void>> _uploadSingleFile({
    required String homeworkId,
    required PlatformFile file,
  }) async {
    final endpoint = '/api/Files/upload/homeworks/$homeworkId';

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

  Future<Either<ApiErrors, void>> _uploadMultipleFiles({
    required String homeworkId,
    required List<PlatformFile> files,
  }) async {
    final endpoint = '/api/Files/upload-multiple/homeworks/$homeworkId';

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

  Future<Either<ApiErrors, void>> uploadHomeworkFiles({
    required String homeworkId,
    required List<PlatformFile> files,
  }) async {
    if (files.isEmpty) return const Right(null);

    if (files.length == 1) {
      return _uploadSingleFile(homeworkId: homeworkId, file: files.first);
    }

    return _uploadMultipleFiles(homeworkId: homeworkId, files: files);
  }
}
