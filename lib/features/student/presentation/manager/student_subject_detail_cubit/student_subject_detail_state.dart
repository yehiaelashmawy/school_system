import 'package:school_system/core/api/api_errors.dart';
import 'package:school_system/features/student/data/models/student_my_subjects_model.dart';

abstract class StudentSubjectDetailState {}

class StudentSubjectDetailInitial extends StudentSubjectDetailState {}

class StudentSubjectDetailLoading extends StudentSubjectDetailState {}

class StudentSubjectDetailSuccess extends StudentSubjectDetailState {
  final StudentMySubjectDetail data;
  StudentSubjectDetailSuccess(this.data);
}

class StudentSubjectDetailFailure extends StudentSubjectDetailState {
  final ApiErrors error;
  StudentSubjectDetailFailure(this.error);
}
