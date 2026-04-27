import 'package:school_system/core/api/api_errors.dart';
import 'package:school_system/features/student/data/models/student_lesson_detail_model.dart';

abstract class StudentLessonDetailState {}

class StudentLessonDetailInitial extends StudentLessonDetailState {}

class StudentLessonDetailLoading extends StudentLessonDetailState {}

class StudentLessonDetailSuccess extends StudentLessonDetailState {
  final StudentLessonDetailModel lesson;

  StudentLessonDetailSuccess(this.lesson);
}

class StudentLessonDetailFailure extends StudentLessonDetailState {
  final ApiErrors error;

  StudentLessonDetailFailure(this.error);
}
