import 'package:school_system/core/api/api_errors.dart';
import 'package:school_system/features/teacher/data/models/attendance_session_model.dart';

abstract class StartAttendanceState {}

class StartAttendanceInitial extends StartAttendanceState {}

class StartAttendanceLoading extends StartAttendanceState {}

class StartAttendanceSuccess extends StartAttendanceState {
  final AttendanceSessionModel session;
  StartAttendanceSuccess(this.session);
}

class StartAttendanceFailure extends StartAttendanceState {
  final ApiErrors failure;
  StartAttendanceFailure(this.failure);
}
