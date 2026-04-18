import 'package:school_system/core/api/api_errors.dart';
import 'package:school_system/features/teacher/data/models/teacher_subject_model.dart';

abstract class TeacherSubjectsState {}

class TeacherSubjectsInitial extends TeacherSubjectsState {}

class TeacherSubjectsLoading extends TeacherSubjectsState {}

class TeacherSubjectsSuccess extends TeacherSubjectsState {
  final List<TeacherSubjectModel> subjects;

  TeacherSubjectsSuccess(this.subjects);
}

class TeacherSubjectsFailure extends TeacherSubjectsState {
  final ApiErrors error;

  TeacherSubjectsFailure(this.error);
}
