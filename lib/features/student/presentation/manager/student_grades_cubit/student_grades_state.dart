import 'package:school_system/core/api/api_errors.dart';
import 'package:school_system/features/student/data/models/student_grades_model.dart';

abstract class StudentGradesState {}

class StudentGradesInitial extends StudentGradesState {}

class StudentGradesLoading extends StudentGradesState {}

class StudentGradesSuccess extends StudentGradesState {
  final StudentGradesDataModel data;
  StudentGradesSuccess(this.data);
}

class StudentGradesFailure extends StudentGradesState {
  final ApiErrors error;
  StudentGradesFailure(this.error);
}
