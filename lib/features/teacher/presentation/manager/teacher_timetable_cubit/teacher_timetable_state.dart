import 'package:school_system/core/api/api_errors.dart';
import 'package:school_system/features/teacher/data/models/teacher_timetable_entry_model.dart';

abstract class TeacherTimetableState {}

class TeacherTimetableInitial extends TeacherTimetableState {}

class TeacherTimetableLoading extends TeacherTimetableState {}

class TeacherTimetableSuccess extends TeacherTimetableState {
  final List<TeacherTimetableEntryModel> classes;

  TeacherTimetableSuccess(this.classes);
}

class TeacherTimetableFailure extends TeacherTimetableState {
  final ApiErrors error;

  TeacherTimetableFailure(this.error);
}
