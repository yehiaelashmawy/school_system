import 'package:school_system/core/api/api_errors.dart';
import 'package:school_system/features/teacher/data/models/teacher_exam_model.dart';

abstract class TeacherExamsState {}

class TeacherExamsInitial extends TeacherExamsState {}

class TeacherExamsLoading extends TeacherExamsState {}

class TeacherExamsSuccess extends TeacherExamsState {
  final List<TeacherExamModel> exams;
  TeacherExamsSuccess(this.exams);
}

class TeacherExamsFailure extends TeacherExamsState {
  final ApiErrors error;
  TeacherExamsFailure(this.error);
}
