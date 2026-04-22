import 'package:school_system/core/api/api_errors.dart';
import 'package:school_system/features/student/data/models/student_weekly_schedule_model.dart';

abstract class StudentWeeklyScheduleState {}

class StudentWeeklyScheduleInitial extends StudentWeeklyScheduleState {}

class StudentWeeklyScheduleLoading extends StudentWeeklyScheduleState {}

class StudentWeeklyScheduleSuccess extends StudentWeeklyScheduleState {
  final StudentWeeklyScheduleData data;
  StudentWeeklyScheduleSuccess(this.data);
}

class StudentWeeklyScheduleFailure extends StudentWeeklyScheduleState {
  final ApiErrors error;
  StudentWeeklyScheduleFailure(this.error);
}
