import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_system/features/teacher/data/repos/teacher_timetable_repo.dart';
import 'teacher_weekly_schedule_state.dart';

class TeacherWeeklyScheduleCubit extends Cubit<TeacherWeeklyScheduleState> {
  final TeacherTimetableRepo _repo;

  TeacherWeeklyScheduleCubit(this._repo) : super(TeacherWeeklyScheduleInitial());

  Future<void> fetchWeeklySchedule(String teacherOid) async {
    emit(TeacherWeeklyScheduleLoading());
    final result = await _repo.getWeeklyClassesForTeacher(teacherOid);
    result.fold(
      (error) => emit(TeacherWeeklyScheduleFailure(error)),
      (data) => emit(TeacherWeeklyScheduleSuccess(data)),
    );
  }
}
