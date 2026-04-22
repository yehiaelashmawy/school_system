import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_system/features/student/data/repos/student_weekly_schedule_repo.dart';
import 'student_weekly_schedule_state.dart';

class StudentWeeklyScheduleCubit extends Cubit<StudentWeeklyScheduleState> {
  final StudentWeeklyScheduleRepo _repo;

  StudentWeeklyScheduleCubit(this._repo) : super(StudentWeeklyScheduleInitial());

  Future<void> fetchWeeklySchedule() async {
    emit(StudentWeeklyScheduleLoading());
    final result = await _repo.fetchWeeklySchedule();
    result.fold(
      (error) => emit(StudentWeeklyScheduleFailure(error)),
      (data) => emit(StudentWeeklyScheduleSuccess(data)),
    );
  }
}
