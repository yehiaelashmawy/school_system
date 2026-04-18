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
    List<Map<String, dynamic>> attachments = const [],
  }) async {
    emit(AddHomeworkLoading());
    final result = await _addHomeworkRepo.createHomework(
      title: title,
      description: description,
      instructions: instructions,
      dueDate: dueDate,
      totalMarks: totalMarks,
      classId: classId,
      subjectId: subjectId,
      submissionType: submissionType,
      allowLateSubmissions: allowLateSubmissions,
      notifyParents: notifyParents,
      attachments: attachments,
    );

    result.fold(
      (error) => emit(AddHomeworkFailure(error.errorMessage)),
      (successMessage) => emit(AddHomeworkSuccess(successMessage)),
    );
  }
}
