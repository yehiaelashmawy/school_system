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
    required List<Map<String, dynamic>> materials,
  }) async {
    emit(AddLessonLoading());
    final result = await repo.createLesson(
      title: title,
      description: description,
      date: date,
      startTime: startTime,
      endTime: endTime,
      classOid: classOid,
      subjectOid: subjectOid,
      type: type,
      objectives: objectives,
      materials: materials,
    );
    result.fold(
      (error) => emit(AddLessonFailure(error.errorMessage)),
      (success) => emit(AddLessonSuccess(success)),
    );
  }
}
