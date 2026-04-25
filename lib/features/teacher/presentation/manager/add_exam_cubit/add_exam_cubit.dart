import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_system/features/teacher/data/models/add_exam_request.dart';
import 'package:school_system/features/teacher/data/repos/teacher_exams_repo.dart';
import 'add_exam_state.dart';

class AddExamCubit extends Cubit<AddExamState> {
  final TeacherExamsRepo teacherExamsRepo;

  AddExamCubit(this.teacherExamsRepo) : super(AddExamInitial());

  Future<void> addExam(AddExamRequest request, {List<PlatformFile>? files}) async {
    emit(AddExamLoading());
    final result = await teacherExamsRepo.addExam(request);

    await result.fold(
      (failure) async => emit(AddExamFailure(failure.errorMessage)),
      (examId) async {
        if (files != null && files.isNotEmpty) {
          final uploadResult = await teacherExamsRepo.uploadExamFiles(
            examId: examId,
            files: files,
          );

          uploadResult.fold(
            (failure) => emit(AddExamFailure('File upload failed: ${failure.errorMessage}')),
            (_) => emit(AddExamSuccess(examId)),
          );
        } else {
          emit(AddExamSuccess(examId));
        }
      },
    );
  }
}
