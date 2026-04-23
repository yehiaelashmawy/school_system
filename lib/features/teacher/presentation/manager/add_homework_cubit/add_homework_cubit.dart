import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_system/features/teacher/data/repos/add_homework_repo.dart';
import 'add_homework_state.dart';

class AddHomeworkCubit extends Cubit<AddHomeworkState> {
  final AddHomeworkRepo _addHomeworkRepo;

  AddHomeworkCubit(this._addHomeworkRepo) : super(AddHomeworkInitial());

  Future<void> createHomework({
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
    List<PlatformFile> attachedFiles = const [],
    List<Map<String, dynamic>> attachments = const [],
  }) async {
    emit(AddHomeworkLoading());
    final result = await _addHomeworkRepo.createHomework(
      title: title,
      description: description,
      instructions: instructions,
      dueDate: DateTime.parse(dueDate),
      totalMarks: totalMarks,
      classId: classId,
      subjectId: subjectId,
      submissionType: submissionType,
      allowLateSubmissions: allowLateSubmissions,
      notifyParents: notifyParents,
      attachments: attachments,
    );

    await result.fold(
      (error) async => emit(AddHomeworkFailure(error.errorMessage)),
      (homeworkId) async {
        if (attachedFiles.isNotEmpty) {
          final uploadResult = await _addHomeworkRepo.uploadHomeworkFiles(
            homeworkId: homeworkId,
            files: attachedFiles,
          );

          if (uploadResult.isLeft()) {
            final error = uploadResult.fold((l) => l.errorMessage, (_) => '');
            emit(AddHomeworkFailure('File upload failed: $error'));
            return;
          }
        }

        emit(AddHomeworkSuccess('Homework created successfully.'));
      },
    );
  }
}
