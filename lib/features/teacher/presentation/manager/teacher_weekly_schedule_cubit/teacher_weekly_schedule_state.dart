import 'package:school_system/core/api/api_errors.dart';
import 'package:school_system/features/teacher/data/models/teacher_timetable_entry_model.dart';

abstract class TeacherWeeklyScheduleState {}

class TeacherWeeklyScheduleInitial extends TeacherWeeklyScheduleState {}

class TeacherWeeklyScheduleLoading extends TeacherWeeklyScheduleState {}

class TeacherWeeklyScheduleSuccess extends TeacherWeeklyScheduleState {
  final Map<String, List<TeacherTimetableEntryModel>> weeklySchedule;

  TeacherWeeklyScheduleSuccess(this.weeklySchedule);
}

class TeacherWeeklyScheduleFailure extends TeacherWeeklyScheduleState {
  final ApiErrors error;

  TeacherWeeklyScheduleFailure(this.error);
}
