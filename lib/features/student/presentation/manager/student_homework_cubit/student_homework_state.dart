import 'package:school_system/core/api/api_errors.dart';
import 'package:school_system/features/student/data/models/student_homework_model.dart';

abstract class StudentHomeworkState {}

class StudentHomeworkInitial extends StudentHomeworkState {}

class StudentHomeworkLoading extends StudentHomeworkState {}

class StudentHomeworkSuccess extends StudentHomeworkState {
  final StudentHomeworkDataModel data;

  StudentHomeworkSuccess(this.data);
}

class StudentHomeworkFailure extends StudentHomeworkState {
  final ApiErrors error;

  StudentHomeworkFailure(this.error);
}
