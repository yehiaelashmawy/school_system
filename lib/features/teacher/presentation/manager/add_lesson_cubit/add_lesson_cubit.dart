import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_system/features/teacher/data/repos/add_lesson_repo.dart';
import 'package:school_system/features/teacher/presentation/manager/add_lesson_cubit/add_lesson_state.dart';

class AddLessonCubit extends Cubit<AddLessonState> {
  final AddLessonRepo repo;

  AddLessonCubit(this.repo) : super(AddLessonInitial());

  Future<void> createLesson({
    required String title,
    required String description,
    required String date,
    required String startTime,
    required String endTime,
    required String classOid,
    required String subjectOid,
    required int type,
    required List<String> objectives,
    List<PlatformFile> attachedFiles = const [],
  }) async {
    emit(AddLessonLoading());

    final createResult = await repo.createLesson(
      title: title,
      description: description,
      date: date,
      startTime: startTime,
      endTime: endTime,
      classOid: classOid,
      subjectOid: subjectOid,
      type: type,
      objectives: objectives,
    );

    await createResult.fold(
      (error) async {
        emit(AddLessonFailure(error.errorMessage));
      },
      (lessonOid) async {
        // ✅ طالما وصلنا هنا يبقى عندنا OID مضمون
        if (attachedFiles.isNotEmpty) {
          final uploadResult = await repo.uploadLessonFiles(
            lessonId: lessonOid,
            files: attachedFiles,
          );

          if (uploadResult.isLeft()) {
            final error = uploadResult.fold((l) => l.errorMessage, (_) => '');
            emit(AddLessonFailure('File upload failed: $error'));
            return;
          }
        }

        emit(AddLessonSuccess('Lesson published successfully'));
      },
    );
  }
}
