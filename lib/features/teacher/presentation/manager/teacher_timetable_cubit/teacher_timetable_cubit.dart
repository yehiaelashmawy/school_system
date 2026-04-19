import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_system/features/teacher/data/repos/teacher_timetable_repo.dart';
import 'package:school_system/features/teacher/presentation/manager/teacher_timetable_cubit/teacher_timetable_state.dart';

class TeacherTimetableCubit extends Cubit<TeacherTimetableState> {
  final TeacherTimetableRepo repo;

  TeacherTimetableCubit(this.repo) : super(TeacherTimetableInitial());

  Future<void> fetchTodayClasses(String teacherOid) async {
    emit(TeacherTimetableLoading());
    final result = await repo.getTodayClassesForTeacher(teacherOid);
    result.fold(
      (error) => emit(TeacherTimetableFailure(error)),
      (classes) => emit(TeacherTimetableSuccess(classes)),
    );
  }
}
